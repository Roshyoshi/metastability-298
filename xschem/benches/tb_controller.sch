v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {tb_controller: Controller at transistor level: the first eight counted trials of a block (1,388 transistors)} -400 -260 0 0 0.45 0.45 {}
T {Expected: events_after_8_trials = 8; busy_V = 3.3; done_V = 0.0; fault_V = 0.0; first_capture_ns = about 175 (clock edge at 174.6 ns plus clock-to-output); first_count_ns = about 927 (clock edge at 924.6 ns, then four cells: b, the count-pulse gate, k[0], the output selector)} -400 -225 0 0 0.22 0.22 {}
C {devices/vsource.sym} -400 0 0 0 {name=vvdd value="3.3"}
C {devices/lab_pin.sym} -400 -30 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} -400 30 0 0 {name=gvvdd}
C {devices/vsource.sym} -280 0 0 0 {name=vclk value="PULSE(0 3.3 24.5n 0.1n 0.1n 24.9n 50n)"}
C {devices/lab_pin.sym} -280 -30 0 0 {name=l2 lab=clk}
C {devices/gnd.sym} -280 30 0 0 {name=gvclk}
C {devices/vsource.sym} -160 0 0 0 {name=vrst value="PWL(0 0 100n 0 100.1n 3.3)"}
C {devices/lab_pin.sym} -160 -30 0 0 {name=l3 lab=rst_n}
C {devices/gnd.sym} -160 30 0 0 {name=gvrst}
C {devices/vsource.sym} -400 140 0 0 {name=vstart value="PWL(0 0 300n 0 300.1n 3.3)"}
C {devices/lab_pin.sym} -400 110 0 0 {name=l4 lab=ui_in_4}
C {devices/gnd.sym} -400 170 0 0 {name=gvstart}
C {devices/vsource.sym} -280 140 0 0 {name=vena value="3.3"}
C {devices/lab_pin.sym} -280 110 0 0 {name=l5 lab=ena}
C {devices/gnd.sym} -280 170 0 0 {name=gvena}
C {devices/vsource.sym} -160 140 0 0 {name=vbyte value="0"}
C {devices/lab_pin.sym} -160 110 0 0 {name=l6 lab=ui_in_0}
C {devices/gnd.sym} -160 170 0 0 {name=gvbyte}
C {devices/vsource.sym} -400 280 0 0 {name=vdq value="3.3"}
C {devices/lab_pin.sym} -400 250 0 0 {name=l7 lab=selected_q}
C {devices/gnd.sym} -400 310 0 0 {name=gvdq}
C {devices/vsource.sym} -280 280 0 0 {name=vea value="0"}
C {devices/lab_pin.sym} -280 250 0 0 {name=l8 lab=early_q}
C {devices/gnd.sym} -280 310 0 0 {name=gvea}
C {@@ROOT@@/blocks/controller.sym} 300 100 0 0 {name=xctrl}
C {devices/lab_pin.sym} 220 -10 0 0 {name=l9 lab=clk}
C {devices/lab_pin.sym} 220 10 0 0 {name=l10 lab=early_q}
C {devices/lab_pin.sym} 220 30 0 0 {name=l11 lab=ena}
C {devices/lab_pin.sym} 220 50 0 0 {name=l12 lab=rst_n}
C {devices/lab_pin.sym} 220 70 0 0 {name=l13 lab=selected_q}
C {devices/lab_pin.sym} 220 90 0 0 {name=l14 lab=ui_in_0}
C {devices/lab_pin.sym} 220 110 0 0 {name=l15 lab=ui_in_4}
C {devices/lab_pin.sym} 380 -10 0 1 {name=l16 lab=capture}
C {devices/lab_pin.sym} 380 10 0 1 {name=l17 lab=uio_out_1}
C {devices/lab_pin.sym} 380 30 0 1 {name=l18 lab=uio_out_2}
C {devices/lab_pin.sym} 380 50 0 1 {name=l19 lab=uio_out_3}
C {devices/lab_pin.sym} 380 70 0 1 {name=l20 lab=uo_out_0}
C {devices/lab_pin.sym} 380 90 0 1 {name=l21 lab=uo_out_1}
C {devices/lab_pin.sym} 380 110 0 1 {name=l22 lab=uo_out_2}
C {devices/lab_pin.sym} 380 130 0 1 {name=l23 lab=uo_out_3}
C {devices/lab_pin.sym} 380 150 0 1 {name=l24 lab=uo_out_4}
C {devices/lab_pin.sym} 380 170 0 1 {name=l25 lab=uo_out_5}
C {devices/lab_pin.sym} 380 190 0 1 {name=l26 lab=uo_out_6}
C {devices/lab_pin.sym} 380 210 0 1 {name=l27 lab=uo_out_7}
C {devices/code_shown.sym} 800 -150 0 0 {name=SIM only_toplevel=false value=".include /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /usr/local/share/pdk/gf180mcuD/libs.tech/ngspice/sm141064.ngspice diode_typical
.global VDD
.param sw_stat_global=0 sw_stat_mismatch=0
.control
set filetype=ascii
tran 50p 2.5u
meas tran first_cap when v(capture)=1.65 rise=1
let a=first_cap*1e9
echo RESULT first_capture_ns $&a
meas tran first_cnt when v(uo_out_0)=1.65 rise=1
let a=first_cnt*1e9
echo RESULT first_count_ns $&a
meas tran b0 find v(uo_out_0) at=2.49u
meas tran b1 find v(uo_out_1) at=2.49u
meas tran b2 find v(uo_out_2) at=2.49u
meas tran b3 find v(uo_out_3) at=2.49u
meas tran b4 find v(uo_out_4) at=2.49u
meas tran b5 find v(uo_out_5) at=2.49u
meas tran b6 find v(uo_out_6) at=2.49u
meas tran b7 find v(uo_out_7) at=2.49u
let ev=(b0 gt 1.65)+2*(b1 gt 1.65)+4*(b2 gt 1.65)+8*(b3 gt 1.65)+16*(b4 gt 1.65)+32*(b5 gt 1.65)+64*(b6 gt 1.65)+128*(b7 gt 1.65)
echo RESULT events_after_8_trials $&ev
meas tran busy find v(uio_out_1) at=2.49u
meas tran done find v(uio_out_2) at=2.49u
meas tran fault find v(uio_out_3) at=2.49u
echo RESULT busy_V $&busy
echo RESULT done_V $&done
echo RESULT fault_V $&fault
wrdata tb_controller.dat v(clk) v(capture) v(uio_out_1) v(uo_out_0) v(uo_out_1) v(uo_out_2) v(uo_out_3) v(uo_out_4) v(uo_out_5) v(uo_out_6) v(uo_out_7)
.endc"}
