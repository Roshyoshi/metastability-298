v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
C {/home/oshan/metastability-298/xschem/sym/g_G01_u_cki.sym} 100 60 0 0 {name=u_cki schematic=/home/oshan/metastability-298/xschem/cells_tx/inv_1.sch}
C {/home/oshan/metastability-298/xschem/sym/g_G01_u_mg1.sym} 470 60 0 0 {name=u_mg1 schematic=/home/oshan/metastability-298/xschem/cells_tx/nand2_1.sch}
C {/home/oshan/metastability-298/xschem/sym/g_G01_u_mg2.sym} 470 320 0 0 {name=u_mg2 schematic=/home/oshan/metastability-298/xschem/cells_tx/nand2_1.sch}
C {/home/oshan/metastability-298/xschem/sym/g_G01_u_mfw.sym} 840 60 0 0 {name=u_mfw schematic=/home/oshan/metastability-298/xschem/cells_tx/nand2_2.sch}
C {/home/oshan/metastability-298/xschem/sym/g_G01_u_mkp.sym} 840 320 0 0 {name=u_mkp schematic=/home/oshan/metastability-298/xschem/cells_tx/nand2_1.sch}
C {/home/oshan/metastability-298/xschem/sym/g_G01_u_sg1.sym} 1210 60 0 0 {name=u_sg1 schematic=/home/oshan/metastability-298/xschem/cells_tx/nand2_1.sch}
C {/home/oshan/metastability-298/xschem/sym/g_G01_u_sg2.sym} 1210 320 0 0 {name=u_sg2 schematic=/home/oshan/metastability-298/xschem/cells_tx/nand2_1.sch}
C {/home/oshan/metastability-298/xschem/sym/g_G01_u_sfw.sym} 1580 60 0 0 {name=u_sfw schematic=/home/oshan/metastability-298/xschem/cells_tx/nand2_1.sch}
C {/home/oshan/metastability-298/xschem/sym/g_G01_u_skp.sym} 1580 320 0 0 {name=u_skp schematic=/home/oshan/metastability-298/xschem/cells_tx/nand2_1.sch}
N 0 70 0 170 {lab=clk}
N 0 170 0 290 {lab=clk}
N 0 170 1100 170 {lab=clk}
N 0 290 -260 290 {lab=clk}
N 1100 170 1100 370 {lab=clk}
N 1100 170 1110 170 {lab=clk}
N 1110 170 1110 110 {lab=clk}
N 1100 370 1110 370 {lab=clk}
N 1680 90 1680 240 {lab=q}
N 1680 240 1680 260 {lab=q}
N 1680 240 1480 240 {lab=q}
N 1680 260 1860 260 {lab=q}
N 1480 240 1480 330 {lab=q}
N 570 90 570 110 {lab=g1}
N 570 110 570 190 {lab=g1}
N 570 110 740 110 {lab=g1}
N 570 190 370 190 {lab=g1}
N 370 190 370 330 {lab=g1}
N 940 90 940 70 {lab=mq}
N 940 90 940 190 {lab=mq}
N 940 70 1100 70 {lab=mq}
N 1100 70 1110 70 {lab=mq}
N 940 190 740 190 {lab=mq}
N 740 190 740 330 {lab=mq}
N 1310 90 1310 110 {lab=s1}
N 1310 110 1310 240 {lab=s1}
N 1310 110 1480 110 {lab=s1}
N 1310 240 1110 240 {lab=s1}
N 1110 240 1110 330 {lab=s1}
N 200 70 200 110 {lab=clkn}
N 200 110 320 110 {lab=clkn}
N 320 110 350 110 {lab=clkn}
N 350 110 370 110 {lab=clkn}
N 350 110 350 370 {lab=clkn}
N 350 370 370 370 {lab=clkn}
N 370 70 330 70 {lab=d}
N 330 70 330 240 {lab=d}
N 330 240 -260 240 {lab=d}
N 740 70 720 70 {lab=mqb}
N 720 70 720 210 {lab=mqb}
N 720 210 930 210 {lab=mqb}
N 930 210 940 210 {lab=mqb}
N 940 210 940 350 {lab=mqb}
N 1480 70 1470 70 {lab=sqb}
N 1470 70 1470 170 {lab=sqb}
N 1470 170 1700 170 {lab=sqb}
N 1700 170 1700 350 {lab=sqb}
N 1700 350 1680 350 {lab=sqb}
N 570 350 570 370 {lab=g2}
N 570 370 740 370 {lab=g2}
N 1310 350 1310 370 {lab=s2}
N 1310 370 1480 370 {lab=s2}
C {devices/ipin.sym} -260 240 0 0 {name=p_d lab=d}
C {devices/ipin.sym} -260 290 0 0 {name=p_clk lab=clk}
C {devices/opin.sym} 1860 260 0 0 {name=p_q lab=q}
C {devices/lab_wire.sym} 320 110 0 0 {name=l1 lab=clkn}
C {devices/lab_wire.sym} 1100 70 0 0 {name=l2 lab=mq}
C {devices/lab_wire.sym} 930 210 0 0 {name=l3 lab=mqb}
L 3 20 -70 180 -70 {}
L 3 20 -70 20 -58 {}
L 3 180 -70 180 -58 {}
T {clock inverter} 20 -91.8932 0 0 0.3 0.3 {layer=3}
L 3 390 -70 550 -70 {}
L 3 390 -70 390 -58 {}
L 3 550 -70 550 -58 {}
T {master door (F05)} 390 -91.8932 0 0 0.3 0.3 {layer=3}
L 3 760 -70 920 -70 {}
L 3 760 -70 760 -58 {}
L 3 920 -70 920 -58 {}
T {master latch (F01-F04)} 760 -91.8932 0 0 0.3 0.3 {layer=3}
L 3 1130 -70 1290 -70 {}
L 3 1130 -70 1130 -58 {}
L 3 1290 -70 1290 -58 {}
T {slave door (F06)} 1130 -91.8932 0 0 0.3 0.3 {layer=3}
L 3 1500 -70 1660 -70 {}
L 3 1500 -70 1500 -58 {}
L 3 1660 -70 1660 -58 {}
T {slave latch (F06)} 1500 -91.8932 0 0 0.3 0.3 {layer=3}
T {G01  DUT2 baseline NAND flip-flop: forward nand2_2, keeper nand2_1 (gate level)} -340 -209.382 0 0 0.45 0.45 {}
T {clk low: the master door passes d into the master latch (mq). clk high: the door shuts, the master latch holds or resolves,} -340 -166.543 0 0 0.24 0.24 {}
T {and the slave door copies mq to the slave latch, which drives q. A late clock edge can leave mq/mqb between 0 and 1 (metastable).} -340 -147.218 0 0 0.24 0.24 {}
N -260 500 -160 500 {lab=clk}
C {devices/lab_wire.sym} -160 500 0 0 {name=l4 lab=clk}
T {clk} -130 490.843 0 0 0.24 0.24 {}
N -260 540 -160 540 {lab=clkn}
C {devices/lab_wire.sym} -160 540 0 0 {name=l5 lab=clkn}
T {clkn: inverted clock} -130 530.843 0 0 0.24 0.24 {}
N -260 580 -160 580 {lab=mq}
C {devices/lab_wire.sym} -160 580 0 0 {name=l6 lab=mq}
T {mq: master node} -130 570.843 0 0 0.24 0.24 {}
N -260 620 -160 620 {lab=mqb}
C {devices/lab_wire.sym} -160 620 0 0 {name=l7 lab=mqb}
T {mqb: master node (complement)} -130 610.843 0 0 0.24 0.24 {}
T {Each box is one cell (name, then cell type). Click a box and press e to see its transistors; Ctrl+e comes back. A dot marks a connection; wires that cross without a dot are not connected.} -260 654 0 0 0.2 0.2 {}
