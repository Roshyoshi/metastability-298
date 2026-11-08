v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {late_observers: Late observers: late1 (50 ns) and late2 (100 ns) samples   (flow box: Late observers)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/nor2_1.sym} 200 30 0 0 {name=x140}
C {devices/lab_pin.sym} 150 20 0 0 {name=l1 lab=state_0}
C {devices/lab_pin.sym} 150 40 0 0 {name=l2 lab=state_1}
C {devices/lab_pin.sym} 250 20 0 1 {name=l3 lab=_108_}
C {@@ROOT@@/cells_tx/nand2_1.sym} 200 160 0 0 {name=x242}
C {devices/lab_pin.sym} 150 150 0 0 {name=l4 lab=_101_}
C {devices/lab_pin.sym} 150 170 0 0 {name=l5 lab=_086_}
C {devices/lab_pin.sym} 250 150 0 1 {name=l6 lab=_089_}
C {@@ROOT@@/cells_tx/and2_1.sym} 200 290 0 0 {name=x243}
C {devices/lab_pin.sym} 150 280 0 0 {name=l7 lab=selected_q}
C {devices/lab_pin.sym} 150 300 0 0 {name=l8 lab=_101_}
C {devices/lab_pin.sym} 250 280 0 1 {name=l9 lab=_090_}
C {@@ROOT@@/cells_tx/mux2_1.sym} 460 40 0 0 {name=x244}
C {devices/lab_pin.sym} 410 20 0 0 {name=l10 lab=late1}
C {devices/lab_pin.sym} 410 40 0 0 {name=l11 lab=_090_}
C {devices/lab_pin.sym} 410 60 0 0 {name=l12 lab=_089_}
C {devices/lab_pin.sym} 510 20 0 1 {name=l13 lab=_007_}
C {@@ROOT@@/cells_tx/aoi21_1.sym} 460 190 0 0 {name=x245}
C {devices/lab_pin.sym} 410 170 0 0 {name=l14 lab=state_2}
C {devices/lab_pin.sym} 410 190 0 0 {name=l15 lab=_108_}
C {devices/lab_pin.sym} 410 210 0 0 {name=l16 lab=_102_}
C {devices/lab_pin.sym} 510 170 0 1 {name=l17 lab=_091_}
C {@@ROOT@@/cells_tx/mux2_1.sym} 720 40 0 0 {name=x246}
C {devices/lab_pin.sym} 670 20 0 0 {name=l18 lab=_090_}
C {devices/lab_pin.sym} 670 40 0 0 {name=l19 lab=late2}
C {devices/lab_pin.sym} 670 60 0 0 {name=l20 lab=_091_}
C {devices/lab_pin.sym} 770 20 0 1 {name=l21 lab=_008_}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 980 40 0 0 {name=x281}
C {devices/lab_pin.sym} 930 20 0 0 {name=l22 lab=_007_}
C {devices/lab_pin.sym} 930 40 0 0 {name=l23 lab=rst_n}
C {devices/lab_pin.sym} 930 60 0 0 {name=l24 lab=clk}
C {devices/lab_pin.sym} 1030 20 0 1 {name=l25 lab=late1}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 980 190 0 0 {name=x282}
C {devices/lab_pin.sym} 930 170 0 0 {name=l26 lab=_008_}
C {devices/lab_pin.sym} 930 190 0 0 {name=l27 lab=rst_n}
C {devices/lab_pin.sym} 930 210 0 0 {name=l28 lab=clk}
C {devices/lab_pin.sym} 1030 170 0 1 {name=l29 lab=late2}
C {devices/ipin.sym} 60 0 0 0 {name=p30 lab=_086_}
C {devices/ipin.sym} 60 40 0 0 {name=p31 lab=_101_}
C {devices/ipin.sym} 60 80 0 0 {name=p32 lab=_102_}
C {devices/ipin.sym} 60 120 0 0 {name=p33 lab=clk}
C {devices/ipin.sym} 60 160 0 0 {name=p34 lab=rst_n}
C {devices/ipin.sym} 60 200 0 0 {name=p35 lab=selected_q}
C {devices/ipin.sym} 60 240 0 0 {name=p36 lab=state_0}
C {devices/ipin.sym} 60 280 0 0 {name=p37 lab=state_1}
C {devices/ipin.sym} 60 320 0 0 {name=p38 lab=state_2}
C {devices/opin.sym} 1240 0 0 0 {name=p39 lab=late1}
C {devices/opin.sym} 1240 40 0 0 {name=p40 lab=late2}
