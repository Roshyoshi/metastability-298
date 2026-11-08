v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {antenna: two reverse-biased diodes on I (protect the gate on I while the chip is fabricated)   (gf180mcu_fd_sc_mcu7t5v0 antenna: 2 diodes, no transistors)} 0 -190 0 0 0.4 0.4 {}
T {Both diodes are reverse biased for 0 <= V(I) <= VDD. Plasma charge collected by long metal on I during} 0 -160 0 0 0.25 0.25 {}
T {fabrication leaks to the substrate / n-well through them instead of stressing the gate oxide.} 0 -135 0 0 0.25 0.25 {}
C {devices/diode.sym} 100 0 0 0 {name=D0 model=diode_nd2ps_06v0 area="0.2052p pj=1.86u"}
C {devices/lab_pin.sym} 100 -30 0 0 {name=l1 lab=0}
C {devices/lab_pin.sym} 100 30 0 0 {name=l2 lab=I}
T {D0: N+ diffusion in the p-substrate, 0.2052p m2} 120 50 0 0 0.2 0.2 {}
C {devices/diode.sym} 400 0 0 0 {name=D1 model=diode_pd2nw_06v0 area="0.2052p pj=1.86u"}
C {devices/lab_pin.sym} 400 -30 0 0 {name=l3 lab=I}
C {devices/lab_pin.sym} 400 30 0 0 {name=l4 lab=VDD}
T {D1: P+ diffusion in the n-well, 0.2052p m2} 420 50 0 0 0.2 0.2 {}
T {ports} -40 120 0 0 0.25 0.25 {}
C {devices/ipin.sym} 0 150 0 0 {name=p5 lab=I}
