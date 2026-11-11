v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {event_counter: Event counter k: bit 0 takes k_0 XOR event_bit on each count; each later bit is clocked by the bit below   (flow box: Counter K)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 1620 260 0 0 {name=xk10_ff}
C {devices/lab_pin.sym} 1570 240 0 0 {name=l1 lab=k_n_10}
C {devices/lab_pin.sym} 1570 260 0 0 {name=l2 lab=run}
C {devices/lab_pin.sym} 1570 280 0 0 {name=l3 lab=k_9}
C {devices/lab_pin.sym} 1670 240 0 1 {name=l4 lab=k_10}
C {@@ROOT@@/cells_tx/inv_1.sym} 1620 380 0 0 {name=xk10_inv}
C {devices/lab_pin.sym} 1570 380 0 0 {name=l5 lab=k_10}
C {devices/lab_pin.sym} 1670 380 0 1 {name=l6 lab=k_n_10}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 1950 260 0 0 {name=xk11_ff}
C {devices/lab_pin.sym} 1900 240 0 0 {name=l7 lab=k_n_11}
C {devices/lab_pin.sym} 1900 260 0 0 {name=l8 lab=run}
C {devices/lab_pin.sym} 1900 280 0 0 {name=l9 lab=k_10}
C {devices/lab_pin.sym} 2000 240 0 1 {name=l10 lab=k_11}
C {@@ROOT@@/cells_tx/inv_1.sym} 1950 380 0 0 {name=xk11_inv}
C {devices/lab_pin.sym} 1900 380 0 0 {name=l11 lab=k_11}
C {devices/lab_pin.sym} 2000 380 0 1 {name=l12 lab=k_n_11}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 300 520 0 0 {name=xk12_ff}
C {devices/lab_pin.sym} 250 500 0 0 {name=l13 lab=k_n_12}
C {devices/lab_pin.sym} 250 520 0 0 {name=l14 lab=run}
C {devices/lab_pin.sym} 250 540 0 0 {name=l15 lab=k_11}
C {devices/lab_pin.sym} 350 500 0 1 {name=l16 lab=k_12}
C {@@ROOT@@/cells_tx/inv_1.sym} 300 640 0 0 {name=xk12_inv}
C {devices/lab_pin.sym} 250 640 0 0 {name=l17 lab=k_12}
C {devices/lab_pin.sym} 350 640 0 1 {name=l18 lab=k_n_12}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 630 520 0 0 {name=xk13_ff}
C {devices/lab_pin.sym} 580 500 0 0 {name=l19 lab=k_n_13}
C {devices/lab_pin.sym} 580 520 0 0 {name=l20 lab=run}
C {devices/lab_pin.sym} 580 540 0 0 {name=l21 lab=k_12}
C {devices/lab_pin.sym} 680 500 0 1 {name=l22 lab=k_13}
C {@@ROOT@@/cells_tx/inv_1.sym} 630 640 0 0 {name=xk13_inv}
C {devices/lab_pin.sym} 580 640 0 0 {name=l23 lab=k_13}
C {devices/lab_pin.sym} 680 640 0 1 {name=l24 lab=k_n_13}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 960 520 0 0 {name=xk14_ff}
C {devices/lab_pin.sym} 910 500 0 0 {name=l25 lab=k_n_14}
C {devices/lab_pin.sym} 910 520 0 0 {name=l26 lab=run}
C {devices/lab_pin.sym} 910 540 0 0 {name=l27 lab=k_13}
C {devices/lab_pin.sym} 1010 500 0 1 {name=l28 lab=k_14}
C {@@ROOT@@/cells_tx/inv_1.sym} 960 640 0 0 {name=xk14_inv}
C {devices/lab_pin.sym} 910 640 0 0 {name=l29 lab=k_14}
C {devices/lab_pin.sym} 1010 640 0 1 {name=l30 lab=k_n_14}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 1290 520 0 0 {name=xk15_ff}
C {devices/lab_pin.sym} 1240 500 0 0 {name=l31 lab=k_n_15}
C {devices/lab_pin.sym} 1240 520 0 0 {name=l32 lab=run}
C {devices/lab_pin.sym} 1240 540 0 0 {name=l33 lab=k_14}
C {devices/lab_pin.sym} 1340 500 0 1 {name=l34 lab=k_15}
C {@@ROOT@@/cells_tx/inv_1.sym} 1290 640 0 0 {name=xk15_inv}
C {devices/lab_pin.sym} 1240 640 0 0 {name=l35 lab=k_15}
C {devices/lab_pin.sym} 1340 640 0 1 {name=l36 lab=k_n_15}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 630 0 0 0 {name=xk1_ff}
C {devices/lab_pin.sym} 580 -20 0 0 {name=l37 lab=k_n_1}
C {devices/lab_pin.sym} 580 0 0 0 {name=l38 lab=run}
C {devices/lab_pin.sym} 580 20 0 0 {name=l39 lab=k_0}
C {devices/lab_pin.sym} 680 -20 0 1 {name=l40 lab=k_1}
C {@@ROOT@@/cells_tx/inv_1.sym} 630 120 0 0 {name=xk1_inv}
C {devices/lab_pin.sym} 580 120 0 0 {name=l41 lab=k_1}
C {devices/lab_pin.sym} 680 120 0 1 {name=l42 lab=k_n_1}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 960 0 0 0 {name=xk2_ff}
C {devices/lab_pin.sym} 910 -20 0 0 {name=l43 lab=k_n_2}
C {devices/lab_pin.sym} 910 0 0 0 {name=l44 lab=run}
C {devices/lab_pin.sym} 910 20 0 0 {name=l45 lab=k_1}
C {devices/lab_pin.sym} 1010 -20 0 1 {name=l46 lab=k_2}
C {@@ROOT@@/cells_tx/inv_1.sym} 960 120 0 0 {name=xk2_inv}
C {devices/lab_pin.sym} 910 120 0 0 {name=l47 lab=k_2}
C {devices/lab_pin.sym} 1010 120 0 1 {name=l48 lab=k_n_2}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 1290 0 0 0 {name=xk3_ff}
C {devices/lab_pin.sym} 1240 -20 0 0 {name=l49 lab=k_n_3}
C {devices/lab_pin.sym} 1240 0 0 0 {name=l50 lab=run}
C {devices/lab_pin.sym} 1240 20 0 0 {name=l51 lab=k_2}
C {devices/lab_pin.sym} 1340 -20 0 1 {name=l52 lab=k_3}
C {@@ROOT@@/cells_tx/inv_1.sym} 1290 120 0 0 {name=xk3_inv}
C {devices/lab_pin.sym} 1240 120 0 0 {name=l53 lab=k_3}
C {devices/lab_pin.sym} 1340 120 0 1 {name=l54 lab=k_n_3}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 1620 0 0 0 {name=xk4_ff}
C {devices/lab_pin.sym} 1570 -20 0 0 {name=l55 lab=k_n_4}
C {devices/lab_pin.sym} 1570 0 0 0 {name=l56 lab=run}
C {devices/lab_pin.sym} 1570 20 0 0 {name=l57 lab=k_3}
C {devices/lab_pin.sym} 1670 -20 0 1 {name=l58 lab=k_4}
C {@@ROOT@@/cells_tx/inv_1.sym} 1620 120 0 0 {name=xk4_inv}
C {devices/lab_pin.sym} 1570 120 0 0 {name=l59 lab=k_4}
C {devices/lab_pin.sym} 1670 120 0 1 {name=l60 lab=k_n_4}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 1950 0 0 0 {name=xk5_ff}
C {devices/lab_pin.sym} 1900 -20 0 0 {name=l61 lab=k_n_5}
C {devices/lab_pin.sym} 1900 0 0 0 {name=l62 lab=run}
C {devices/lab_pin.sym} 1900 20 0 0 {name=l63 lab=k_4}
C {devices/lab_pin.sym} 2000 -20 0 1 {name=l64 lab=k_5}
C {@@ROOT@@/cells_tx/inv_1.sym} 1950 120 0 0 {name=xk5_inv}
C {devices/lab_pin.sym} 1900 120 0 0 {name=l65 lab=k_5}
C {devices/lab_pin.sym} 2000 120 0 1 {name=l66 lab=k_n_5}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 300 260 0 0 {name=xk6_ff}
C {devices/lab_pin.sym} 250 240 0 0 {name=l67 lab=k_n_6}
C {devices/lab_pin.sym} 250 260 0 0 {name=l68 lab=run}
C {devices/lab_pin.sym} 250 280 0 0 {name=l69 lab=k_5}
C {devices/lab_pin.sym} 350 240 0 1 {name=l70 lab=k_6}
C {@@ROOT@@/cells_tx/inv_1.sym} 300 380 0 0 {name=xk6_inv}
C {devices/lab_pin.sym} 250 380 0 0 {name=l71 lab=k_6}
C {devices/lab_pin.sym} 350 380 0 1 {name=l72 lab=k_n_6}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 630 260 0 0 {name=xk7_ff}
C {devices/lab_pin.sym} 580 240 0 0 {name=l73 lab=k_n_7}
C {devices/lab_pin.sym} 580 260 0 0 {name=l74 lab=run}
C {devices/lab_pin.sym} 580 280 0 0 {name=l75 lab=k_6}
C {devices/lab_pin.sym} 680 240 0 1 {name=l76 lab=k_7}
C {@@ROOT@@/cells_tx/inv_1.sym} 630 380 0 0 {name=xk7_inv}
C {devices/lab_pin.sym} 580 380 0 0 {name=l77 lab=k_7}
C {devices/lab_pin.sym} 680 380 0 1 {name=l78 lab=k_n_7}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 960 260 0 0 {name=xk8_ff}
C {devices/lab_pin.sym} 910 240 0 0 {name=l79 lab=k_n_8}
C {devices/lab_pin.sym} 910 260 0 0 {name=l80 lab=run}
C {devices/lab_pin.sym} 910 280 0 0 {name=l81 lab=k_7}
C {devices/lab_pin.sym} 1010 240 0 1 {name=l82 lab=k_8}
C {@@ROOT@@/cells_tx/inv_1.sym} 960 380 0 0 {name=xk8_inv}
C {devices/lab_pin.sym} 910 380 0 0 {name=l83 lab=k_8}
C {devices/lab_pin.sym} 1010 380 0 1 {name=l84 lab=k_n_8}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 1290 260 0 0 {name=xk9_ff}
C {devices/lab_pin.sym} 1240 240 0 0 {name=l85 lab=k_n_9}
C {devices/lab_pin.sym} 1240 260 0 0 {name=l86 lab=run}
C {devices/lab_pin.sym} 1240 280 0 0 {name=l87 lab=k_8}
C {devices/lab_pin.sym} 1340 240 0 1 {name=l88 lab=k_9}
C {@@ROOT@@/cells_tx/inv_1.sym} 1290 380 0 0 {name=xk9_inv}
C {devices/lab_pin.sym} 1240 380 0 0 {name=l89 lab=k_9}
C {devices/lab_pin.sym} 1340 380 0 1 {name=l90 lab=k_n_9}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 300 0 0 0 {name=xk0_ff}
C {devices/lab_pin.sym} 250 -20 0 0 {name=l91 lab=k0_d}
C {devices/lab_pin.sym} 250 0 0 0 {name=l92 lab=run}
C {devices/lab_pin.sym} 250 20 0 0 {name=l93 lab=tick_n}
C {devices/lab_pin.sym} 350 -20 0 1 {name=l94 lab=k_0}
C {@@ROOT@@/cells_tx/xor2_1.sym} 300 120 0 0 {name=xk0_xor}
C {devices/lab_pin.sym} 250 110 0 0 {name=l95 lab=k_0}
C {devices/lab_pin.sym} 250 130 0 0 {name=l96 lab=event_bit}
C {devices/lab_pin.sym} 350 110 0 1 {name=l97 lab=k0_d}
C {devices/ipin.sym} 60 0 0 0 {name=p98 lab=event_bit}
C {devices/ipin.sym} 60 40 0 0 {name=p99 lab=run}
C {devices/ipin.sym} 60 80 0 0 {name=p100 lab=tick_n}
C {devices/opin.sym} 2210 0 0 0 {name=p101 lab=k_0}
C {devices/opin.sym} 2210 40 0 0 {name=p102 lab=k_10}
C {devices/opin.sym} 2210 80 0 0 {name=p103 lab=k_11}
C {devices/opin.sym} 2210 120 0 0 {name=p104 lab=k_12}
C {devices/opin.sym} 2210 160 0 0 {name=p105 lab=k_13}
C {devices/opin.sym} 2210 200 0 0 {name=p106 lab=k_14}
C {devices/opin.sym} 2210 240 0 0 {name=p107 lab=k_15}
C {devices/opin.sym} 2210 280 0 0 {name=p108 lab=k_1}
C {devices/opin.sym} 2210 320 0 0 {name=p109 lab=k_2}
C {devices/opin.sym} 2210 360 0 0 {name=p110 lab=k_3}
C {devices/opin.sym} 2210 400 0 0 {name=p111 lab=k_4}
C {devices/opin.sym} 2210 440 0 0 {name=p112 lab=k_5}
C {devices/opin.sym} 2210 480 0 0 {name=p113 lab=k_6}
C {devices/opin.sym} 2210 520 0 0 {name=p114 lab=k_7}
C {devices/opin.sym} 2210 560 0 0 {name=p115 lab=k_8}
C {devices/opin.sym} 2210 600 0 0 {name=p116 lab=k_9}
