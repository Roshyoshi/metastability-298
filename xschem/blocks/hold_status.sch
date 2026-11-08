v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {hold_status: Hold and readout status: busy, done, fault flags   (flow box: Hold results + readout)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/nor2_1.sym} 200 30 0 0 {name=x146}
C {devices/lab_pin.sym} 150 20 0 0 {name=l1 lab=_102_}
C {devices/lab_pin.sym} 150 40 0 0 {name=l2 lab=_113_}
C {devices/lab_pin.sym} 250 20 0 1 {name=l3 lab=_114_}
C {@@ROOT@@/cells_tx/nand2_1.sym} 200 160 0 0 {name=x154}
C {devices/lab_pin.sym} 150 150 0 0 {name=l4 lab=reference_fault}
C {devices/lab_pin.sym} 150 170 0 0 {name=l5 lab=_117_}
C {devices/lab_pin.sym} 250 150 0 1 {name=l6 lab=_121_}
C {@@ROOT@@/cells_tx/inv_1.sym} 200 280 0 0 {name=x161}
C {devices/lab_pin.sym} 150 280 0 0 {name=l7 lab=_031_}
C {devices/lab_pin.sym} 250 280 0 1 {name=l8 lab=_032_}
C {@@ROOT@@/cells_tx/aoi21_1.sym} 460 40 0 0 {name=x162}
C {devices/lab_pin.sym} 410 20 0 0 {name=l9 lab=_124_}
C {devices/lab_pin.sym} 410 40 0 0 {name=l10 lab=_032_}
C {devices/lab_pin.sym} 410 60 0 0 {name=l11 lab=_119_}
C {devices/lab_pin.sym} 510 20 0 1 {name=l12 lab=_033_}
C {@@ROOT@@/cells_tx/mux2_1.sym} 720 40 0 0 {name=x222}
C {devices/lab_pin.sym} 670 20 0 0 {name=l13 lab=uio_out_1}
C {devices/lab_pin.sym} 670 40 0 0 {name=l14 lab=_114_}
C {devices/lab_pin.sym} 670 60 0 0 {name=l15 lab=_033_}
C {devices/lab_pin.sym} 770 20 0 1 {name=l16 lab=_001_}
C {@@ROOT@@/cells_tx/nor2_1.sym} 720 180 0 0 {name=x223}
C {devices/lab_pin.sym} 670 170 0 0 {name=l17 lab=uio_out_2}
C {devices/lab_pin.sym} 670 190 0 0 {name=l18 lab=_033_}
C {devices/lab_pin.sym} 770 170 0 1 {name=l19 lab=_075_}
C {@@ROOT@@/cells_tx/nor2_1.sym} 980 30 0 0 {name=x224}
C {devices/lab_pin.sym} 930 20 0 0 {name=l20 lab=_034_}
C {devices/lab_pin.sym} 930 40 0 0 {name=l21 lab=_075_}
C {devices/lab_pin.sym} 1030 20 0 1 {name=l22 lab=_002_}
C {@@ROOT@@/cells_tx/oai21_1.sym} 460 190 0 0 {name=x225}
C {devices/lab_pin.sym} 410 170 0 0 {name=l23 lab=_119_}
C {devices/lab_pin.sym} 410 190 0 0 {name=l24 lab=_124_}
C {devices/lab_pin.sym} 410 210 0 0 {name=l25 lab=uio_out_3}
C {devices/lab_pin.sym} 510 170 0 1 {name=l26 lab=_076_}
C {@@ROOT@@/cells_tx/nand2_1.sym} 720 310 0 0 {name=x226}
C {devices/lab_pin.sym} 670 300 0 0 {name=l27 lab=_121_}
C {devices/lab_pin.sym} 670 320 0 0 {name=l28 lab=_076_}
C {devices/lab_pin.sym} 770 300 0 1 {name=l29 lab=_003_}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 1240 40 0 0 {name=x275}
C {devices/lab_pin.sym} 1190 20 0 0 {name=l30 lab=_001_}
C {devices/lab_pin.sym} 1190 40 0 0 {name=l31 lab=rst_n}
C {devices/lab_pin.sym} 1190 60 0 0 {name=l32 lab=clk}
C {devices/lab_pin.sym} 1290 20 0 1 {name=l33 lab=uio_out_1}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 1240 190 0 0 {name=x276}
C {devices/lab_pin.sym} 1190 170 0 0 {name=l34 lab=_002_}
C {devices/lab_pin.sym} 1190 190 0 0 {name=l35 lab=rst_n}
C {devices/lab_pin.sym} 1190 210 0 0 {name=l36 lab=clk}
C {devices/lab_pin.sym} 1290 170 0 1 {name=l37 lab=uio_out_2}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 1240 340 0 0 {name=x277}
C {devices/lab_pin.sym} 1190 320 0 0 {name=l38 lab=_003_}
C {devices/lab_pin.sym} 1190 340 0 0 {name=l39 lab=rst_n}
C {devices/lab_pin.sym} 1190 360 0 0 {name=l40 lab=clk}
C {devices/lab_pin.sym} 1290 320 0 1 {name=l41 lab=uio_out_3}
C {devices/ipin.sym} 60 0 0 0 {name=p42 lab=_031_}
C {devices/ipin.sym} 60 40 0 0 {name=p43 lab=_034_}
C {devices/ipin.sym} 60 80 0 0 {name=p44 lab=_102_}
C {devices/ipin.sym} 60 120 0 0 {name=p45 lab=_113_}
C {devices/ipin.sym} 60 160 0 0 {name=p46 lab=_117_}
C {devices/ipin.sym} 60 200 0 0 {name=p47 lab=_119_}
C {devices/ipin.sym} 60 240 0 0 {name=p48 lab=_124_}
C {devices/ipin.sym} 60 280 0 0 {name=p49 lab=clk}
C {devices/ipin.sym} 60 320 0 0 {name=p50 lab=reference_fault}
C {devices/ipin.sym} 60 360 0 0 {name=p51 lab=rst_n}
C {devices/opin.sym} 1500 0 0 0 {name=p52 lab=uio_out_1}
C {devices/opin.sym} 1500 40 0 0 {name=p53 lab=uio_out_2}
C {devices/opin.sym} 1500 80 0 0 {name=p54 lab=uio_out_3}
