#!/usr/bin/env python3
"""Export importable SPICE subcircuits with explicit pre-layout geometry."""
from pathlib import Path
import re,json
ROOT=Path(__file__).resolve().parents[1]
parts=['* Derived from pinned GF180 CDL; estimated rectangular junctions, not PEX.\n']
for file in sorted((ROOT/'vendor/cells').glob('*.cdl')):
    lines=[]
    for line in file.read_text().splitlines():
        if line.upper().startswith('.SUBCKT'):
            fields=line.split();fields[1]=file.stem;line=' '.join(fields)
        elif line.startswith('M'):
            f=line.split();pars={k:float(v) for k,v in (s.split('=') for s in f[6:])}
            w=pars['W'];area=w*.5e-6;per=2*(w+.5e-6)
            f[5]={'nfet_05v0':'nmos_6p0','pfet_05v0':'pmos_6p0'}[f[5]]
            line=' '.join(f)+f' ad={area:.16g} as={area:.16g} pd={per:.16g} ps={per:.16g}'
        lines.append(line)
    parts.append('\n'.join(lines)+'\n')
(ROOT/'spice/cells_estimated.sp').write_text('\n'.join(parts))
parts=['* Schematic-level frontend; no extracted layout or pad absolute ratings.\n']
for tag,fw,kp in [('baseline',2,1),('keeper',2,2),('forward',4,1)]:
    parts.append(f'.subckt meta_{tag} d cap q vdd vss\n')
    inst=[('inv_1','ci','cap cn'),('nand2_1','g1','d cn g1'),('nand2_1','g2','g1 cn g2'),
          (f'nand2_{fw}','fw','mqb g1 mq'),(f'nand2_{kp}','kp','mq g2 mqb'),
          ('nand2_1','s1','mq cap s1'),('nand2_1','s2','s1 cap s2'),
          ('nand2_1','sq','sqb s1 q'),('nand2_1','sqb','q s2 sqb')]
    for cell,name,pins in inst:parts.append(f'X{name} {pins} vdd vdd vss vss {cell}\n')
    parts.append('Cmq mq vss .25f\nCmqb mqb vss .25f\nCmut mq mqb .05f\n.ends\n')
parts.append('''
.subckt meta_delay_analog launch control sample_clk vdd vss
Mp slow launch vdd vdd pmos_6p0 w=1.22u l=.5u ad=.61p as=.61p pd=3.44u ps=3.44u
Mn slow launch foot vss nmos_6p0 w=.82u l=.6u ad=.41p as=.41p pd=2.64u ps=2.64u
Mc foot control vss vss nmos_6p0 w=.36u l=.6u ad=.18p as=.18p pd=1.72u ps=1.72u
Ctiming slow vss 2f
Xr0 slow r0 vdd vdd vss vss inv_1
Xr1 r0 r1 vdd vdd vss vss inv_2
Xr2 r1 sample_clk vdd vdd vss vss inv_2
.ends

.subckt meta_monitor i o vdd vss
Xa i n vdd vdd vss vss inv_1
Xb n o vdd vdd vss vss inv_2
.ends

.subckt meta_frontend d cap s0 s1 control selected early capmon earlymon vdd vss
Xlib d cap q0 vdd vdd vss vss dffq_1
Xbase d cap q1 vdd vss meta_baseline
Xkeeper d cap q2 vdd vss meta_keeper
Xforward d cap q3 vdd vss meta_forward
Xselect q0 q1 q2 q3 s0 s1 selected vdd vdd vss vss mux4_1
Xdelay cap control eclk vdd vss meta_delay_analog
Xearly selected eclk early vdd vdd vss vss dffq_1
Xmon0 cap capmon vdd vss meta_monitor
Xmon1 eclk earlymon vdd vss meta_monitor
.ends
''')
(ROOT/'spice/frontend.sp').write_text(''.join(parts))
print('Exported cells_estimated.sp and frontend.sp')
