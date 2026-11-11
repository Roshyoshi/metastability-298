v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {trial_counter: Trial counter n: each bit clocked by the bit below, except n_1 by n_n_0; n_16 rises on count 65,535   (flow box: Counter N)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 300 0 0 0 {name=xn0_ff}
C {devices/lab_pin.sym} 250 -20 0 0 {name=l1 lab=n_n_0}
C {devices/lab_pin.sym} 250 0 0 0 {name=l2 lab=run}
C {devices/lab_pin.sym} 250 20 0 0 {name=l3 lab=tick_n}
C {devices/lab_pin.sym} 350 -20 0 1 {name=l4 lab=n_0}
C {@@ROOT@@/cells_tx/inv_1.sym} 300 120 0 0 {name=xn0_inv}
C {devices/lab_pin.sym} 250 120 0 0 {name=l5 lab=n_0}
C {devices/lab_pin.sym} 350 120 0 1 {name=l6 lab=n_n_0}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 1620 260 0 0 {name=xn10_ff}
C {devices/lab_pin.sym} 1570 240 0 0 {name=l7 lab=n_n_10}
C {devices/lab_pin.sym} 1570 260 0 0 {name=l8 lab=run}
C {devices/lab_pin.sym} 1570 280 0 0 {name=l9 lab=n_9}
C {devices/lab_pin.sym} 1670 240 0 1 {name=l10 lab=n_10}
C {@@ROOT@@/cells_tx/inv_1.sym} 1620 380 0 0 {name=xn10_inv}
C {devices/lab_pin.sym} 1570 380 0 0 {name=l11 lab=n_10}
C {devices/lab_pin.sym} 1670 380 0 1 {name=l12 lab=n_n_10}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 1950 260 0 0 {name=xn11_ff}
C {devices/lab_pin.sym} 1900 240 0 0 {name=l13 lab=n_n_11}
C {devices/lab_pin.sym} 1900 260 0 0 {name=l14 lab=run}
C {devices/lab_pin.sym} 1900 280 0 0 {name=l15 lab=n_10}
C {devices/lab_pin.sym} 2000 240 0 1 {name=l16 lab=n_11}
C {@@ROOT@@/cells_tx/inv_1.sym} 1950 380 0 0 {name=xn11_inv}
C {devices/lab_pin.sym} 1900 380 0 0 {name=l17 lab=n_11}
C {devices/lab_pin.sym} 2000 380 0 1 {name=l18 lab=n_n_11}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 300 520 0 0 {name=xn12_ff}
C {devices/lab_pin.sym} 250 500 0 0 {name=l19 lab=n_n_12}
C {devices/lab_pin.sym} 250 520 0 0 {name=l20 lab=run}
C {devices/lab_pin.sym} 250 540 0 0 {name=l21 lab=n_11}
C {devices/lab_pin.sym} 350 500 0 1 {name=l22 lab=n_12}
C {@@ROOT@@/cells_tx/inv_1.sym} 300 640 0 0 {name=xn12_inv}
C {devices/lab_pin.sym} 250 640 0 0 {name=l23 lab=n_12}
C {devices/lab_pin.sym} 350 640 0 1 {name=l24 lab=n_n_12}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 630 520 0 0 {name=xn13_ff}
C {devices/lab_pin.sym} 580 500 0 0 {name=l25 lab=n_n_13}
C {devices/lab_pin.sym} 580 520 0 0 {name=l26 lab=run}
C {devices/lab_pin.sym} 580 540 0 0 {name=l27 lab=n_12}
C {devices/lab_pin.sym} 680 500 0 1 {name=l28 lab=n_13}
C {@@ROOT@@/cells_tx/inv_1.sym} 630 640 0 0 {name=xn13_inv}
C {devices/lab_pin.sym} 580 640 0 0 {name=l29 lab=n_13}
C {devices/lab_pin.sym} 680 640 0 1 {name=l30 lab=n_n_13}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 960 520 0 0 {name=xn14_ff}
C {devices/lab_pin.sym} 910 500 0 0 {name=l31 lab=n_n_14}
C {devices/lab_pin.sym} 910 520 0 0 {name=l32 lab=run}
C {devices/lab_pin.sym} 910 540 0 0 {name=l33 lab=n_13}
C {devices/lab_pin.sym} 1010 500 0 1 {name=l34 lab=n_14}
C {@@ROOT@@/cells_tx/inv_1.sym} 960 640 0 0 {name=xn14_inv}
C {devices/lab_pin.sym} 910 640 0 0 {name=l35 lab=n_14}
C {devices/lab_pin.sym} 1010 640 0 1 {name=l36 lab=n_n_14}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 1290 520 0 0 {name=xn15_ff}
C {devices/lab_pin.sym} 1240 500 0 0 {name=l37 lab=n_n_15}
C {devices/lab_pin.sym} 1240 520 0 0 {name=l38 lab=run}
C {devices/lab_pin.sym} 1240 540 0 0 {name=l39 lab=n_14}
C {devices/lab_pin.sym} 1340 500 0 1 {name=l40 lab=n_15}
C {@@ROOT@@/cells_tx/inv_1.sym} 1290 640 0 0 {name=xn15_inv}
C {devices/lab_pin.sym} 1240 640 0 0 {name=l41 lab=n_15}
C {devices/lab_pin.sym} 1340 640 0 1 {name=l42 lab=n_n_15}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 1620 520 0 0 {name=xn16_ff}
C {devices/lab_pin.sym} 1570 500 0 0 {name=l43 lab=n_n_16}
C {devices/lab_pin.sym} 1570 520 0 0 {name=l44 lab=run}
C {devices/lab_pin.sym} 1570 540 0 0 {name=l45 lab=n_15}
C {devices/lab_pin.sym} 1670 500 0 1 {name=l46 lab=n_16}
C {@@ROOT@@/cells_tx/inv_1.sym} 1620 640 0 0 {name=xn16_inv}
C {devices/lab_pin.sym} 1570 640 0 0 {name=l47 lab=n_16}
C {devices/lab_pin.sym} 1670 640 0 1 {name=l48 lab=n_n_16}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 630 0 0 0 {name=xn1_ff}
C {devices/lab_pin.sym} 580 -20 0 0 {name=l49 lab=n_n_1}
C {devices/lab_pin.sym} 580 0 0 0 {name=l50 lab=run}
C {devices/lab_pin.sym} 580 20 0 0 {name=l51 lab=n_n_0}
C {devices/lab_pin.sym} 680 -20 0 1 {name=l52 lab=n_1}
C {@@ROOT@@/cells_tx/inv_1.sym} 630 120 0 0 {name=xn1_inv}
C {devices/lab_pin.sym} 580 120 0 0 {name=l53 lab=n_1}
C {devices/lab_pin.sym} 680 120 0 1 {name=l54 lab=n_n_1}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 960 0 0 0 {name=xn2_ff}
C {devices/lab_pin.sym} 910 -20 0 0 {name=l55 lab=n_n_2}
C {devices/lab_pin.sym} 910 0 0 0 {name=l56 lab=run}
C {devices/lab_pin.sym} 910 20 0 0 {name=l57 lab=n_1}
C {devices/lab_pin.sym} 1010 -20 0 1 {name=l58 lab=n_2}
C {@@ROOT@@/cells_tx/inv_1.sym} 960 120 0 0 {name=xn2_inv}
C {devices/lab_pin.sym} 910 120 0 0 {name=l59 lab=n_2}
C {devices/lab_pin.sym} 1010 120 0 1 {name=l60 lab=n_n_2}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 1290 0 0 0 {name=xn3_ff}
C {devices/lab_pin.sym} 1240 -20 0 0 {name=l61 lab=n_n_3}
C {devices/lab_pin.sym} 1240 0 0 0 {name=l62 lab=run}
C {devices/lab_pin.sym} 1240 20 0 0 {name=l63 lab=n_2}
C {devices/lab_pin.sym} 1340 -20 0 1 {name=l64 lab=n_3}
C {@@ROOT@@/cells_tx/inv_1.sym} 1290 120 0 0 {name=xn3_inv}
C {devices/lab_pin.sym} 1240 120 0 0 {name=l65 lab=n_3}
C {devices/lab_pin.sym} 1340 120 0 1 {name=l66 lab=n_n_3}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 1620 0 0 0 {name=xn4_ff}
C {devices/lab_pin.sym} 1570 -20 0 0 {name=l67 lab=n_n_4}
C {devices/lab_pin.sym} 1570 0 0 0 {name=l68 lab=run}
C {devices/lab_pin.sym} 1570 20 0 0 {name=l69 lab=n_3}
C {devices/lab_pin.sym} 1670 -20 0 1 {name=l70 lab=n_4}
C {@@ROOT@@/cells_tx/inv_1.sym} 1620 120 0 0 {name=xn4_inv}
C {devices/lab_pin.sym} 1570 120 0 0 {name=l71 lab=n_4}
C {devices/lab_pin.sym} 1670 120 0 1 {name=l72 lab=n_n_4}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 1950 0 0 0 {name=xn5_ff}
C {devices/lab_pin.sym} 1900 -20 0 0 {name=l73 lab=n_n_5}
C {devices/lab_pin.sym} 1900 0 0 0 {name=l74 lab=run}
C {devices/lab_pin.sym} 1900 20 0 0 {name=l75 lab=n_4}
C {devices/lab_pin.sym} 2000 -20 0 1 {name=l76 lab=n_5}
C {@@ROOT@@/cells_tx/inv_1.sym} 1950 120 0 0 {name=xn5_inv}
C {devices/lab_pin.sym} 1900 120 0 0 {name=l77 lab=n_5}
C {devices/lab_pin.sym} 2000 120 0 1 {name=l78 lab=n_n_5}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 300 260 0 0 {name=xn6_ff}
C {devices/lab_pin.sym} 250 240 0 0 {name=l79 lab=n_n_6}
C {devices/lab_pin.sym} 250 260 0 0 {name=l80 lab=run}
C {devices/lab_pin.sym} 250 280 0 0 {name=l81 lab=n_5}
C {devices/lab_pin.sym} 350 240 0 1 {name=l82 lab=n_6}
C {@@ROOT@@/cells_tx/inv_1.sym} 300 380 0 0 {name=xn6_inv}
C {devices/lab_pin.sym} 250 380 0 0 {name=l83 lab=n_6}
C {devices/lab_pin.sym} 350 380 0 1 {name=l84 lab=n_n_6}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 630 260 0 0 {name=xn7_ff}
C {devices/lab_pin.sym} 580 240 0 0 {name=l85 lab=n_n_7}
C {devices/lab_pin.sym} 580 260 0 0 {name=l86 lab=run}
C {devices/lab_pin.sym} 580 280 0 0 {name=l87 lab=n_6}
C {devices/lab_pin.sym} 680 240 0 1 {name=l88 lab=n_7}
C {@@ROOT@@/cells_tx/inv_1.sym} 630 380 0 0 {name=xn7_inv}
C {devices/lab_pin.sym} 580 380 0 0 {name=l89 lab=n_7}
C {devices/lab_pin.sym} 680 380 0 1 {name=l90 lab=n_n_7}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 960 260 0 0 {name=xn8_ff}
C {devices/lab_pin.sym} 910 240 0 0 {name=l91 lab=n_n_8}
C {devices/lab_pin.sym} 910 260 0 0 {name=l92 lab=run}
C {devices/lab_pin.sym} 910 280 0 0 {name=l93 lab=n_7}
C {devices/lab_pin.sym} 1010 240 0 1 {name=l94 lab=n_8}
C {@@ROOT@@/cells_tx/inv_1.sym} 960 380 0 0 {name=xn8_inv}
C {devices/lab_pin.sym} 910 380 0 0 {name=l95 lab=n_8}
C {devices/lab_pin.sym} 1010 380 0 1 {name=l96 lab=n_n_8}
C {@@ROOT@@/cells_tx/dffnrnq_1.sym} 1290 260 0 0 {name=xn9_ff}
C {devices/lab_pin.sym} 1240 240 0 0 {name=l97 lab=n_n_9}
C {devices/lab_pin.sym} 1240 260 0 0 {name=l98 lab=run}
C {devices/lab_pin.sym} 1240 280 0 0 {name=l99 lab=n_8}
C {devices/lab_pin.sym} 1340 240 0 1 {name=l100 lab=n_9}
C {@@ROOT@@/cells_tx/inv_1.sym} 1290 380 0 0 {name=xn9_inv}
C {devices/lab_pin.sym} 1240 380 0 0 {name=l101 lab=n_9}
C {devices/lab_pin.sym} 1340 380 0 1 {name=l102 lab=n_n_9}
C {devices/ipin.sym} 60 0 0 0 {name=p103 lab=run}
C {devices/ipin.sym} 60 40 0 0 {name=p104 lab=tick_n}
C {devices/opin.sym} 2210 0 0 0 {name=p105 lab=n_16}
