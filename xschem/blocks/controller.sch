v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {controller: Controller (Roshan's meta_controller.v after synthesis, 159 cells), split into its flow boxes} 0 -200 0 0 0.45 0.45 {}
T {Press e on a block to open it; Ctrl+e returns here. Blocks connect through equal net labels.} 0 -165 0 0 0.25 0.25 {}
C {@@ROOT@@/blocks/sequencer.sym} 260 230 0 0 {name=xsequencer}
C {devices/lab_pin.sym} 180 20 0 0 {name=l1 lab=clk}
C {devices/lab_pin.sym} 180 40 0 0 {name=l2 lab=ena}
C {devices/lab_pin.sym} 180 60 0 0 {name=l3 lab=reference_fault}
C {devices/lab_pin.sym} 180 80 0 0 {name=l4 lab=rst_n}
C {devices/lab_pin.sym} 180 100 0 0 {name=l5 lab=trials_0}
C {devices/lab_pin.sym} 180 120 0 0 {name=l6 lab=trials_1}
C {devices/lab_pin.sym} 180 140 0 0 {name=l7 lab=trials_2}
C {devices/lab_pin.sym} 180 160 0 0 {name=l8 lab=trials_3}
C {devices/lab_pin.sym} 180 180 0 0 {name=l9 lab=trials_4}
C {devices/lab_pin.sym} 180 200 0 0 {name=l10 lab=trials_5}
C {devices/lab_pin.sym} 180 220 0 0 {name=l11 lab=trials_6}
C {devices/lab_pin.sym} 180 240 0 0 {name=l12 lab=trials_7}
C {devices/lab_pin.sym} 180 260 0 0 {name=l13 lab=ui_in_3}
C {devices/lab_pin.sym} 180 280 0 0 {name=l14 lab=ui_in_4}
C {devices/lab_pin.sym} 180 300 0 0 {name=l15 lab=uio_in_6}
C {devices/lab_pin.sym} 340 20 0 1 {name=l16 lab=_031_}
C {devices/lab_pin.sym} 340 40 0 1 {name=l17 lab=_034_}
C {devices/lab_pin.sym} 340 60 0 1 {name=l18 lab=_035_}
C {devices/lab_pin.sym} 340 80 0 1 {name=l19 lab=_086_}
C {devices/lab_pin.sym} 340 100 0 1 {name=l20 lab=_096_}
C {devices/lab_pin.sym} 340 120 0 1 {name=l21 lab=_101_}
C {devices/lab_pin.sym} 340 140 0 1 {name=l22 lab=_102_}
C {devices/lab_pin.sym} 340 160 0 1 {name=l23 lab=_103_}
C {devices/lab_pin.sym} 340 180 0 1 {name=l24 lab=_111_}
C {devices/lab_pin.sym} 340 200 0 1 {name=l25 lab=_113_}
C {devices/lab_pin.sym} 340 220 0 1 {name=l26 lab=_115_}
C {devices/lab_pin.sym} 340 240 0 1 {name=l27 lab=_117_}
C {devices/lab_pin.sym} 340 260 0 1 {name=l28 lab=_119_}
C {devices/lab_pin.sym} 340 280 0 1 {name=l29 lab=_120_}
C {devices/lab_pin.sym} 340 300 0 1 {name=l30 lab=_122_}
C {devices/lab_pin.sym} 340 320 0 1 {name=l31 lab=_124_}
C {devices/lab_pin.sym} 340 340 0 1 {name=l32 lab=capture}
C {devices/lab_pin.sym} 340 360 0 1 {name=l33 lab=cfg_0}
C {devices/lab_pin.sym} 340 380 0 1 {name=l34 lab=cfg_1}
C {devices/lab_pin.sym} 340 400 0 1 {name=l35 lab=state_0}
C {devices/lab_pin.sym} 340 420 0 1 {name=l36 lab=state_1}
C {devices/lab_pin.sym} 340 440 0 1 {name=l37 lab=state_2}
C {@@ROOT@@/blocks/late_observers.sym} 780 100 0 0 {name=xlate_observers}
C {devices/lab_pin.sym} 700 20 0 0 {name=l38 lab=_086_}
C {devices/lab_pin.sym} 700 40 0 0 {name=l39 lab=_101_}
C {devices/lab_pin.sym} 700 60 0 0 {name=l40 lab=_102_}
C {devices/lab_pin.sym} 700 80 0 0 {name=l41 lab=clk}
C {devices/lab_pin.sym} 700 100 0 0 {name=l42 lab=rst_n}
C {devices/lab_pin.sym} 700 120 0 0 {name=l43 lab=selected_q}
C {devices/lab_pin.sym} 700 140 0 0 {name=l44 lab=state_0}
C {devices/lab_pin.sym} 700 160 0 0 {name=l45 lab=state_1}
C {devices/lab_pin.sym} 700 180 0 0 {name=l46 lab=state_2}
C {devices/lab_pin.sym} 860 20 0 1 {name=l47 lab=late1}
C {devices/lab_pin.sym} 860 40 0 1 {name=l48 lab=late2}
C {@@ROOT@@/blocks/compare.sym} 1300 90 0 0 {name=xcompare}
C {devices/lab_pin.sym} 1220 20 0 0 {name=l49 lab=_101_}
C {devices/lab_pin.sym} 1220 40 0 0 {name=l50 lab=_103_}
C {devices/lab_pin.sym} 1220 60 0 0 {name=l51 lab=clk}
C {devices/lab_pin.sym} 1220 80 0 0 {name=l52 lab=early_q}
C {devices/lab_pin.sym} 1220 100 0 0 {name=l53 lab=late1}
C {devices/lab_pin.sym} 1220 120 0 0 {name=l54 lab=late2}
C {devices/lab_pin.sym} 1220 140 0 0 {name=l55 lab=rst_n}
C {devices/lab_pin.sym} 1220 160 0 0 {name=l56 lab=state_2}
C {devices/lab_pin.sym} 1380 20 0 1 {name=l57 lab=event_pending}
C {devices/lab_pin.sym} 1380 40 0 1 {name=l58 lab=reference_fault}
C {@@ROOT@@/blocks/counters.sym} 260 750 0 0 {name=xcounters}
C {devices/lab_pin.sym} 180 600 0 0 {name=l59 lab=_034_}
C {devices/lab_pin.sym} 180 620 0 0 {name=l60 lab=_035_}
C {devices/lab_pin.sym} 180 640 0 0 {name=l61 lab=_096_}
C {devices/lab_pin.sym} 180 660 0 0 {name=l62 lab=_111_}
C {devices/lab_pin.sym} 180 680 0 0 {name=l63 lab=_115_}
C {devices/lab_pin.sym} 180 700 0 0 {name=l64 lab=_119_}
C {devices/lab_pin.sym} 180 720 0 0 {name=l65 lab=_120_}
C {devices/lab_pin.sym} 180 740 0 0 {name=l66 lab=_122_}
C {devices/lab_pin.sym} 180 760 0 0 {name=l67 lab=_124_}
C {devices/lab_pin.sym} 180 780 0 0 {name=l68 lab=clk}
C {devices/lab_pin.sym} 180 800 0 0 {name=l69 lab=event_pending}
C {devices/lab_pin.sym} 180 820 0 0 {name=l70 lab=rst_n}
C {devices/lab_pin.sym} 340 600 0 1 {name=l71 lab=trials_0}
C {devices/lab_pin.sym} 340 620 0 1 {name=l72 lab=trials_1}
C {devices/lab_pin.sym} 340 640 0 1 {name=l73 lab=trials_2}
C {devices/lab_pin.sym} 340 660 0 1 {name=l74 lab=trials_3}
C {devices/lab_pin.sym} 340 680 0 1 {name=l75 lab=trials_4}
C {devices/lab_pin.sym} 340 700 0 1 {name=l76 lab=trials_5}
C {devices/lab_pin.sym} 340 720 0 1 {name=l77 lab=trials_6}
C {devices/lab_pin.sym} 340 740 0 1 {name=l78 lab=trials_7}
C {devices/lab_pin.sym} 340 760 0 1 {name=l79 lab=uo_out_0}
C {devices/lab_pin.sym} 340 780 0 1 {name=l80 lab=uo_out_1}
C {devices/lab_pin.sym} 340 800 0 1 {name=l81 lab=uo_out_2}
C {devices/lab_pin.sym} 340 820 0 1 {name=l82 lab=uo_out_3}
C {devices/lab_pin.sym} 340 840 0 1 {name=l83 lab=uo_out_4}
C {devices/lab_pin.sym} 340 860 0 1 {name=l84 lab=uo_out_5}
C {devices/lab_pin.sym} 340 880 0 1 {name=l85 lab=uo_out_6}
C {devices/lab_pin.sym} 340 900 0 1 {name=l86 lab=uo_out_7}
C {@@ROOT@@/blocks/hold_status.sym} 780 690 0 0 {name=xhold_status}
C {devices/lab_pin.sym} 700 600 0 0 {name=l87 lab=_031_}
C {devices/lab_pin.sym} 700 620 0 0 {name=l88 lab=_034_}
C {devices/lab_pin.sym} 700 640 0 0 {name=l89 lab=_102_}
C {devices/lab_pin.sym} 700 660 0 0 {name=l90 lab=_113_}
C {devices/lab_pin.sym} 700 680 0 0 {name=l91 lab=_117_}
C {devices/lab_pin.sym} 700 700 0 0 {name=l92 lab=_119_}
C {devices/lab_pin.sym} 700 720 0 0 {name=l93 lab=_124_}
C {devices/lab_pin.sym} 700 740 0 0 {name=l94 lab=clk}
C {devices/lab_pin.sym} 700 760 0 0 {name=l95 lab=reference_fault}
C {devices/lab_pin.sym} 700 780 0 0 {name=l96 lab=rst_n}
C {devices/lab_pin.sym} 860 600 0 1 {name=l97 lab=uio_out_1}
C {devices/lab_pin.sym} 860 620 0 1 {name=l98 lab=uio_out_2}
C {devices/lab_pin.sym} 860 640 0 1 {name=l99 lab=uio_out_3}
