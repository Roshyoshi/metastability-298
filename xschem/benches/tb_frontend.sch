v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {tb_frontend: Front end: false event at ua[0] = 3.0 V, correct early sample at 1.41 V} -400 -260 0 0 0.45 0.45 {}
T {Expected: d_short_ps = 795 (bench without monitors; monitors add a few ps); arrive_ps = 901; early_short_V = 0.0; final_short_V = 3.3; d_allowed_ps = 1448 to 1458; early_allowed_V = 3.3; final_allowed_V = 3.3} -400 -225 0 0 0.22 0.22 {}
C {devices/vsource.sym} -400 0 0 0 {name=vvdd value="3.3"}
C {devices/lab_pin.sym} -400 -30 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} -400 30 0 0 {name=gvvdd}
C {devices/vsource.sym} -280 0 0 0 {name=vcap value="PWL(0 0 1n 0 1.05n 3.3 2n 3.3 2.05n 0 5n 0 5.05n 3.3)"}
C {devices/lab_pin.sym} -280 -30 0 0 {name=l2 lab=capture}
C {devices/gnd.sym} -280 30 0 0 {name=gvcap}
C {devices/vsource.sym} -160 0 0 0 {name=vd value="PWL(0 0 2.975n 0 3.025n 3.3)"}
C {devices/lab_pin.sym} -160 -30 0 0 {name=l3 lab=ui_in_6}
C {devices/gnd.sym} -160 30 0 0 {name=gvd}
C {devices/vsource.sym} -400 140 0 0 {name=vs0 value="3.3"}
C {devices/lab_pin.sym} -400 110 0 0 {name=l4 lab=ui_in_3}
C {devices/gnd.sym} -400 170 0 0 {name=gvs0}
C {devices/vsource.sym} -280 140 0 0 {name=vs1 value="0"}
C {devices/lab_pin.sym} -280 110 0 0 {name=l5 lab=uio_in_6}
C {devices/gnd.sym} -280 170 0 0 {name=gvs1}
C {devices/vsource.sym} -160 140 0 0 {name=vbias value="3.0"}
C {devices/lab_pin.sym} -160 110 0 0 {name=l6 lab=ua_0}
C {devices/gnd.sym} -160 170 0 0 {name=gvbias}
C {@@ROOT@@/blocks/data_input.sym} 200 0 0 0 {name=xdata_input}
C {devices/lab_pin.sym} 120 0 0 0 {name=l7 lab=ui_in_6}
C {devices/lab_pin.sym} 280 0 0 1 {name=l8 lab=data_local}
C {@@ROOT@@/blocks/capture_drivers.sym} 200 120 0 0 {name=xcapture_drivers}
C {devices/lab_pin.sym} 120 120 0 0 {name=l9 lab=capture}
C {devices/lab_pin.sym} 280 120 0 1 {name=l10 lab=capture_local}
C {@@ROOT@@/blocks/duts.sym} 500 60 0 0 {name=xduts}
C {devices/lab_pin.sym} 420 30 0 0 {name=l11 lab=capture_local}
C {devices/lab_pin.sym} 420 50 0 0 {name=l12 lab=data_local}
C {devices/lab_pin.sym} 580 30 0 1 {name=l13 lab=q_0}
C {devices/lab_pin.sym} 580 50 0 1 {name=l14 lab=q_1}
C {devices/lab_pin.sym} 580 70 0 1 {name=l15 lab=q_2}
C {devices/lab_pin.sym} 580 90 0 1 {name=l16 lab=q_3}
C {@@ROOT@@/blocks/selector.sym} 800 60 0 0 {name=xselector}
C {devices/lab_pin.sym} 720 10 0 0 {name=l17 lab=q_0}
C {devices/lab_pin.sym} 720 30 0 0 {name=l18 lab=q_1}
C {devices/lab_pin.sym} 720 50 0 0 {name=l19 lab=q_2}
C {devices/lab_pin.sym} 720 70 0 0 {name=l20 lab=q_3}
C {devices/lab_pin.sym} 720 90 0 0 {name=l21 lab=ui_in_3}
C {devices/lab_pin.sym} 720 110 0 0 {name=l22 lab=uio_in_6}
C {devices/lab_pin.sym} 880 10 0 1 {name=l23 lab=selected_q}
C {@@ROOT@@/blocks/delay.sym} 500 300 0 0 {name=xdelay}
C {devices/lab_pin.sym} 420 290 0 0 {name=l24 lab=capture_local}
C {devices/lab_pin.sym} 420 310 0 0 {name=l25 lab=ua_0}
C {devices/lab_pin.sym} 580 290 0 1 {name=l26 lab=early_clk}
C {@@ROOT@@/blocks/early_observer.sym} 1100 60 0 0 {name=xearly_observer}
C {devices/lab_pin.sym} 1020 50 0 0 {name=l27 lab=early_clk}
C {devices/lab_pin.sym} 1020 70 0 0 {name=l28 lab=selected_q}
C {devices/lab_pin.sym} 1180 50 0 1 {name=l29 lab=early_q}
C {@@ROOT@@/blocks/monitors.sym} 800 300 0 0 {name=xmonitors}
C {devices/lab_pin.sym} 720 290 0 0 {name=l30 lab=capture_local}
C {devices/lab_pin.sym} 720 310 0 0 {name=l31 lab=early_clk}
C {devices/lab_pin.sym} 880 290 0 1 {name=l32 lab=uio_out_4}
C {devices/lab_pin.sym} 880 310 0 1 {name=l33 lab=uio_out_5}
C {devices/code_shown.sym} 1400 -150 0 0 {name=SIM only_toplevel=false value=".include /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/sm141064.ngspice diode_typical
.global VDD
.param sw_stat_global=0 sw_stat_mismatch=0
.control
set filetype=ascii
tran 2p 14n
meas tran d_short trig v(capture_local) val=1.65 td=4n rise=1 targ v(early_clk) val=1.65 td=4n rise=1
meas tran arrive trig v(capture_local) val=1.65 td=4n rise=1 targ v(selected_q) val=1.65 td=4n rise=1
meas tran early_short find v(early_q) at=13.9n
meas tran final_short find v(selected_q) at=13.9n
wrdata tb_frontend_short.dat v(capture_local) v(selected_q) v(early_clk) v(early_q)
let a=d_short*1e12
echo RESULT d_short_ps $&a
let a=arrive*1e12
echo RESULT arrive_ps $&a
echo RESULT early_short_V $&early_short
echo RESULT final_short_V $&final_short
alter vbias 1.41171875
tran 2p 14n
meas tran d_allowed trig v(capture_local) val=1.65 td=4n rise=1 targ v(early_clk) val=1.65 td=4n rise=1
meas tran early_allowed find v(early_q) at=13.9n
meas tran final_allowed find v(selected_q) at=13.9n
wrdata tb_frontend_allowed.dat v(capture_local) v(selected_q) v(early_clk) v(early_q)
let a=d_allowed*1e12
echo RESULT d_allowed_ps $&a
echo RESULT early_allowed_V $&early_allowed
echo RESULT final_allowed_V $&final_allowed
.endc"}
