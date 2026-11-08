v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {compare: Compare: event = early XOR late2, fault = late1 XOR late2   (flow box: Compare)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/nand2_1.sym} 200 30 0 0 {name=x135}
C {devices/lab_pin.sym} 150 20 0 0 {name=l1 lab=state_2}
C {devices/lab_pin.sym} 150 40 0 0 {name=l2 lab=_103_}
C {devices/lab_pin.sym} 250 20 0 1 {name=l3 lab=_104_}
C {@@ROOT@@/cells_tx/nand2_1.sym} 460 30 0 0 {name=x136}
C {devices/lab_pin.sym} 410 20 0 0 {name=l4 lab=_101_}
C {devices/lab_pin.sym} 410 40 0 0 {name=l5 lab=_104_}
C {devices/lab_pin.sym} 510 20 0 1 {name=l6 lab=_105_}
C {@@ROOT@@/cells_tx/oai21_1.sym} 200 170 0 0 {name=x137}
C {devices/lab_pin.sym} 150 150 0 0 {name=l7 lab=late1}
C {devices/lab_pin.sym} 150 170 0 0 {name=l8 lab=late2}
C {devices/lab_pin.sym} 150 190 0 0 {name=l9 lab=_101_}
C {devices/lab_pin.sym} 250 150 0 1 {name=l10 lab=_106_}
C {@@ROOT@@/cells_tx/aoi21_1.sym} 460 170 0 0 {name=x138}
C {devices/lab_pin.sym} 410 150 0 0 {name=l11 lab=late1}
C {devices/lab_pin.sym} 410 170 0 0 {name=l12 lab=late2}
C {devices/lab_pin.sym} 410 190 0 0 {name=l13 lab=_106_}
C {devices/lab_pin.sym} 510 150 0 1 {name=l14 lab=_107_}
C {@@ROOT@@/cells_tx/mux2_1.sym} 720 40 0 0 {name=x139}
C {devices/lab_pin.sym} 670 20 0 0 {name=l15 lab=reference_fault}
C {devices/lab_pin.sym} 670 40 0 0 {name=l16 lab=_107_}
C {devices/lab_pin.sym} 670 60 0 0 {name=l17 lab=_105_}
C {devices/lab_pin.sym} 770 20 0 1 {name=l18 lab=_010_}
C {@@ROOT@@/cells_tx/oai21_1.sym} 200 320 0 0 {name=x247}
C {devices/lab_pin.sym} 150 300 0 0 {name=l19 lab=late2}
C {devices/lab_pin.sym} 150 320 0 0 {name=l20 lab=early_q}
C {devices/lab_pin.sym} 150 340 0 0 {name=l21 lab=_101_}
C {devices/lab_pin.sym} 250 300 0 1 {name=l22 lab=_092_}
C {@@ROOT@@/cells_tx/aoi21_1.sym} 460 320 0 0 {name=x248}
C {devices/lab_pin.sym} 410 300 0 0 {name=l23 lab=late2}
C {devices/lab_pin.sym} 410 320 0 0 {name=l24 lab=early_q}
C {devices/lab_pin.sym} 410 340 0 0 {name=l25 lab=_092_}
C {devices/lab_pin.sym} 510 300 0 1 {name=l26 lab=_093_}
C {@@ROOT@@/cells_tx/mux2_1.sym} 720 190 0 0 {name=x249}
C {devices/lab_pin.sym} 670 170 0 0 {name=l27 lab=event_pending}
C {devices/lab_pin.sym} 670 190 0 0 {name=l28 lab=_093_}
C {devices/lab_pin.sym} 670 210 0 0 {name=l29 lab=_105_}
C {devices/lab_pin.sym} 770 170 0 1 {name=l30 lab=_009_}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 980 40 0 0 {name=x250}
C {devices/lab_pin.sym} 930 20 0 0 {name=l31 lab=_010_}
C {devices/lab_pin.sym} 930 40 0 0 {name=l32 lab=rst_n}
C {devices/lab_pin.sym} 930 60 0 0 {name=l33 lab=clk}
C {devices/lab_pin.sym} 1030 20 0 1 {name=l34 lab=reference_fault}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 980 190 0 0 {name=x283}
C {devices/lab_pin.sym} 930 170 0 0 {name=l35 lab=_009_}
C {devices/lab_pin.sym} 930 190 0 0 {name=l36 lab=rst_n}
C {devices/lab_pin.sym} 930 210 0 0 {name=l37 lab=clk}
C {devices/lab_pin.sym} 1030 170 0 1 {name=l38 lab=event_pending}
C {devices/ipin.sym} 60 0 0 0 {name=p39 lab=_101_}
C {devices/ipin.sym} 60 40 0 0 {name=p40 lab=_103_}
C {devices/ipin.sym} 60 80 0 0 {name=p41 lab=clk}
C {devices/ipin.sym} 60 120 0 0 {name=p42 lab=early_q}
C {devices/ipin.sym} 60 160 0 0 {name=p43 lab=late1}
C {devices/ipin.sym} 60 200 0 0 {name=p44 lab=late2}
C {devices/ipin.sym} 60 240 0 0 {name=p45 lab=rst_n}
C {devices/ipin.sym} 60 280 0 0 {name=p46 lab=state_2}
C {devices/opin.sym} 1240 0 0 0 {name=p47 lab=event_pending}
C {devices/opin.sym} 1240 40 0 0 {name=p48 lab=reference_fault}
