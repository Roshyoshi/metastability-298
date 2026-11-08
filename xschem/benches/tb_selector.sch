v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {tb_selector: Selector: each select code passes its own flip-flop output} -400 -260 0 0 0.45 0.45 {}
T {Expected: sel0_V = 3.3; sel1_V = 0.0; sel2_V = 3.3; sel3_V = 0.0} -400 -225 0 0 0.22 0.22 {}
C {devices/vsource.sym} -300 0 0 0 {name=vvdd value="3.3"}
C {devices/lab_pin.sym} -300 -30 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} -300 30 0 0 {name=gvvdd}
C {devices/vsource.sym} -180 0 0 0 {name=vs0 value="PWL(0 0 10n 0 10.1n 3.3 20n 3.3 20.1n 0 30n 0 30.1n 3.3)"}
C {devices/lab_pin.sym} -180 -30 0 0 {name=l2 lab=cfg_0}
C {devices/gnd.sym} -180 30 0 0 {name=gvs0}
C {devices/vsource.sym} -60 0 0 0 {name=vs1 value="PWL(0 0 20n 0 20.1n 3.3)"}
C {devices/lab_pin.sym} -60 -30 0 0 {name=l3 lab=cfg_1}
C {devices/gnd.sym} -60 30 0 0 {name=gvs1}
C {@@ROOT@@/blocks/selector.sym} 300 0 0 0 {name=xsel}
C {devices/lab_pin.sym} 220 -50 0 0 {name=l4 lab=cfg_0}
C {devices/lab_pin.sym} 220 -30 0 0 {name=l5 lab=cfg_1}
C {devices/lab_pin.sym} 220 -10 0 0 {name=l6 lab=VDD}
C {devices/lab_pin.sym} 220 10 0 0 {name=l7 lab=0}
C {devices/lab_pin.sym} 220 30 0 0 {name=l8 lab=VDD}
C {devices/lab_pin.sym} 220 50 0 0 {name=l9 lab=0}
C {devices/lab_pin.sym} 380 -50 0 1 {name=l10 lab=selected_q}
C {devices/code_shown.sym} 700 -150 0 0 {name=SIM only_toplevel=false value=".include /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/sm141064.ngspice diode_typical
.global VDD
.param sw_stat_global=0 sw_stat_mismatch=0
.control
set filetype=ascii
tran 10p 40n
meas tran s0 find v(selected_q) at=9n
echo RESULT sel0_V $&s0
meas tran s1 find v(selected_q) at=19n
echo RESULT sel1_V $&s1
meas tran s2 find v(selected_q) at=29n
echo RESULT sel2_V $&s2
meas tran s3 find v(selected_q) at=39n
echo RESULT sel3_V $&s3
wrdata tb_selector.dat v(cfg_0) v(cfg_1) v(selected_q)
.endc"}
