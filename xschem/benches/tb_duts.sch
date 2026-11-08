v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {tb_duts: Capture check and clock-to-output delay of all four flip-flops} -400 -260 0 0 0.45 0.45 {}
T {Expected: tcq_lib_ps = 712; tcq_base_ps = 406; tcq_keeper_ps = 406; tcq_forward_ps = 405} -400 -225 0 0 0.22 0.22 {}
C {devices/vsource.sym} -300 0 0 0 {name=vvdd value="3.3"}
C {devices/lab_pin.sym} -300 -30 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} -300 30 0 0 {name=gvvdd}
C {devices/vsource.sym} -180 0 0 0 {name=vcap value="PWL(0 0 1n 0 1.05n 3.3 2n 3.3 2.05n 0 5n 0 5.05n 3.3)"}
C {devices/lab_pin.sym} -180 -30 0 0 {name=l2 lab=capture}
C {devices/gnd.sym} -180 30 0 0 {name=gvcap}
C {devices/vsource.sym} -60 0 0 0 {name=vd value="PWL(0 0 2.975n 0 3.025n 3.3)"}
C {devices/lab_pin.sym} -60 -30 0 0 {name=l3 lab=ui_in_6}
C {devices/gnd.sym} -60 30 0 0 {name=gvd}
C {@@ROOT@@/blocks/data_input.sym} 200 0 0 0 {name=xdata}
C {devices/lab_pin.sym} 120 0 0 0 {name=l4 lab=ui_in_6}
C {devices/lab_pin.sym} 280 0 0 1 {name=l5 lab=data_local}
C {@@ROOT@@/blocks/capture_drivers.sym} 200 120 0 0 {name=xcapd}
C {devices/lab_pin.sym} 120 120 0 0 {name=l6 lab=capture}
C {devices/lab_pin.sym} 280 120 0 1 {name=l7 lab=capture_local}
C {@@ROOT@@/blocks/duts.sym} 520 60 0 0 {name=xduts}
C {devices/lab_pin.sym} 440 30 0 0 {name=l8 lab=capture_local}
C {devices/lab_pin.sym} 440 50 0 0 {name=l9 lab=data_local}
C {devices/lab_pin.sym} 600 30 0 1 {name=l10 lab=q_0}
C {devices/lab_pin.sym} 600 50 0 1 {name=l11 lab=q_1}
C {devices/lab_pin.sym} 600 70 0 1 {name=l12 lab=q_2}
C {devices/lab_pin.sym} 600 90 0 1 {name=l13 lab=q_3}
C {devices/capa.sym} 760 220 0 0 {name=cl0 value=2f m=1}
C {devices/lab_pin.sym} 760 190 0 0 {name=l14 lab=q_0}
C {devices/lab_pin.sym} 760 250 0 0 {name=l15 lab=0}
C {devices/capa.sym} 830 220 0 0 {name=cl1 value=2f m=1}
C {devices/lab_pin.sym} 830 190 0 0 {name=l16 lab=q_1}
C {devices/lab_pin.sym} 830 250 0 0 {name=l17 lab=0}
C {devices/capa.sym} 900 220 0 0 {name=cl2 value=2f m=1}
C {devices/lab_pin.sym} 900 190 0 0 {name=l18 lab=q_2}
C {devices/lab_pin.sym} 900 250 0 0 {name=l19 lab=0}
C {devices/capa.sym} 970 220 0 0 {name=cl3 value=2f m=1}
C {devices/lab_pin.sym} 970 190 0 0 {name=l20 lab=q_3}
C {devices/lab_pin.sym} 970 250 0 0 {name=l21 lab=0}
C {devices/code_shown.sym} 1000 -150 0 0 {name=SIM only_toplevel=false value=".include /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/sm141064.ngspice diode_typical
.global VDD
.param sw_stat_global=0 sw_stat_mismatch=0
.control
set filetype=ascii
tran 1p 8n
meas tran tcq0 trig v(capture_local) val=1.65 td=4n rise=1 targ v(q_0) val=1.65 td=4n rise=1
let tcq0ps=tcq0*1e12
echo RESULT tcq_lib_ps $&tcq0ps
meas tran tcq1 trig v(capture_local) val=1.65 td=4n rise=1 targ v(q_1) val=1.65 td=4n rise=1
let tcq1ps=tcq1*1e12
echo RESULT tcq_base_ps $&tcq1ps
meas tran tcq2 trig v(capture_local) val=1.65 td=4n rise=1 targ v(q_2) val=1.65 td=4n rise=1
let tcq2ps=tcq2*1e12
echo RESULT tcq_keeper_ps $&tcq2ps
meas tran tcq3 trig v(capture_local) val=1.65 td=4n rise=1 targ v(q_3) val=1.65 td=4n rise=1
let tcq3ps=tcq3*1e12
echo RESULT tcq_forward_ps $&tcq3ps
wrdata tb_duts.dat v(capture_local) v(data_local) v(q_0) v(q_1) v(q_2) v(q_3)
.endc"}
