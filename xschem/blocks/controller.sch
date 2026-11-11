v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {controller: Controller (src/gf180/compact_control.v, 93 cells, 1,388 transistors), split into its eight parts} 0 -200 0 0 0.45 0.45 {}
T {Press e on a block to open it; Ctrl+e returns here. Blocks connect through equal net labels.} 0 -165 0 0 0.25 0.25 {}
C {@@ROOT@@/blocks/trial_clock.sym} 260 40 0 0 {name=xtrial_clock}
C {devices/lab_pin.sym} 180 20 0 0 {name=l1 lab=clk}
C {devices/lab_pin.sym} 180 40 0 0 {name=l2 lab=rst_n}
C {devices/lab_pin.sym} 340 20 0 1 {name=l3 lab=a_n}
C {devices/lab_pin.sym} 340 40 0 1 {name=l4 lab=b}
C {devices/lab_pin.sym} 340 60 0 1 {name=l5 lab=capture}
C {@@ROOT@@/blocks/start.sym} 780 50 0 0 {name=xstart}
C {devices/lab_pin.sym} 700 20 0 0 {name=l6 lab=a_n}
C {devices/lab_pin.sym} 700 40 0 0 {name=l7 lab=ena}
C {devices/lab_pin.sym} 700 60 0 0 {name=l8 lab=rst_n}
C {devices/lab_pin.sym} 700 80 0 0 {name=l9 lab=ui_in_4}
C {devices/lab_pin.sym} 860 20 0 1 {name=l10 lab=run}
C {@@ROOT@@/blocks/readings.sym} 1300 50 0 0 {name=xreadings}
C {devices/lab_pin.sym} 1220 20 0 0 {name=l11 lab=a_n}
C {devices/lab_pin.sym} 1220 40 0 0 {name=l12 lab=b}
C {devices/lab_pin.sym} 1220 60 0 0 {name=l13 lab=early_q}
C {devices/lab_pin.sym} 1220 80 0 0 {name=l14 lab=selected_q}
C {devices/lab_pin.sym} 1380 20 0 1 {name=l15 lab=bad_bit}
C {devices/lab_pin.sym} 1380 40 0 1 {name=l16 lab=event_bit}
C {@@ROOT@@/blocks/count_pulse.sym} 260 270 0 0 {name=xcount_pulse}
C {devices/lab_pin.sym} 180 240 0 0 {name=l17 lab=b}
C {devices/lab_pin.sym} 180 260 0 0 {name=l18 lab=n_16}
C {devices/lab_pin.sym} 180 280 0 0 {name=l19 lab=rst_n}
C {devices/lab_pin.sym} 180 300 0 0 {name=l20 lab=run}
C {devices/lab_pin.sym} 340 240 0 1 {name=l21 lab=tick_n}
C {@@ROOT@@/blocks/trial_counter.sym} 780 250 0 0 {name=xtrial_counter}
C {devices/lab_pin.sym} 700 240 0 0 {name=l22 lab=run}
C {devices/lab_pin.sym} 700 260 0 0 {name=l23 lab=tick_n}
C {devices/lab_pin.sym} 860 240 0 1 {name=l24 lab=n_16}
C {@@ROOT@@/blocks/event_counter.sym} 1300 390 0 0 {name=xevent_counter}
C {devices/lab_pin.sym} 1220 240 0 0 {name=l25 lab=event_bit}
C {devices/lab_pin.sym} 1220 260 0 0 {name=l26 lab=run}
C {devices/lab_pin.sym} 1220 280 0 0 {name=l27 lab=tick_n}
C {devices/lab_pin.sym} 1380 240 0 1 {name=l28 lab=k_0}
C {devices/lab_pin.sym} 1380 260 0 1 {name=l29 lab=k_10}
C {devices/lab_pin.sym} 1380 280 0 1 {name=l30 lab=k_11}
C {devices/lab_pin.sym} 1380 300 0 1 {name=l31 lab=k_12}
C {devices/lab_pin.sym} 1380 320 0 1 {name=l32 lab=k_13}
C {devices/lab_pin.sym} 1380 340 0 1 {name=l33 lab=k_14}
C {devices/lab_pin.sym} 1380 360 0 1 {name=l34 lab=k_15}
C {devices/lab_pin.sym} 1380 380 0 1 {name=l35 lab=k_1}
C {devices/lab_pin.sym} 1380 400 0 1 {name=l36 lab=k_2}
C {devices/lab_pin.sym} 1380 420 0 1 {name=l37 lab=k_3}
C {devices/lab_pin.sym} 1380 440 0 1 {name=l38 lab=k_4}
C {devices/lab_pin.sym} 1380 460 0 1 {name=l39 lab=k_5}
C {devices/lab_pin.sym} 1380 480 0 1 {name=l40 lab=k_6}
C {devices/lab_pin.sym} 1380 500 0 1 {name=l41 lab=k_7}
C {devices/lab_pin.sym} 1380 520 0 1 {name=l42 lab=k_8}
C {devices/lab_pin.sym} 1380 540 0 1 {name=l43 lab=k_9}
C {@@ROOT@@/blocks/status.sym} 260 740 0 0 {name=xstatus}
C {devices/lab_pin.sym} 180 700 0 0 {name=l44 lab=b}
C {devices/lab_pin.sym} 180 720 0 0 {name=l45 lab=bad_bit}
C {devices/lab_pin.sym} 180 740 0 0 {name=l46 lab=n_16}
C {devices/lab_pin.sym} 180 760 0 0 {name=l47 lab=run}
C {devices/lab_pin.sym} 180 780 0 0 {name=l48 lab=tick_n}
C {devices/lab_pin.sym} 340 700 0 1 {name=l49 lab=uio_out_1}
C {devices/lab_pin.sym} 340 720 0 1 {name=l50 lab=uio_out_2}
C {devices/lab_pin.sym} 340 740 0 1 {name=l51 lab=uio_out_3}
C {@@ROOT@@/blocks/readout.sym} 780 860 0 0 {name=xreadout}
C {devices/lab_pin.sym} 700 700 0 0 {name=l52 lab=k_0}
C {devices/lab_pin.sym} 700 720 0 0 {name=l53 lab=k_10}
C {devices/lab_pin.sym} 700 740 0 0 {name=l54 lab=k_11}
C {devices/lab_pin.sym} 700 760 0 0 {name=l55 lab=k_12}
C {devices/lab_pin.sym} 700 780 0 0 {name=l56 lab=k_13}
C {devices/lab_pin.sym} 700 800 0 0 {name=l57 lab=k_14}
C {devices/lab_pin.sym} 700 820 0 0 {name=l58 lab=k_15}
C {devices/lab_pin.sym} 700 840 0 0 {name=l59 lab=k_1}
C {devices/lab_pin.sym} 700 860 0 0 {name=l60 lab=k_2}
C {devices/lab_pin.sym} 700 880 0 0 {name=l61 lab=k_3}
C {devices/lab_pin.sym} 700 900 0 0 {name=l62 lab=k_4}
C {devices/lab_pin.sym} 700 920 0 0 {name=l63 lab=k_5}
C {devices/lab_pin.sym} 700 940 0 0 {name=l64 lab=k_6}
C {devices/lab_pin.sym} 700 960 0 0 {name=l65 lab=k_7}
C {devices/lab_pin.sym} 700 980 0 0 {name=l66 lab=k_8}
C {devices/lab_pin.sym} 700 1000 0 0 {name=l67 lab=k_9}
C {devices/lab_pin.sym} 700 1020 0 0 {name=l68 lab=ui_in_0}
C {devices/lab_pin.sym} 860 700 0 1 {name=l69 lab=uo_out_0}
C {devices/lab_pin.sym} 860 720 0 1 {name=l70 lab=uo_out_1}
C {devices/lab_pin.sym} 860 740 0 1 {name=l71 lab=uo_out_2}
C {devices/lab_pin.sym} 860 760 0 1 {name=l72 lab=uo_out_3}
C {devices/lab_pin.sym} 860 780 0 1 {name=l73 lab=uo_out_4}
C {devices/lab_pin.sym} 860 800 0 1 {name=l74 lab=uo_out_5}
C {devices/lab_pin.sym} 860 820 0 1 {name=l75 lab=uo_out_6}
C {devices/lab_pin.sym} 860 840 0 1 {name=l76 lab=uo_out_7}
