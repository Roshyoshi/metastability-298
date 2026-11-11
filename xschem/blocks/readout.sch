v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {readout: Readout: uo_out = k[7:0] when byte_sel (ui_in_0) is 0, k[15:8] when it is 1   (flow box: Readout)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/mux2_1.sym} 300 0 0 0 {name=xbyte0_mux}
C {devices/lab_pin.sym} 250 -20 0 0 {name=l1 lab=k_0}
C {devices/lab_pin.sym} 250 0 0 0 {name=l2 lab=k_8}
C {devices/lab_pin.sym} 250 20 0 0 {name=l3 lab=ui_in_0}
C {devices/lab_pin.sym} 350 -20 0 1 {name=l4 lab=uo_out_0}
C {@@ROOT@@/cells_tx/mux2_1.sym} 630 0 0 0 {name=xbyte1_mux}
C {devices/lab_pin.sym} 580 -20 0 0 {name=l5 lab=k_1}
C {devices/lab_pin.sym} 580 0 0 0 {name=l6 lab=k_9}
C {devices/lab_pin.sym} 580 20 0 0 {name=l7 lab=ui_in_0}
C {devices/lab_pin.sym} 680 -20 0 1 {name=l8 lab=uo_out_1}
C {@@ROOT@@/cells_tx/mux2_1.sym} 960 0 0 0 {name=xbyte2_mux}
C {devices/lab_pin.sym} 910 -20 0 0 {name=l9 lab=k_2}
C {devices/lab_pin.sym} 910 0 0 0 {name=l10 lab=k_10}
C {devices/lab_pin.sym} 910 20 0 0 {name=l11 lab=ui_in_0}
C {devices/lab_pin.sym} 1010 -20 0 1 {name=l12 lab=uo_out_2}
C {@@ROOT@@/cells_tx/mux2_1.sym} 1290 0 0 0 {name=xbyte3_mux}
C {devices/lab_pin.sym} 1240 -20 0 0 {name=l13 lab=k_3}
C {devices/lab_pin.sym} 1240 0 0 0 {name=l14 lab=k_11}
C {devices/lab_pin.sym} 1240 20 0 0 {name=l15 lab=ui_in_0}
C {devices/lab_pin.sym} 1340 -20 0 1 {name=l16 lab=uo_out_3}
C {@@ROOT@@/cells_tx/mux2_1.sym} 300 170 0 0 {name=xbyte4_mux}
C {devices/lab_pin.sym} 250 150 0 0 {name=l17 lab=k_4}
C {devices/lab_pin.sym} 250 170 0 0 {name=l18 lab=k_12}
C {devices/lab_pin.sym} 250 190 0 0 {name=l19 lab=ui_in_0}
C {devices/lab_pin.sym} 350 150 0 1 {name=l20 lab=uo_out_4}
C {@@ROOT@@/cells_tx/mux2_1.sym} 630 170 0 0 {name=xbyte5_mux}
C {devices/lab_pin.sym} 580 150 0 0 {name=l21 lab=k_5}
C {devices/lab_pin.sym} 580 170 0 0 {name=l22 lab=k_13}
C {devices/lab_pin.sym} 580 190 0 0 {name=l23 lab=ui_in_0}
C {devices/lab_pin.sym} 680 150 0 1 {name=l24 lab=uo_out_5}
C {@@ROOT@@/cells_tx/mux2_1.sym} 960 170 0 0 {name=xbyte6_mux}
C {devices/lab_pin.sym} 910 150 0 0 {name=l25 lab=k_6}
C {devices/lab_pin.sym} 910 170 0 0 {name=l26 lab=k_14}
C {devices/lab_pin.sym} 910 190 0 0 {name=l27 lab=ui_in_0}
C {devices/lab_pin.sym} 1010 150 0 1 {name=l28 lab=uo_out_6}
C {@@ROOT@@/cells_tx/mux2_1.sym} 1290 170 0 0 {name=xbyte7_mux}
C {devices/lab_pin.sym} 1240 150 0 0 {name=l29 lab=k_7}
C {devices/lab_pin.sym} 1240 170 0 0 {name=l30 lab=k_15}
C {devices/lab_pin.sym} 1240 190 0 0 {name=l31 lab=ui_in_0}
C {devices/lab_pin.sym} 1340 150 0 1 {name=l32 lab=uo_out_7}
C {devices/ipin.sym} 60 0 0 0 {name=p33 lab=k_0}
C {devices/ipin.sym} 60 40 0 0 {name=p34 lab=k_10}
C {devices/ipin.sym} 60 80 0 0 {name=p35 lab=k_11}
C {devices/ipin.sym} 60 120 0 0 {name=p36 lab=k_12}
C {devices/ipin.sym} 60 160 0 0 {name=p37 lab=k_13}
C {devices/ipin.sym} 60 200 0 0 {name=p38 lab=k_14}
C {devices/ipin.sym} 60 240 0 0 {name=p39 lab=k_15}
C {devices/ipin.sym} 60 280 0 0 {name=p40 lab=k_1}
C {devices/ipin.sym} 60 320 0 0 {name=p41 lab=k_2}
C {devices/ipin.sym} 60 360 0 0 {name=p42 lab=k_3}
C {devices/ipin.sym} 60 400 0 0 {name=p43 lab=k_4}
C {devices/ipin.sym} 60 440 0 0 {name=p44 lab=k_5}
C {devices/ipin.sym} 60 480 0 0 {name=p45 lab=k_6}
C {devices/ipin.sym} 60 520 0 0 {name=p46 lab=k_7}
C {devices/ipin.sym} 60 560 0 0 {name=p47 lab=k_8}
C {devices/ipin.sym} 60 600 0 0 {name=p48 lab=k_9}
C {devices/ipin.sym} 60 640 0 0 {name=p49 lab=ui_in_0}
C {devices/opin.sym} 1550 0 0 0 {name=p50 lab=uo_out_0}
C {devices/opin.sym} 1550 40 0 0 {name=p51 lab=uo_out_1}
C {devices/opin.sym} 1550 80 0 0 {name=p52 lab=uo_out_2}
C {devices/opin.sym} 1550 120 0 0 {name=p53 lab=uo_out_3}
C {devices/opin.sym} 1550 160 0 0 {name=p54 lab=uo_out_4}
C {devices/opin.sym} 1550 200 0 0 {name=p55 lab=uo_out_5}
C {devices/opin.sym} 1550 240 0 0 {name=p56 lab=uo_out_6}
C {devices/opin.sym} 1550 280 0 0 {name=p57 lab=uo_out_7}
