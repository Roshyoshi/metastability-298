v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {tb_tau: Resolution time constant of the three master latches (two starts, 1 mV and 10 uV)} -400 -260 0 0 0.45 0.45 {}
T {Expected: tau_base_ps = 88.9; tau_keeper_ps = 80.5; tau_forward_ps = 102.3} -400 -225 0 0 0.22 0.22 {}
C {devices/vsource.sym} -200 0 0 0 {name=vvdd value="3.3"}
C {devices/lab_pin.sym} -200 -30 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} -200 30 0 0 {name=gvvdd}
C {@@ROOT@@/blocks/meta_dut_baseline.sym} 200 0 0 0 {name=xbaseline0}
C {devices/lab_pin.sym} 150 -10 0 0 {name=l2 lab=0}
C {devices/lab_pin.sym} 150 10 0 0 {name=l3 lab=VDD}
C {devices/lab_pin.sym} 250 -10 0 1 {name=l4 lab=qbaseline0}
C {@@ROOT@@/cells_tx/inv_1.sym} 340 0 0 0 {name=xobaseline0}
C {devices/lab_pin.sym} 290 0 0 0 {name=l5 lab=qbaseline0}
C {devices/lab_pin.sym} 390 0 0 1 {name=l6 lab=qobaseline0}
C {devices/capa.sym} 310 70 0 0 {name=cqbaseline0 value=2f m=1}
C {devices/lab_pin.sym} 310 40 0 0 {name=l7 lab=qbaseline0}
C {devices/lab_pin.sym} 310 100 0 0 {name=l8 lab=0}
C {@@ROOT@@/blocks/meta_dut_baseline.sym} 560 0 0 0 {name=xbaseline1}
C {devices/lab_pin.sym} 510 -10 0 0 {name=l9 lab=0}
C {devices/lab_pin.sym} 510 10 0 0 {name=l10 lab=VDD}
C {devices/lab_pin.sym} 610 -10 0 1 {name=l11 lab=qbaseline1}
C {@@ROOT@@/cells_tx/inv_1.sym} 700 0 0 0 {name=xobaseline1}
C {devices/lab_pin.sym} 650 0 0 0 {name=l12 lab=qbaseline1}
C {devices/lab_pin.sym} 750 0 0 1 {name=l13 lab=qobaseline1}
C {devices/capa.sym} 670 70 0 0 {name=cqbaseline1 value=2f m=1}
C {devices/lab_pin.sym} 670 40 0 0 {name=l14 lab=qbaseline1}
C {devices/lab_pin.sym} 670 100 0 0 {name=l15 lab=0}
C {@@ROOT@@/blocks/meta_dut_keeper.sym} 200 160 0 0 {name=xkeeper0}
C {devices/lab_pin.sym} 150 150 0 0 {name=l16 lab=0}
C {devices/lab_pin.sym} 150 170 0 0 {name=l17 lab=VDD}
C {devices/lab_pin.sym} 250 150 0 1 {name=l18 lab=qkeeper0}
C {@@ROOT@@/cells_tx/inv_1.sym} 340 160 0 0 {name=xokeeper0}
C {devices/lab_pin.sym} 290 160 0 0 {name=l19 lab=qkeeper0}
C {devices/lab_pin.sym} 390 160 0 1 {name=l20 lab=qokeeper0}
C {devices/capa.sym} 310 230 0 0 {name=cqkeeper0 value=2f m=1}
C {devices/lab_pin.sym} 310 200 0 0 {name=l21 lab=qkeeper0}
C {devices/lab_pin.sym} 310 260 0 0 {name=l22 lab=0}
C {@@ROOT@@/blocks/meta_dut_keeper.sym} 560 160 0 0 {name=xkeeper1}
C {devices/lab_pin.sym} 510 150 0 0 {name=l23 lab=0}
C {devices/lab_pin.sym} 510 170 0 0 {name=l24 lab=VDD}
C {devices/lab_pin.sym} 610 150 0 1 {name=l25 lab=qkeeper1}
C {@@ROOT@@/cells_tx/inv_1.sym} 700 160 0 0 {name=xokeeper1}
C {devices/lab_pin.sym} 650 160 0 0 {name=l26 lab=qkeeper1}
C {devices/lab_pin.sym} 750 160 0 1 {name=l27 lab=qokeeper1}
C {devices/capa.sym} 670 230 0 0 {name=cqkeeper1 value=2f m=1}
C {devices/lab_pin.sym} 670 200 0 0 {name=l28 lab=qkeeper1}
C {devices/lab_pin.sym} 670 260 0 0 {name=l29 lab=0}
C {@@ROOT@@/blocks/meta_dut_forward.sym} 200 320 0 0 {name=xforward0}
C {devices/lab_pin.sym} 150 310 0 0 {name=l30 lab=0}
C {devices/lab_pin.sym} 150 330 0 0 {name=l31 lab=VDD}
C {devices/lab_pin.sym} 250 310 0 1 {name=l32 lab=qforward0}
C {@@ROOT@@/cells_tx/inv_1.sym} 340 320 0 0 {name=xoforward0}
C {devices/lab_pin.sym} 290 320 0 0 {name=l33 lab=qforward0}
C {devices/lab_pin.sym} 390 320 0 1 {name=l34 lab=qoforward0}
C {devices/capa.sym} 310 390 0 0 {name=cqforward0 value=2f m=1}
C {devices/lab_pin.sym} 310 360 0 0 {name=l35 lab=qforward0}
C {devices/lab_pin.sym} 310 420 0 0 {name=l36 lab=0}
C {@@ROOT@@/blocks/meta_dut_forward.sym} 560 320 0 0 {name=xforward1}
C {devices/lab_pin.sym} 510 310 0 0 {name=l37 lab=0}
C {devices/lab_pin.sym} 510 330 0 0 {name=l38 lab=VDD}
C {devices/lab_pin.sym} 610 310 0 1 {name=l39 lab=qforward1}
C {@@ROOT@@/cells_tx/inv_1.sym} 700 320 0 0 {name=xoforward1}
C {devices/lab_pin.sym} 650 320 0 0 {name=l40 lab=qforward1}
C {devices/lab_pin.sym} 750 320 0 1 {name=l41 lab=qoforward1}
C {devices/capa.sym} 670 390 0 0 {name=cqforward1 value=2f m=1}
C {devices/lab_pin.sym} 670 360 0 0 {name=l42 lab=qforward1}
C {devices/lab_pin.sym} 670 420 0 0 {name=l43 lab=0}
C {devices/code_shown.sym} 1000 -150 0 0 {name=SIM only_toplevel=false value=".include /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/sm141064.ngspice diode_typical
.global VDD
.param sw_stat_global=0 sw_stat_mismatch=0
.options method=gear reltol=1e-6 abstol=1e-12 vntol=1e-12 chgtol=1e-14 trtol=1
.ic v(xbaseline0.mq)=1.442642 v(xbaseline0.mqb)=1.441642 v(xbaseline1.mq)=1.442147 v(xbaseline1.mqb)=1.442137 v(xkeeper0.mq)=1.442642 v(xkeeper0.mqb)=1.441642 v(xkeeper1.mq)=1.442147 v(xkeeper1.mqb)=1.442137 v(xforward0.mq)=1.442642 v(xforward0.mqb)=1.441642 v(xforward1.mq)=1.442147 v(xforward1.mqb)=1.442137
.control
set filetype=ascii
tran 1p 3n
meas tran t_baseline0 when v(xbaseline0.mq)=2.5 cross=1
meas tran t_baseline1 when v(xbaseline1.mq)=2.5 cross=1
meas tran t_keeper0 when v(xkeeper0.mq)=2.5 cross=1
meas tran t_keeper1 when v(xkeeper1.mq)=2.5 cross=1
meas tran t_forward0 when v(xforward0.mq)=2.5 cross=1
meas tran t_forward1 when v(xforward1.mq)=2.5 cross=1
let tau_baseline=(t_baseline1-t_baseline0)/ln(100)*1e12
echo RESULT tau_base_ps $&tau_baseline
let tau_keeper=(t_keeper1-t_keeper0)/ln(100)*1e12
echo RESULT tau_keeper_ps $&tau_keeper
let tau_forward=(t_forward1-t_forward0)/ln(100)*1e12
echo RESULT tau_forward_ps $&tau_forward
wrdata tb_tau.dat v(xbaseline1.mq) v(xbaseline1.mqb) v(xkeeper1.mq) v(xkeeper1.mqb) v(xforward1.mq) v(xforward1.mqb)
.endc"}
