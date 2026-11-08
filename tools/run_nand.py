#!/usr/bin/env python3
"""Reconstruct the September NAND proposal with pinned public GF180 CDL.

This is a new, explicit pre-layout model, not an exact replay of the unavailable
tau_gf180.py run. Every generated deck and simulator log is retained. Selected
waveforms are compressed; bisection traces are discarded after extracting the
recorded classifications. No thermal noise, mismatch, or extracted wiring.
"""
from pathlib import Path
import argparse, dataclasses, gzip, json, sys
import numpy as np
import engine as e

ROOT=Path(__file__).resolve().parents[1]
TC=5.025e-9
VARIANTS={'nand_baseline':(2,1),'nand_keeper':(2,2),'nand_forward':(4,1)}

def config(tag, **kwargs):
    if tag=='library': return e.Config(kind='library_buffered',**kwargs)
    fw,kp=VARIANTS[tag]
    return e.Config(kind='nand',scale=fw,feedback_scale=kp,**kwargs)

def capture(cfg, offset, direction, tag, step_ps, keep=False):
    old,new=(0,cfg.vdd) if direction==1 else (cfg.vdd,0)
    ds=TC+offset-25e-12
    source=(f'VCLK clk 0 PWL(0 0 1n 0 1.05n {cfg.vdd} 2n {cfg.vdd} 2.05n 0 5n 0 5.05n {cfg.vdd})\n'
            f'VD d 0 PWL(0 {old} {ds:.17g} {old} {ds+50e-12:.17g} {new})\n')
    path=e.RUNS/(tag+'.dat')
    options='.options method=gear reltol=1e-6 abstol=1e-14 vntol=1e-8 gmin=1e-12 itl4=100\n'
    step=step_ps*1e-12
    deck=e.circuit(cfg,stimulus='pulse')+options+source+e.control(
        f'tran {step:.17g} 12n 0 {step:.17g}\nwrdata {path} v(q) v(net4) v(net0) v(ci) v(di) i(vdd)')
    e.run(tag,deck)
    a=np.loadtxt(path,skiprows=1)
    if a.ndim!=2 or a[-1,0]<11.999e-9 or not np.isfinite(a).all():
        raise RuntimeError(f'Incomplete/nonfinite trace: {tag}')
    final=float(a[-1,1]); rail=int(final>0.9*cfg.vdd) if final>0.9*cfg.vdd or final<0.1*cfg.vdd else None
    if rail is None: raise RuntimeError(f'Unresolved final state: {tag}: {final}')
    def last_cross(values,threshold,after=TC):
        valid=np.flatnonzero((a[:-1,0]>=after)&((values[:-1]-threshold)*(values[1:]-threshold)<0))
        if not len(valid): return None
        k=valid[-1]
        return float((a[k,0]+(threshold-values[k])*(a[k+1,0]-a[k,0])/(values[k+1]-values[k])-TC)*1e12)
    row={'offset_ps':offset*1e12,'final_V':final,'final_bit':rail,
         'q_delay_ps':last_cross(a[:,1],cfg.vdd/2),
         'internal_resolution_ps':last_cross(np.abs(a[:,2]-a[:,3]),cfg.vdd/2),
         'local_clock_delay_ps':last_cross(a[:,4],cfg.vdd/2)}
    if keep:
        with path.open('rb') as src,gzip.open(str(path)+'.gz','wb') as dst: dst.write(src.read())
        row['trace']=str(path.relative_to(ROOT))+'.gz'
    path.unlink()
    return row

def line_fit(rows,key):
    pts=[r for r in rows if r[key] is not None]
    if len(pts)<6: return {'status':'insufficient crossings','points':len(pts)}
    x=np.log([r['distance_ps'] for r in pts]);y=np.array([r[key] for r in pts])
    slope,intercept=np.polyfit(x,y,1);res=y-(slope*x+intercept)
    return {'status':'fitted' if slope<0 else 'nonphysical slope',
            'tau_ps':float(-slope),'intercept_ps':float(intercept),
            'points':len(pts),'r2':float(1-np.sum(res**2)/np.sum((y-y.mean())**2)),
            'rms_ps':float(np.sqrt(np.mean(res**2)))}

def clocked(cfg,tag,step_ps,band='shallow',directions=(1,-1)):
    rows=[]
    for direction in directions:
        prefix=f'{tag}_d{direction}_s{step_ps:g}'+('' if band=='shallow' else '_deep')
        lo,hi=-1.2e-9,1.2e-9
        left=capture(cfg,lo,direction,prefix+'_left',step_ps)
        right=capture(cfg,hi,direction,prefix+'_right',step_ps)
        expected_new=int(direction==1)
        if left['final_bit']!=expected_new or right['final_bit']==expected_new:
            raise RuntimeError(f'Boundary not bracketed: {prefix}')
        bis=[]
        for i in range(28 if band=='shallow' else 34):
            mid=(lo+hi)/2
            row=capture(cfg,mid,direction,prefix+f'_bis{i:02}',step_ps)
            bis.append(row)
            if row['final_bit']==expected_new:lo=mid
            else:hi=mid
        crit=(lo+hi)/2
        branches={}
        for sign in [-1,1]:
            tail=[]
            distances=[.03,.05,.08,.13,.22,.36,.6,1.] if band=='shallow' else [.003,.005,.008,.013,.022,.036,.06,.1]
            for j,d in enumerate(distances):
                row=capture(cfg,crit+sign*d*1e-12,direction,prefix+f'_b{sign}_tail{j}',step_ps,True)
                row['distance_ps']=d;tail.append(row)
            branches[str(sign)]={'tail':tail,'internal_fit':line_fit(tail,'internal_resolution_ps'),
                                 'output_fit':line_fit(tail,'q_delay_ps')}
        good=capture(cfg,-1.2e-9,direction,prefix+'_normal',step_ps,True)
        out={'variant':tag,'config':dataclasses.asdict(cfg),'direction':direction,'maxstep_ps':step_ps,'band':band,
             'critical_offset_ps':crit*1e12,'bracket_width_fs':(hi-lo)*1e15,
             'bisection':bis,'normal':good,'branches':branches}
        rows.append(out)
        (ROOT/'results'/f'{prefix}.json').write_text(json.dumps(out,indent=2))
        print(json.dumps({k:out[k] for k in ['variant','direction','maxstep_ps','critical_offset_ps']}),flush=True)
        for sign,b in branches.items(): print(sign,b['internal_fit'],b['output_fit'],flush=True)
    return rows

def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--mode',choices=['dc','clocked'],default='dc')
    parser.add_argument('--step-ps',type=float,default=2.)
    parser.add_argument('--band',choices=['shallow','deep'],default='shallow')
    parser.add_argument('--directions',nargs='+',type=int,choices=[-1,1],default=[1,-1])
    parser.add_argument('--variants',nargs='+',default=list(VARIANTS))
    parser.add_argument('--corner',default='typical',choices=['typical','ss','ff','sf','fs'])
    parser.add_argument('--vdd',type=float,default=3.3)
    parser.add_argument('--temp',type=float,default=25.)
    args=parser.parse_args()
    results=[]
    for tag in args.variants:
        cfg=config(tag,corner=args.corner,vdd=args.vdd,temp=args.temp)
        condition='' if (args.corner,args.vdd,args.temp)==('typical',3.3,25.) else f'_{args.corner}_{args.vdd:g}_{args.temp:g}'
        if args.mode=='dc':results.append(e.characterize(cfg,tag+condition+'_dc',True))
        else:results.extend(clocked(cfg,tag+condition,args.step_ps,args.band,args.directions))
    suffix='' if args.band=='shallow' else '_deep'
    (ROOT/'results'/f'nand_{args.mode}_{args.step_ps:g}ps{condition}{suffix}.json').write_text(json.dumps(results,indent=2))

if __name__=='__main__':main()
