v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {meta_dut_baseline: NAND flip-flop, baseline (forward nand2_2, keeper nand2_1)   (flow box: Flip-flops under test)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
T {master door} 270 -20 0 0 0.25 0.25 {}
T {master latch (measured)} 500 -20 0 0 0.25 0.25 {}
T {slave door} 730 -20 0 0 0.25 0.25 {}
T {slave latch} 960 -20 0 0 0.25 0.25 {}
C {/home/oshan/metastability-298/xschem/cells_tx/inv_1.sym} 200 330 0 0 {name=xu_cki}
C {devices/lab_pin.sym} 150 330 0 0 {name=l1 lab=clk}
C {devices/lab_pin.sym} 250 330 0 1 {name=l2 lab=clkn}
C {/home/oshan/metastability-298/xschem/cells_tx/nand2_1.sym} 330 60 0 0 {name=xu_mg1}
C {devices/lab_pin.sym} 280 50 0 0 {name=l3 lab=d}
C {devices/lab_pin.sym} 280 70 0 0 {name=l4 lab=clkn}
C {devices/lab_pin.sym} 380 50 0 1 {name=l5 lab=g1}
C {/home/oshan/metastability-298/xschem/cells_tx/nand2_1.sym} 330 210 0 0 {name=xu_mg2}
C {devices/lab_pin.sym} 280 200 0 0 {name=l6 lab=g1}
C {devices/lab_pin.sym} 280 220 0 0 {name=l7 lab=clkn}
C {devices/lab_pin.sym} 380 200 0 1 {name=l8 lab=g2}
C {/home/oshan/metastability-298/xschem/cells_tx/nand2_2.sym} 560 60 0 0 {name=xu_mfw}
C {devices/lab_pin.sym} 510 50 0 0 {name=l9 lab=mqb}
C {devices/lab_pin.sym} 510 70 0 0 {name=l10 lab=g1}
C {devices/lab_pin.sym} 610 50 0 1 {name=l11 lab=mq}
C {/home/oshan/metastability-298/xschem/cells_tx/nand2_1.sym} 560 210 0 0 {name=xu_mkp}
C {devices/lab_pin.sym} 510 200 0 0 {name=l12 lab=mq}
C {devices/lab_pin.sym} 510 220 0 0 {name=l13 lab=g2}
C {devices/lab_pin.sym} 610 200 0 1 {name=l14 lab=mqb}
C {/home/oshan/metastability-298/xschem/cells_tx/nand2_1.sym} 790 60 0 0 {name=xu_sg1}
C {devices/lab_pin.sym} 740 50 0 0 {name=l15 lab=mq}
C {devices/lab_pin.sym} 740 70 0 0 {name=l16 lab=clk}
C {devices/lab_pin.sym} 840 50 0 1 {name=l17 lab=s1}
C {/home/oshan/metastability-298/xschem/cells_tx/nand2_1.sym} 790 210 0 0 {name=xu_sg2}
C {devices/lab_pin.sym} 740 200 0 0 {name=l18 lab=s1}
C {devices/lab_pin.sym} 740 220 0 0 {name=l19 lab=clk}
C {devices/lab_pin.sym} 840 200 0 1 {name=l20 lab=s2}
C {/home/oshan/metastability-298/xschem/cells_tx/nand2_1.sym} 1020 60 0 0 {name=xu_sfw}
C {devices/lab_pin.sym} 970 50 0 0 {name=l21 lab=sqb}
C {devices/lab_pin.sym} 970 70 0 0 {name=l22 lab=s1}
C {devices/lab_pin.sym} 1070 50 0 1 {name=l23 lab=q}
C {/home/oshan/metastability-298/xschem/cells_tx/nand2_1.sym} 1020 210 0 0 {name=xu_skp}
C {devices/lab_pin.sym} 970 200 0 0 {name=l24 lab=q}
C {devices/lab_pin.sym} 970 220 0 0 {name=l25 lab=s2}
C {devices/lab_pin.sym} 1070 200 0 1 {name=l26 lab=sqb}
T {pre-layout wiring estimate (removed for LVS; extraction replaces it)} 500 330 0 0 0.22 0.22 {}
C {devices/capa.sym} 540 420 0 0 {name=Cmq value=0.25f m=1}
C {devices/lab_pin.sym} 540 390 0 0 {name=l27 lab=mq}
C {devices/lab_pin.sym} 540 450 0 0 {name=l28 lab=0}
C {devices/capa.sym} 650 420 0 0 {name=Cmqb value=0.25f m=1}
C {devices/lab_pin.sym} 650 390 0 0 {name=l29 lab=mqb}
C {devices/lab_pin.sym} 650 450 0 0 {name=l30 lab=0}
C {devices/capa.sym} 760 420 0 0 {name=Cmut value=0.05f m=1}
C {devices/lab_pin.sym} 760 390 0 0 {name=l31 lab=mq}
C {devices/lab_pin.sym} 760 450 0 0 {name=l32 lab=mqb}
C {devices/ipin.sym} 60 0 0 0 {name=p33 lab=d}
C {devices/ipin.sym} 60 40 0 0 {name=p34 lab=clk}
C {devices/opin.sym} 1280 0 0 0 {name=p35 lab=q}
