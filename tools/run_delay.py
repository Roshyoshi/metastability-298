#!/usr/bin/env python3
"""Test the archived interleaving claim and a one-pin fine-delay alternative."""
from pathlib import Path
import json, gzip, argparse
import numpy as np
import engine as e

ROOT=Path(__file__).resolve().parents[1]

def emit_devices(devices,cfg):
    lines=[]
    for name,d,g,s,b,model,w,l in devices:
        area=w*cfg.diffusion*1e-6;per=2*(w+cfg.diffusion*1e-6)
        lines.append(f'{name} {d} {g} {s} {b} {model} w={w:.17g} l={l:.17g} ad={area:.17g} as={area:.17g} pd={per:.17g} ps={per:.17g}')
    return '\n'.join(lines)+'\n'

def header(cfg):
    return (f'GF180 delay bench - explicit pre-layout reconstruction\n'
            f".lib '{ROOT/'vendor/models/sm141064.ngspice'}' {cfg.corner}\n"
            '.param sw_stat_global=0 sw_stat_mismatch=0 fnoicor=0\n'
            f'.temp {cfg.temp}\n'
            '.options method=gear reltol=1e-6 abstol=1e-14 vntol=1e-8 gmin=1e-12 itl4=100\n'
            f'VDD vdd 0 {cfg.vdd}\n'
            f'Vlaunch launch 0 PWL(0 0 1n 0 1.05n {cfg.vdd} 8n {cfg.vdd})\n')

def run(tag,deck,signals,cfg,polarity=1,keep=False):
    path=e.RUNS/(tag+'.dat')
    e.run(tag,deck+e.control('tran 1p 8n 0 1p\nwrdata '+str(path)+' '+' '.join(signals)))
    a=np.loadtxt(path,skiprows=1)
    if a[-1,0]<7.999e-9 or not np.isfinite(a).all():raise RuntimeError('Bad trace '+tag)
    y=a[:,1]
    def crossing(level):
        ix=np.flatnonzero((a[:-1,0]>1e-9)&(polarity*(y[:-1]-level)<0)&(polarity*(y[1:]-level)>=0))
        if not len(ix):return None
        i=ix[0]
        return a[i,0]+(level-y[i])*(a[i+1,0]-a[i,0])/(y[i+1]-y[i])
    mid=crossing(cfg.vdd/2);lo=crossing(.1*cfg.vdd);hi=crossing(.9*cfg.vdd)
    row={'delay_ps':None if mid is None else float((mid-1.025e-9)*1e12),
         'slew_10_90_ps':None if lo is None or hi is None else float(abs(hi-lo)*1e12)}
    if keep:
        with gzip.open(str(path)+'.gz','wb') as f:f.write(path.read_bytes())
        row['trace']=str(path.relative_to(ROOT))+'.gz'
    path.unlink()
    return row

def interleaved(cfg):
    devices=[]
    def inst(cell,name,*pins): devices.extend(e.cell_devices(cell,name,list(pins)+['vdd','vdd','0','0'],cfg))
    taps=[]
    inst('inv_1','offset','launch','bstart')
    for chain,start in [('a','launch'),('b','bstart')]:
        previous=start
        for n in range(8):
            out=chain+str(n);inst('inv_1',out,previous,out);previous=out;taps.append(out)
    for n in range(4):inst('mux4_1','mux'+str(n),*taps[4*n:4*n+4],'sel0','sel1','mux'+str(n))
    inst('mux4_1','final','mux0','mux1','mux2','mux3','sel2','sel3','out')
    inst('dffq_1','positive_observer','0','out','pos_q')
    inst('dffnq_1','negative_observer','0','out','neg_q')
    results=[]
    for code in range(16):
        deck=header(cfg)+emit_devices(devices,cfg)
        for bit in range(4):deck+=f'Vsel{bit} sel{bit} 0 {cfg.vdd*((code>>bit)&1)}\n'
        depth=(code%8)+1+(code//8)
        row=run(f'interleaved_{cfg.corner}_{code:02}',deck,['v(out)'],cfg,1 if depth%2==0 else -1,True)
        row.update(code=code,chain='A' if code<8 else 'B',stages=depth,polarity='rise' if depth%2==0 else 'fall')
        results.append(row)
    return results

def analog_delay(cfg,voltage):
    devices=[]
    # A rising launch turns on the discharge path. The analog-controlled footer
    # sets current; three inverters restore a positive, full-swing sample edge.
    devices += [('msp','slow','launch','vdd','vdd','pmos_6p0',1.22e-6,.5e-6),
                ('msn','slow','launch','foot','0','nmos_6p0',.82e-6,.6e-6),
                ('mctrl','foot','vctrl','0','0','nmos_6p0',.36e-6,.6e-6)]
    for cell,name,pins in [('inv_1','restore0',['slow','r0']),('inv_2','restore1',['r0','r1']),('inv_2','restore2',['r1','out']),('dffq_1','observer',['0','out','sample']),('inv_1','monitor0',['out','monb']),('inv_2','monitor1',['monb','monitor'])]:
        devices.extend(e.cell_devices(cell,name,pins+['vdd','vdd','0','0'],cfg))
    # Ideal 2 fF is an explicit design target, not an extracted/manufactured cap.
    deck=header(cfg)+emit_devices(devices,cfg)+f'Vbias pad 0 {voltage}\nRanalog pad vctrl 500\nCanalog vctrl 0 5p\nCtiming slow 0 2f\n'
    row=run(f'analog_rc_{cfg.corner}_{cfg.vdd:g}_{cfg.temp:g}_{voltage:g}',deck,['v(out)','v(slow)','v(vctrl)','i(vbias)','v(monitor)'],cfg,1,True)
    row.update(corner=cfg.corner,vdd_V=cfg.vdd,temp_C=cfg.temp,control_V=voltage)
    return row

if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--only',choices=['all','analog'],default='all');args=parser.parse_args()
    cfg=e.Config()
    if args.only=='all':
        digital=interleaved(cfg)
        (ROOT/'results/delay_interleaved.json').write_text(json.dumps(digital,indent=2))
    analog=[]
    for corner,vdd,temp in [('typical',3.3,25),('ss',3.0,125),('ff',3.6,-40)]:
        cfg=e.Config(corner=corner,vdd=vdd,temp=temp)
        for voltage in [.9,1.1,1.3,1.5,1.8,2.1,2.4,2.7,3.0]:
            row=analog_delay(cfg,voltage);analog.append(row);print(json.dumps(row),flush=True)
    (ROOT/'results/delay_analog.json').write_text(json.dumps(analog,indent=2))
