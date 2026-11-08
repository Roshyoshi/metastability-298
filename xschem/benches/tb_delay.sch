v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {tb_delay: Delay d versus ua[0]: the layout delay line (MCT gate capacitor) and an ideal-2 fF copy} -400 -260 0 0 0.45 0.45 {}
T {Expected: d_ideal_ns_at_ua0 1.1 = 2.244; d_ideal_ns_at_ua0 1.3 = 1.601; d_ideal_ns_at_ua0 1.5 = 1.279; d_ideal_ns_at_ua0 1.8 = 1.026; d_ideal_ns_at_ua0 2.4 = 0.816; d_ideal_ns_at_ua0 3.0 = 0.741; d_ns_at_ua0 1.1 = within about 10% of 2.244; d_ns_at_ua0 1.3 = within about 10% of 1.601; d_ns_at_ua0 1.5 = within about 10% of 1.279; d_ns_at_ua0 1.8 = within about 10% of 1.026; d_ns_at_ua0 2.4 = within about 10% of 0.816; d_ns_at_ua0 3.0 = within about 10% of 0.741} -400 -225 0 0 0.22 0.22 {}
C {devices/vsource.sym} -300 0 0 0 {name=vvdd value="3.3"}
C {devices/lab_pin.sym} -300 -30 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} -300 30 0 0 {name=gvvdd}
C {devices/vsource.sym} -180 0 0 0 {name=vcap value="PWL(0 0 1n 0 1.05n 3.3 2n 3.3 2.05n 0 5n 0 5.05n 3.3)"}
C {devices/lab_pin.sym} -180 -30 0 0 {name=l2 lab=capture}
C {devices/gnd.sym} -180 30 0 0 {name=gvcap}
C {devices/vsource.sym} -60 0 0 0 {name=vbias value="3.0"}
C {devices/lab_pin.sym} -60 -30 0 0 {name=l3 lab=ua_0}
C {devices/gnd.sym} -60 30 0 0 {name=gvbias}
C {@@ROOT@@/blocks/capture_drivers.sym} 200 0 0 0 {name=xcapd}
C {devices/lab_pin.sym} 120 0 0 0 {name=l4 lab=capture}
C {devices/lab_pin.sym} 280 0 0 1 {name=l5 lab=capture_local}
C {@@ROOT@@/blocks/delay.sym} 480 0 0 0 {name=xdelay}
C {devices/lab_pin.sym} 400 -10 0 0 {name=l6 lab=capture_local}
C {devices/lab_pin.sym} 400 10 0 0 {name=l7 lab=ua_0}
C {devices/lab_pin.sym} 560 -10 0 1 {name=l8 lab=early_clk}
C {@@ROOT@@/blocks/early_observer.sym} 760 0 0 0 {name=xearly}
C {devices/lab_pin.sym} 680 -10 0 0 {name=l9 lab=early_clk}
C {devices/lab_pin.sym} 680 10 0 0 {name=l10 lab=0}
C {devices/lab_pin.sym} 840 -10 0 1 {name=l11 lab=early_q}
C {devices/code_shown.sym} 1000 -150 0 0 {name=SIM only_toplevel=false value=".include /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/sm141064.ngspice diode_typical
.global VDD
.param sw_stat_global=0 sw_stat_mismatch=0
* ideal-capacitor reference copy of the delay line
xri0 capture_local isob_r inv_1
xri1 isob_r iso_r inv_2
xmp_r slow_r iso_r VDD VDD pfet_05v0 w=1.22u l=0.5u ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06
xmn_r slow_r iso_r foot_r 0 nfet_05v0 w=0.82u l=0.6u ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06
xmc_r foot_r ua_0 0 0 nfet_05v0 w=0.36u l=0.6u ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06
cct_r slow_r 0 2f
xrr0 slow_r r0_r inv_1
xrr1 r0_r r1_r inv_2
xrr2 r1_r early_r inv_2
xer 0 early_r q_r dffq_1
.control
set filetype=ascii
foreach vb 1.1 1.3 1.5 1.8 2.4 3.0
 alter vbias $vb
 tran 5p 14n
 meas tran dly trig v(capture_local) val=1.65 td=4n rise=1 targ v(early_clk) val=1.65 td=4n rise=1
 meas tran dlr trig v(capture_local) val=1.65 td=4n rise=1 targ v(early_r) val=1.65 td=4n rise=1
 let dns=dly*1e9
 let dnr=dlr*1e9
 echo RESULT d_ns_at_ua0 $vb $&dns
 echo RESULT d_ideal_ns_at_ua0 $vb $&dnr
end
.endc"}
