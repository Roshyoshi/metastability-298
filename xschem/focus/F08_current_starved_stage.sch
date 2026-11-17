v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {/home/oshan/metastability-298/xschem/sym/pmos3.sym} 0 60 0 0 {name=MP model=pfet_05v0 W=1.22u L=0.5u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 0 260 0 0 {name=MN model=nfet_05v0 W=0.82u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 0 360 0 0 {name=MC model=nfet_05v0 W=0.36u L=0.6u spiceprefix=X}
C {/home/oshan/metastability-298/xschem/sym/nmos3.sym} 180 360 0 0 {name=MCT model=nfet_06v0 W=0.82u L=1u spiceprefix=X}
N -160 0 400 0 {lab=VDD}
C {devices/lab_pin.sym} -160 0 0 0 {name=l1 lab=VDD}
N -160 420 400 420 {lab=VSS}
C {devices/lab_pin.sym} -160 420 0 0 {name=l2 lab=VSS}
N 20 30 20 0 {lab=VDD}
N 20 390 20 420 {lab=VSS}
N 200 390 200 420 {lab=VSS}
N 20 90 20 230 {lab=slow}
N 20 230 160 230 {lab=slow}
N 160 230 160 160 {lab=slow}
N 160 230 160 360 {lab=slow}
N 160 160 360 160 {lab=slow}
N -20 60 -20 140 {lab=launch}
N -20 140 -20 260 {lab=launch}
N -20 140 -120 140 {lab=launch}
N -20 360 -120 360 {lab=ua_0}
N -120 360 -120 180 {lab=ua_0}
N 240 420 240 330 {lab=VSS}
N 240 330 200 330 {lab=VSS}
N 20 290 20 330 {lab=foot}
C {devices/ipin.sym} -120 140 0 0 {name=p_launch lab=launch}
C {devices/ipin.sym} -120 180 0 0 {name=p_ua_0 lab=ua_0}
C {devices/opin.sym} 360 160 0 0 {name=p_slow lab=slow}
L 3 -40 -40 80 -40 {}
L 3 -40 -40 -40 -28 {}
L 3 80 -40 80 -28 {}
T {starved pull-down MN + MC} -40 -61.8932 0 0 0.3 0.3 {layer=3}
L 3 140 -90 260 -90 {}
L 3 140 -90 140 -78 {}
L 3 260 -90 260 -78 {}
T {MCT: timing capacitor} 140 -111.893 0 0 0.3 0.3 {layer=3}
T {F08  current-starved stage of the delay line: MP, MN, MC and the timing capacitor MCT} -180 -229.382 0 0 0.45 0.45 {}
T {launch rises -> MN turns on -> slow discharges through MN and MC. The gate voltage ua[0] on MC limits that current,} -180 -186.543 0 0 0.24 0.24 {}
T {so ua[0] sets how fast slow falls, i.e. the delay d. MCT (gate on slow) is the charge that has to be removed.} -180 -167.218 0 0 0.24 0.24 {}
N -120 470 -20 470 {lab=ua_0}
C {devices/lab_wire.sym} -20 470 0 0 {name=l3 lab=ua_0}
T {ua[0]: analog control voltage} 10 460.843 0 0 0.24 0.24 {}
N -120 510 -20 510 {lab=slow}
C {devices/lab_wire.sym} -20 510 0 0 {name=l4 lab=slow}
T {slow: the ramp that sets d} 10 500.843 0 0 0.24 0.24 {}
T {Rails: VDD at the top, VSS at the bottom; every PMOS body is on VDD and every NMOS body on VSS (drawn inside the symbol). A dot marks a connection; wires that cross without a dot are not connected.} -120 544 0 0 0.2 0.2 {}
