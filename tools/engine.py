"""Reproducible pre-layout GF180 metastability comparison.

Foundry BSIM4 models; published dffq_1 topology and dimensions.
Junction areas/perimeters are explicit rectangular estimates, NOT extracted layout.
No assertion of silicon performance, routed fit, or novelty follows from this script.
"""
from pathlib import Path
import os, re, json, subprocess, shutil
from dataclasses import dataclass
import numpy as np
from scipy.optimize import brentq
from scipy.linalg import eig
from concurrent.futures import ThreadPoolExecutor

ROOT = Path(__file__).resolve().parent
_local_bin = ROOT/'tools/ngspice/usr/bin/ngspice'
BIN = Path(os.environ.get('NGSPICE_BIN', str(_local_bin) if _local_bin.exists() else (shutil.which('ngspice') or 'ngspice')))
ENV = {**os.environ, 'LD_LIBRARY_PATH':str(ROOT/'tools/ngspice/usr/lib/x86_64-linux-gnu')+':'+os.environ.get('LD_LIBRARY_PATH','')}
RUNS = ROOT.parent/'results/spice'
RUNS.mkdir(exist_ok=True)

@dataclass
class Config:
    kind: str = 'base'
    scale: float = 1.0
    inverter_scale: float = 1.0
    feedback_scale: float = 1.0
    helper: float = 0.36 # microns, each of 8 helper MOS widths
    corner: str = 'typical'
    vdd: float = 3.3
    temp: float = 25
    diffusion: float = 0.5 # microns each terminal's rectangular diffusion length
    nodecap: float = 0.25 # fF to ground per master node, assumed wiring
    mutualcap: float = 0.05 # fF between master nodes, assumed wiring
    extra_load: float = 0 # fF per master node, deliberately added controls
    load: float = 2.0 # fF at Q
    fine: bool = False

def legacy_transistors(cfg):
    result = []
    for line in (ROOT.parent/'vendor/models/dffq.cdl').read_text().splitlines():
        if not line.startswith('M_'): continue
        name,d,g,s,b,model,wp,lp = line.split()
        w,l = float(wp[2:]),float(lp[2:])
        if cfg.kind=='resize' and name in ['M_tn0','M_tp0','M_tn6','M_tn7','M_tp6','M_tp5']:
            w *= cfg.scale
        if cfg.kind=='selective':
            if name in ['M_tn0','M_tp0']: w *= cfg.inverter_scale
            if name in ['M_tn6','M_tn7','M_tp6','M_tp5']: w *= cfg.feedback_scale
        if cfg.kind=='feedback_resize' and name in ['M_tn6','M_tn7','M_tp6','M_tp5']:
            w *= cfg.scale
        if cfg.kind=='inverter_resize' and name in ['M_tn0','M_tp0']:
            w *= cfg.scale
        if cfg.kind=='slave_reduce' and name in ['M_tn10','M_tp8']:
            w = max(0.30e-6,w*cfg.scale)
        result.append((name.lower(),*[{'vss':'0','vpw':'0','vnw':'vdd'}.get(x.lower(),x.lower()) for x in [d,g,s,b]],'nmos_6p0' if model.startswith('n') else 'pmos_6p0',w,l))
    if cfg.kind=='helper':
        w=cfg.helper*1e-6
        # Each clocked inverter: rail--signal-gated transistor--clock transistor--output.
        # Same source/drain ordering as the published master feedback branch.
        for tag,inn,out in [('h1','net0','net4'),('h2','net4','net0')]:
            result.extend([
                (f'm{tag}ns','0',inn,f'{tag}n','0','nmos_6p0',w,.6e-6),
                (f'm{tag}nc',f'{tag}n','cki',out,'0','nmos_6p0',w,.6e-6),
                (f'm{tag}ps','vdd',inn,f'{tag}p','vdd','pmos_6p0',w,.5e-6),
                (f'm{tag}pc',f'{tag}p','ncki',out,'vdd','pmos_6p0',w,.5e-6),
            ])
    return result


def cell_devices(cell, instance, connections, cfg):
    """Flatten an unmodified public CDL cell; add documented junction estimates."""
    path=ROOT.parent/'vendor/cells'/(cell+'.cdl')
    lines=path.read_text().splitlines()
    header=next(line for line in lines if line.upper().startswith('.SUBCKT'))
    pins=header.split()[2:]
    ports=dict(zip(pins,connections))
    if len(pins)!=len(connections): raise ValueError((cell,pins,connections))
    def node(n): return ports.get(n, instance+'_'+n.lower())
    result=[]
    for line in lines:
        if not line.startswith('M'): continue
        name,d,g,s,b,model,*params=line.split()
        par={k.lower():float(v) for k,v in (item.split('=') for item in params)}
        model={'nfet_05v0':'nmos_6p0','pfet_05v0':'pmos_6p0'}[model]
        result.append(('m'+instance+'_'+name.lower(),node(d),node(g),node(s),node(b),model,par['w'],par['l']))
    return result

def transistors(cfg):
    if not cfg.kind.startswith('nand') and cfg.kind!='library_buffered':
        return legacy_transistors(cfg)
    result=[]
    def inst(cell,name,*pins):
        result.extend(cell_devices(cell,name,list(pins)+['vdd','vdd','0','0'],cfg))
    inst('inv_2','din0','d','dinb')
    inst('inv_2','din1','dinb','di')
    inst('inv_2','cin0','clk','cinb')
    inst('inv_2','cin1','cinb','ci')
    if cfg.kind=='library_buffered':
        # CDL dffq pin order is resolved explicitly from its header.
        hdr=next(l for l in (ROOT.parent/'vendor/cells/dffq_1.cdl').read_text().splitlines() if l.upper().startswith('.SUBCKT'))
        mapping={'D':'di','CLK':'ci','Q':'q','VDD':'vdd','VNW':'vdd','VPW':'0','VSS':'0'}
        result.extend(cell_devices('dffq_1','lib',[mapping[n] for n in hdr.split()[2:]],cfg))
        # Normalize the master-node names for the shared analysis routines.
        result=[(m[0],*[{'lib_net4':'net4','lib_net0':'net0'}.get(n,n) for n in m[1:5]],*m[5:]) for m in result]
    else:
        inst('inv_1','cki','ci','clkn')
        inst('nand2_1','mg1','di','clkn','g1')
        inst('nand2_1','mg2','g1','clkn','g2')
        inst('nand2_'+str(int(cfg.scale)),'mfw','net0','g1','net4')
        inst('nand2_'+str(int(cfg.feedback_scale)),'mkp','net4','g2','net0')
        inst('nand2_1','sg1','net4','ci','s1')
        inst('nand2_1','sg2','s1','ci','s2')
        inst('nand2_1','sfw','sqb','s1','q')
        inst('nand2_1','skp','q','s2','sqb')
    inst('inv_1','observer_load','q','q_load')
    return result

def nodes(cfg):
    return sorted({x for m in transistors(cfg) for x in m[1:5]}-{'0','vdd','d','clk'})

def circuit(cfg, stimulus='hold'):
    lines = ['GF180 metastability model comparison',f".lib '{ROOT.parent/'vendor/models/sm141064.ngspice'}' {cfg.corner}",
             '.param sw_stat_global=0 sw_stat_mismatch=0 fnoicor=0',
             f'.temp {cfg.temp}', '.options reltol=1e-8 abstol=1e-17 vntol=1e-10 gmin=1e-15 numdgt=16',
             f'VDD vdd 0 {cfg.vdd}']
    if stimulus=='hold': lines += [f'VCLK clk 0 {cfg.vdd}', 'VD d 0 0']
    for name,d,g,s,b,model,w,l in transistors(cfg):
        a=w*cfg.diffusion*1e-6
        p=2*(w+cfg.diffusion*1e-6) if cfg.diffusion else 0
        lines.append(f'{name} {d} {g} {s} {b} {model} w={w:.16g} l={l:.16g} ad={a:.16g} as={a:.16g} pd={p:.16g} ps={p:.16g}')
    for node in ['net4','net0']:
        if cfg.nodecap+cfg.extra_load: lines.append(f'C{node} {node} 0 {(cfg.nodecap+cfg.extra_load)*1e-15:.16g}')
    if cfg.mutualcap: lines.append(f'Cmut net4 net0 {cfg.mutualcap*1e-15:.16g}')
    lines += [f'CQ q 0 {cfg.load*1e-15:.16g}']
    return '\n'.join(lines)+'\n'

def run(name, content):
    path = RUNS/(name+'.cir')
    path.write_text(content)
    r=subprocess.run([str(BIN),'-b',str(path)],env=ENV,cwd=ROOT,text=True,capture_output=True,timeout=30)
    log=r.stdout+r.stderr
    (RUNS/(name+'.log')).write_text(log)
    if r.returncode or re.search(r'(?:^|\n)(?:Error|Fatal)|simulation\(s\) aborted',log,re.I):
        raise RuntimeError(name+': '+log[-5000:])
    return log

def control(commands):
    return '.control\nset noaskquit\nset numdgt=16\nset wr_singlescale\nset wr_vecnames\n'+commands+'\nquit\n.endc\n.end\n'

def clamp(cfg, value, tag='clamp'):
    ns=nodes(cfg)
    path=RUNS/(tag+'.dat')
    run(tag,circuit(cfg)+f'Vforce net4 0 {value:.17g}\n'+control('op\nwrdata '+str(path)+' i(vforce) '+' '.join('v('+n+')' for n in ns)))
    v=np.loadtxt(path,skiprows=1).reshape(-1)
    return float(v[1]),dict(zip(ns,v[2:]))

def equilibrium(cfg, tag):
    path=RUNS/(tag+'_dc.dat')
    run(tag+'_dc',circuit(cfg)+f'Vforce net4 0 {cfg.vdd/2}\n'+control(f'dc Vforce {cfg.vdd*.1} {cfg.vdd*.9} {cfg.vdd*.005}\nwrdata {path} i(vforce)'))
    data=np.loadtxt(path,skiprows=1)
    changes=np.where(np.signbit(data[:-1,1])!=np.signbit(data[1:,1]))[0]
    if len(changes)!=1: raise RuntimeError(f'{tag}: expected one interior equilibrium, got {changes}')
    i=changes[0]
    root=brentq(lambda x:clamp(cfg,x,tag+'_root')[0],data[i,0],data[i+1,0],xtol=1e-13)
    current,state=clamp(cfg,root,tag+'_eq')
    return state,current

def pole_ngspice(cfg, state, tag):
    path=RUNS/(tag+'_op.dat')
    ns=nodes(cfg)
    nset='.nodeset '+' '.join(f'v({n})={v:.16g}' for n,v in state.items())+'\n'
    log=run(tag+'_pz',circuit(cfg)+nset+control('op\nwrdata '+str(path)+' '+' '.join('v('+n+')' for n in ns)+'\npz net4 0 net4 0 cur pol\nprint all'))
    op=np.loadtxt(path,skiprows=1).reshape(-1)[1:]
    err=max(abs(op[i]-state[n]) for i,n in enumerate(ns))
    roots=[]
    for match in re.finditer(r'pole\([^)]*\)\s*=\s*([-+0-9.eE]+)(?:,\s*([-+0-9.eE]+))?',log):
        roots.append(complex(float(match[1]),float(match[2] or 0)))
    positive=[x for x in roots if x.real>0]
    if err>1e-5 or len(positive)!=1: raise RuntimeError(f'{tag}: op delta {err}; positive poles {positive}; log {log[-2500:]}')
    return 1/positive[0].real, roots, err

def pole(cfg, state, tag):
    # Form the complete internal-node small-signal admittance matrix with AC probes.
    # This avoids convergence limitations in ngspice's iterative PZ root finder.
    ns=nodes(cfg)
    freq=1e6
    def column(col):
        path=RUNS/(tag+f'_ac{col}.dat')
        forces=''.join(f'Vprobe{i} {node} 0 DC {state[node]:.17g} AC {int(i==col)}\n' for i,node in enumerate(ns))
        run(tag+f'_ac{col}',circuit(cfg)+forces+control(f'ac lin 1 {freq} {freq}\nwrdata {path} '+' '.join(f'i(vprobe{i})' for i in range(len(ns)))))
        raw=np.loadtxt(path,skiprows=1).reshape(-1)[1:]
        return -(raw[::2]+1j*raw[1::2])
    with ThreadPoolExecutor(max_workers=4) as ex:
        y=np.column_stack(list(ex.map(column,range(len(ns)))))
    k=y.real
    c=y.imag/(2*np.pi*freq)
    roots,vec=eig(-k,c)
    positive=[x for x in roots if np.isfinite(x) and x.real>1e5]
    if len(positive)!=1: raise RuntimeError(f'{tag}: positive poles {positive}; all {roots}')
    np.savez(RUNS/(tag+'_matrix.npz'),nodes=ns,G=k,C=c,eigenvalues=roots,eigenvectors=vec)
    return 1/positive[0].real, roots, 0.0

def transient(cfg,state,tag,sign=1):
    path=RUNS/(tag+'_tran.dat')
    ic=state.copy()
    ic['net4']+=sign*1e-5
    ic['net0']-=sign*1e-5
    init='.ic '+' '.join(f'v({n})={v:.17g}' for n,v in ic.items())+'\n'
    step='0.5p' if cfg.fine else '2p'
    run(tag+'_tran',circuit(cfg)+'.options method=gear reltol=1e-6 abstol=1e-14 vntol=1e-8 gmin=1e-12 itl4=100\n'+init+control(f'tran {step} 10n 0 {step}\nwrdata {path} v(net4) v(net0) v(q)'))
    data=np.loadtxt(path,skiprows=1)
    delta=np.abs((data[:,1]-state['net4'])-(data[:,2]-state['net0']))
    valid=(delta>1e-4)&(delta<1e-2)&(data[:,0]>2e-10)
    t=data[valid,0]; y=np.log(delta[valid])
    slope,offset=np.polyfit(t,y,1)
    rms=float(np.sqrt(np.mean((y-(slope*t+offset))**2)))
    return 1/slope,rms

def characterize(cfg,tag,trans=False):
    state,residual=equilibrium(cfg,tag)
    tau,poles,operr=pole(cfg,state,tag)
    result={'config':cfg.__dict__,'tag':tag,'tau_ps':tau*1e12,'equilibrium':state,
            'clamp_current_A':residual,'op_error_V':operr,'poles_per_s':[[r.real,r.imag] for r in poles],
            'total_width_um':sum(m[-2] for m in transistors(cfg))*1e6,
            'gate_area_um2':sum(m[-2]*m[-1] for m in transistors(cfg))*1e12}
    if trans:
        result['transient_checks']=[{'sign':s,'tau_ps':tt*1e12,'log_fit_rms':rms} for s in [1,-1] for tt,rms in [transient(cfg,state,tag+str(s),s)]]
    (RUNS/(tag+'.json')).write_text(json.dumps(result,indent=2))
    print(json.dumps({k:result[k] for k in ['tag','tau_ps','total_width_um','gate_area_um2']}),flush=True)
    return result

