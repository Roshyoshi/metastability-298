"""Screen whether the nominal keeper result survives selected PVT/parasitics.

Fifteen PVT combinations, not a Cartesian signoff grid. AC unstable-mode tau,
not a statistical output-observer measurement. Failures remain explicit.
"""
from pathlib import Path
import json
import engine as e
from run_nand import config,VARIANTS
ROOT=Path(__file__).resolve().parents[1]
rows=[]
cases=[]
for corner in ['typical','ss','ff','sf','fs']:
    for vdd,temp in [(3.3,25),(3.0,125),(3.6,-40)]:
        cases.append((f'{corner}_{vdd:g}_{temp:g}',dict(corner=corner,vdd=vdd,temp=temp)))
for diffusion in [0,.25,1.]:cases.append((f'diffusion_{diffusion:g}',dict(diffusion=diffusion)))
cases.append(('no_junction_or_wire',dict(diffusion=0,nodecap=0,mutualcap=0)))
for condition,kwargs in cases:
    for variant in VARIANTS:
        tag='sensitivity_'+condition+'_'+variant
        try:
            r=e.characterize(config(variant,**kwargs),tag,False)
            rows.append({'condition':condition,'variant':variant,'status':'simulated',**r})
        except Exception as exc:
            rows.append({'condition':condition,'variant':variant,'status':'failed','error':str(exc)})
        destination = ROOT/'results/nand_sensitivity.json'
        temporary = destination.with_suffix('.tmp')
        temporary.write_text(json.dumps(rows,indent=2))
        temporary.replace(destination)
assert len(rows) == len(cases)*len(VARIANTS)
assert len({(r['condition'],r['variant']) for r in rows}) == len(rows)
print('Completed',len(rows),'cases; failures',sum(r['status']=='failed' for r in rows),flush=True)
