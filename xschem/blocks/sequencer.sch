v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {sequencer: Sequencer: state register, START/reset synchronizers, shared state decode   (flow box: Sequencer)} 0 -170 0 0 0.4 0.4 {}
T {Press e on a cell to see its transistors; Ctrl+e returns here.} 0 -140 0 0 0.25 0.25 {}
C {@@ROOT@@/cells_tx/inv_1.sym} 460 20 0 0 {name=x125}
C {devices/lab_pin.sym} 410 20 0 0 {name=l1 lab=capture}
C {devices/lab_pin.sym} 510 20 0 1 {name=l2 lab=_094_}
C {@@ROOT@@/cells_tx/inv_1.sym} 200 20 0 0 {name=x127}
C {devices/lab_pin.sym} 150 20 0 0 {name=l3 lab=trials_7}
C {devices/lab_pin.sym} 250 20 0 1 {name=l4 lab=_096_}
C {@@ROOT@@/cells_tx/inv_1.sym} 460 130 0 0 {name=x128}
C {devices/lab_pin.sym} 410 130 0 0 {name=l5 lab=state_0}
C {devices/lab_pin.sym} 510 130 0 1 {name=l6 lab=_097_}
C {@@ROOT@@/cells_tx/inv_1.sym} 460 240 0 0 {name=x129}
C {devices/lab_pin.sym} 410 240 0 0 {name=l7 lab=state_1}
C {devices/lab_pin.sym} 510 240 0 1 {name=l8 lab=_098_}
C {@@ROOT@@/cells_tx/inv_1.sym} 460 350 0 0 {name=x130}
C {devices/lab_pin.sym} 410 350 0 0 {name=l9 lab=state_2}
C {devices/lab_pin.sym} 510 350 0 1 {name=l10 lab=_099_}
C {@@ROOT@@/cells_tx/inv_1.sym} 460 460 0 0 {name=x131}
C {devices/lab_pin.sym} 410 460 0 0 {name=l11 lab=start_previous}
C {devices/lab_pin.sym} 510 460 0 1 {name=l12 lab=_100_}
C {@@ROOT@@/cells_tx/and2_1.sym} 460 580 0 0 {name=x132}
C {devices/lab_pin.sym} 410 570 0 0 {name=l13 lab=reset_release_1}
C {devices/lab_pin.sym} 410 590 0 0 {name=l14 lab=ena}
C {devices/lab_pin.sym} 510 570 0 1 {name=l15 lab=_101_}
C {@@ROOT@@/cells_tx/nand2_1.sym} 460 710 0 0 {name=x133}
C {devices/lab_pin.sym} 410 700 0 0 {name=l16 lab=reset_release_1}
C {devices/lab_pin.sym} 410 720 0 0 {name=l17 lab=ena}
C {devices/lab_pin.sym} 510 700 0 1 {name=l18 lab=_102_}
C {@@ROOT@@/cells_tx/nor2_1.sym} 720 30 0 0 {name=x134}
C {devices/lab_pin.sym} 670 20 0 0 {name=l19 lab=_097_}
C {devices/lab_pin.sym} 670 40 0 0 {name=l20 lab=state_1}
C {devices/lab_pin.sym} 770 20 0 1 {name=l21 lab=_103_}
C {@@ROOT@@/cells_tx/nor3_1.sym} 460 850 0 0 {name=x141}
C {devices/lab_pin.sym} 410 830 0 0 {name=l22 lab=state_0}
C {devices/lab_pin.sym} 410 850 0 0 {name=l23 lab=state_1}
C {devices/lab_pin.sym} 410 870 0 0 {name=l24 lab=state_2}
C {devices/lab_pin.sym} 510 830 0 1 {name=l25 lab=_109_}
C {@@ROOT@@/cells_tx/nand2_1.sym} 720 160 0 0 {name=x142}
C {devices/lab_pin.sym} 670 150 0 0 {name=l26 lab=_101_}
C {devices/lab_pin.sym} 670 170 0 0 {name=l27 lab=_109_}
C {devices/lab_pin.sym} 770 150 0 1 {name=l28 lab=_110_}
C {@@ROOT@@/cells_tx/aoi21_1.sym} 980 40 0 0 {name=x143}
C {devices/lab_pin.sym} 930 20 0 0 {name=l29 lab=start_sync_1}
C {devices/lab_pin.sym} 930 40 0 0 {name=l30 lab=_100_}
C {devices/lab_pin.sym} 930 60 0 0 {name=l31 lab=_110_}
C {devices/lab_pin.sym} 1030 20 0 1 {name=l32 lab=_111_}
C {@@ROOT@@/cells_tx/nand3_1.sym} 720 300 0 0 {name=x144}
C {devices/lab_pin.sym} 670 280 0 0 {name=l33 lab=_097_}
C {devices/lab_pin.sym} 670 300 0 0 {name=l34 lab=state_1}
C {devices/lab_pin.sym} 670 320 0 0 {name=l35 lab=_099_}
C {devices/lab_pin.sym} 770 280 0 1 {name=l36 lab=_112_}
C {@@ROOT@@/cells_tx/nor3_1.sym} 720 450 0 0 {name=x145}
C {devices/lab_pin.sym} 670 430 0 0 {name=l37 lab=state_0}
C {devices/lab_pin.sym} 670 450 0 0 {name=l38 lab=_098_}
C {devices/lab_pin.sym} 670 470 0 0 {name=l39 lab=_099_}
C {devices/lab_pin.sym} 770 430 0 1 {name=l40 lab=_113_}
C {@@ROOT@@/cells_tx/nor3_1.sym} 980 190 0 0 {name=x147}
C {devices/lab_pin.sym} 930 170 0 0 {name=l41 lab=_102_}
C {devices/lab_pin.sym} 930 190 0 0 {name=l42 lab=_109_}
C {devices/lab_pin.sym} 930 210 0 0 {name=l43 lab=_113_}
C {devices/lab_pin.sym} 1030 170 0 1 {name=l44 lab=_115_}
C {@@ROOT@@/cells_tx/aoi21_1.sym} 1240 40 0 0 {name=x148}
C {devices/lab_pin.sym} 1190 20 0 0 {name=l45 lab=_112_}
C {devices/lab_pin.sym} 1190 40 0 0 {name=l46 lab=_115_}
C {devices/lab_pin.sym} 1190 60 0 0 {name=l47 lab=_111_}
C {devices/lab_pin.sym} 1290 20 0 1 {name=l48 lab=_116_}
C {@@ROOT@@/cells_tx/oai22_1.sym} 1500 50 0 0 {name=x149}
C {devices/lab_pin.sym} 1450 20 0 0 {name=l49 lab=_102_}
C {devices/lab_pin.sym} 1450 40 0 0 {name=l50 lab=_112_}
C {devices/lab_pin.sym} 1450 60 0 0 {name=l51 lab=_116_}
C {devices/lab_pin.sym} 1450 80 0 0 {name=l52 lab=_094_}
C {devices/lab_pin.sym} 1550 20 0 1 {name=l53 lab=_011_}
C {@@ROOT@@/cells_tx/nor4_1.sym} 720 610 0 0 {name=x150}
C {devices/lab_pin.sym} 670 580 0 0 {name=l54 lab=state_0}
C {devices/lab_pin.sym} 670 600 0 0 {name=l55 lab=_098_}
C {devices/lab_pin.sym} 670 620 0 0 {name=l56 lab=_099_}
C {devices/lab_pin.sym} 670 640 0 0 {name=l57 lab=_102_}
C {devices/lab_pin.sym} 770 580 0 1 {name=l58 lab=_117_}
C {@@ROOT@@/cells_tx/nand2_1.sym} 980 330 0 0 {name=x151}
C {devices/lab_pin.sym} 930 320 0 0 {name=l59 lab=_101_}
C {devices/lab_pin.sym} 930 340 0 0 {name=l60 lab=_113_}
C {devices/lab_pin.sym} 1030 320 0 1 {name=l61 lab=_118_}
C {@@ROOT@@/cells_tx/or2_1.sym} 1240 180 0 0 {name=x152}
C {devices/lab_pin.sym} 1190 170 0 0 {name=l62 lab=_111_}
C {devices/lab_pin.sym} 1190 190 0 0 {name=l63 lab=_115_}
C {devices/lab_pin.sym} 1290 170 0 1 {name=l64 lab=_119_}
C {@@ROOT@@/cells_tx/and2_1.sym} 980 460 0 0 {name=x153}
C {devices/lab_pin.sym} 930 450 0 0 {name=l65 lab=reference_fault}
C {devices/lab_pin.sym} 930 470 0 0 {name=l66 lab=_117_}
C {devices/lab_pin.sym} 1030 450 0 1 {name=l67 lab=_120_}
C {@@ROOT@@/cells_tx/nor3_1.sym} 1240 320 0 0 {name=x155}
C {devices/lab_pin.sym} 1190 300 0 0 {name=l68 lab=_111_}
C {devices/lab_pin.sym} 1190 320 0 0 {name=l69 lab=_115_}
C {devices/lab_pin.sym} 1190 340 0 0 {name=l70 lab=_120_}
C {devices/lab_pin.sym} 1290 300 0 1 {name=l71 lab=_122_}
C {@@ROOT@@/cells_tx/nor2_1.sym} 1240 460 0 0 {name=x157}
C {devices/lab_pin.sym} 1190 450 0 0 {name=l72 lab=reference_fault}
C {devices/lab_pin.sym} 1190 470 0 0 {name=l73 lab=_118_}
C {devices/lab_pin.sym} 1290 450 0 1 {name=l74 lab=_124_}
C {@@ROOT@@/cells_tx/nand4_1.sym} 200 160 0 0 {name=x158}
C {devices/lab_pin.sym} 150 130 0 0 {name=l75 lab=trials_2}
C {devices/lab_pin.sym} 150 150 0 0 {name=l76 lab=trials_3}
C {devices/lab_pin.sym} 150 170 0 0 {name=l77 lab=trials_4}
C {devices/lab_pin.sym} 150 190 0 0 {name=l78 lab=trials_5}
C {devices/lab_pin.sym} 250 130 0 1 {name=l79 lab=_029_}
C {@@ROOT@@/cells_tx/nand2_1.sym} 200 310 0 0 {name=x159}
C {devices/lab_pin.sym} 150 300 0 0 {name=l80 lab=trials_1}
C {devices/lab_pin.sym} 150 320 0 0 {name=l81 lab=trials_6}
C {devices/lab_pin.sym} 250 300 0 1 {name=l82 lab=_030_}
C {@@ROOT@@/cells_tx/nor4_1.sym} 460 1010 0 0 {name=x160}
C {devices/lab_pin.sym} 410 980 0 0 {name=l83 lab=trials_0}
C {devices/lab_pin.sym} 410 1000 0 0 {name=l84 lab=_096_}
C {devices/lab_pin.sym} 410 1020 0 0 {name=l85 lab=_029_}
C {devices/lab_pin.sym} 410 1040 0 0 {name=l86 lab=_030_}
C {devices/lab_pin.sym} 510 980 0 1 {name=l87 lab=_031_}
C {@@ROOT@@/cells_tx/nor2_1.sym} 1500 200 0 0 {name=x163}
C {devices/lab_pin.sym} 1450 190 0 0 {name=l88 lab=_117_}
C {devices/lab_pin.sym} 1450 210 0 0 {name=l89 lab=_119_}
C {devices/lab_pin.sym} 1550 190 0 1 {name=l90 lab=_034_}
C {@@ROOT@@/cells_tx/nand2_1.sym} 1500 330 0 0 {name=x164}
C {devices/lab_pin.sym} 1450 320 0 0 {name=l91 lab=_118_}
C {devices/lab_pin.sym} 1450 340 0 0 {name=l92 lab=_122_}
C {devices/lab_pin.sym} 1550 320 0 1 {name=l93 lab=_035_}
C {@@ROOT@@/cells_tx/nand2_1.sym} 1760 30 0 0 {name=x165}
C {devices/lab_pin.sym} 1710 20 0 0 {name=l94 lab=cfg_0}
C {devices/lab_pin.sym} 1710 40 0 0 {name=l95 lab=_035_}
C {devices/lab_pin.sym} 1810 20 0 1 {name=l96 lab=_036_}
C {@@ROOT@@/cells_tx/nand3_1.sym} 1760 170 0 0 {name=x166}
C {devices/lab_pin.sym} 1710 150 0 0 {name=l97 lab=ui_in_3}
C {devices/lab_pin.sym} 1710 170 0 0 {name=l98 lab=_101_}
C {devices/lab_pin.sym} 1710 190 0 0 {name=l99 lab=_034_}
C {devices/lab_pin.sym} 1810 150 0 1 {name=l100 lab=_037_}
C {@@ROOT@@/cells_tx/nand2_1.sym} 2020 30 0 0 {name=x167}
C {devices/lab_pin.sym} 1970 20 0 0 {name=l101 lab=_036_}
C {devices/lab_pin.sym} 1970 40 0 0 {name=l102 lab=_037_}
C {devices/lab_pin.sym} 2070 20 0 1 {name=l103 lab=_012_}
C {@@ROOT@@/cells_tx/nand2_1.sym} 1760 310 0 0 {name=x168}
C {devices/lab_pin.sym} 1710 300 0 0 {name=l104 lab=cfg_1}
C {devices/lab_pin.sym} 1710 320 0 0 {name=l105 lab=_035_}
C {devices/lab_pin.sym} 1810 300 0 1 {name=l106 lab=_038_}
C {@@ROOT@@/cells_tx/nand3_1.sym} 1760 450 0 0 {name=x169}
C {devices/lab_pin.sym} 1710 430 0 0 {name=l107 lab=uio_in_6}
C {devices/lab_pin.sym} 1710 450 0 0 {name=l108 lab=_101_}
C {devices/lab_pin.sym} 1710 470 0 0 {name=l109 lab=_034_}
C {devices/lab_pin.sym} 1810 430 0 1 {name=l110 lab=_039_}
C {@@ROOT@@/cells_tx/nand2_1.sym} 2020 160 0 0 {name=x170}
C {devices/lab_pin.sym} 1970 150 0 0 {name=l111 lab=_038_}
C {devices/lab_pin.sym} 1970 170 0 0 {name=l112 lab=_039_}
C {devices/lab_pin.sym} 2070 150 0 1 {name=l113 lab=_013_}
C {@@ROOT@@/cells_tx/nand4_1.sym} 980 610 0 0 {name=x227}
C {devices/lab_pin.sym} 930 580 0 0 {name=l114 lab=_099_}
C {devices/lab_pin.sym} 930 600 0 0 {name=l115 lab=start_sync_1}
C {devices/lab_pin.sym} 930 620 0 0 {name=l116 lab=_101_}
C {devices/lab_pin.sym} 930 640 0 0 {name=l117 lab=_103_}
C {devices/lab_pin.sym} 1030 580 0 1 {name=l118 lab=_077_}
C {@@ROOT@@/cells_tx/nor2_1.sym} 1240 590 0 0 {name=x228}
C {devices/lab_pin.sym} 1190 580 0 0 {name=l119 lab=_102_}
C {devices/lab_pin.sym} 1190 600 0 0 {name=l120 lab=_111_}
C {devices/lab_pin.sym} 1290 580 0 1 {name=l121 lab=_078_}
C {@@ROOT@@/cells_tx/nand2_1.sym} 1500 460 0 0 {name=x229}
C {devices/lab_pin.sym} 1450 450 0 0 {name=l122 lab=_077_}
C {devices/lab_pin.sym} 1450 470 0 0 {name=l123 lab=_078_}
C {devices/lab_pin.sym} 1550 450 0 1 {name=l124 lab=_079_}
C {@@ROOT@@/cells_tx/nor2_1.sym} 720 760 0 0 {name=x230}
C {devices/lab_pin.sym} 670 750 0 0 {name=l125 lab=reference_fault}
C {devices/lab_pin.sym} 670 770 0 0 {name=l126 lab=_031_}
C {devices/lab_pin.sym} 770 750 0 1 {name=l127 lab=_080_}
C {@@ROOT@@/cells_tx/nand2_1.sym} 980 760 0 0 {name=x231}
C {devices/lab_pin.sym} 930 750 0 0 {name=l128 lab=_113_}
C {devices/lab_pin.sym} 930 770 0 0 {name=l129 lab=_080_}
C {devices/lab_pin.sym} 1030 750 0 1 {name=l130 lab=_081_}
C {@@ROOT@@/cells_tx/oai21_1.sym} 720 900 0 0 {name=x232}
C {devices/lab_pin.sym} 670 880 0 0 {name=l131 lab=_098_}
C {devices/lab_pin.sym} 670 900 0 0 {name=l132 lab=_099_}
C {devices/lab_pin.sym} 670 920 0 0 {name=l133 lab=_097_}
C {devices/lab_pin.sym} 770 880 0 1 {name=l134 lab=_082_}
C {@@ROOT@@/cells_tx/and2_1.sym} 1240 720 0 0 {name=x233}
C {devices/lab_pin.sym} 1190 710 0 0 {name=l135 lab=_081_}
C {devices/lab_pin.sym} 1190 730 0 0 {name=l136 lab=_082_}
C {devices/lab_pin.sym} 1290 710 0 1 {name=l137 lab=_083_}
C {@@ROOT@@/cells_tx/oai21_1.sym} 1760 600 0 0 {name=x234}
C {devices/lab_pin.sym} 1710 580 0 0 {name=l138 lab=_079_}
C {devices/lab_pin.sym} 1710 600 0 0 {name=l139 lab=_083_}
C {devices/lab_pin.sym} 1710 620 0 0 {name=l140 lab=_077_}
C {devices/lab_pin.sym} 1810 580 0 1 {name=l141 lab=_004_}
C {@@ROOT@@/cells_tx/oai21_1.sym} 720 1050 0 0 {name=x235}
C {devices/lab_pin.sym} 670 1030 0 0 {name=l142 lab=_098_}
C {devices/lab_pin.sym} 670 1050 0 0 {name=l143 lab=state_2}
C {devices/lab_pin.sym} 670 1070 0 0 {name=l144 lab=state_0}
C {devices/lab_pin.sym} 770 1030 0 1 {name=l145 lab=_084_}
C {@@ROOT@@/cells_tx/and3_1.sym} 1240 860 0 0 {name=x236}
C {devices/lab_pin.sym} 1190 840 0 0 {name=l146 lab=_112_}
C {devices/lab_pin.sym} 1190 860 0 0 {name=l147 lab=_081_}
C {devices/lab_pin.sym} 1190 880 0 0 {name=l148 lab=_084_}
C {devices/lab_pin.sym} 1290 840 0 1 {name=l149 lab=_085_}
C {@@ROOT@@/cells_tx/nor2_1.sym} 1760 740 0 0 {name=x237}
C {devices/lab_pin.sym} 1710 730 0 0 {name=l150 lab=_079_}
C {devices/lab_pin.sym} 1710 750 0 0 {name=l151 lab=_085_}
C {devices/lab_pin.sym} 1810 730 0 1 {name=l152 lab=_005_}
C {@@ROOT@@/cells_tx/nand3_1.sym} 720 1200 0 0 {name=x238}
C {devices/lab_pin.sym} 670 1180 0 0 {name=l153 lab=state_0}
C {devices/lab_pin.sym} 670 1200 0 0 {name=l154 lab=state_1}
C {devices/lab_pin.sym} 670 1220 0 0 {name=l155 lab=_099_}
C {devices/lab_pin.sym} 770 1180 0 1 {name=l156 lab=_086_}
C {@@ROOT@@/cells_tx/nand2_1.sym} 1240 1000 0 0 {name=x239}
C {devices/lab_pin.sym} 1190 990 0 0 {name=l157 lab=_081_}
C {devices/lab_pin.sym} 1190 1010 0 0 {name=l158 lab=_086_}
C {devices/lab_pin.sym} 1290 990 0 1 {name=l159 lab=_087_}
C {@@ROOT@@/cells_tx/aoi21_1.sym} 1500 600 0 0 {name=x240}
C {devices/lab_pin.sym} 1450 580 0 0 {name=l160 lab=_098_}
C {devices/lab_pin.sym} 1450 600 0 0 {name=l161 lab=state_2}
C {devices/lab_pin.sym} 1450 620 0 0 {name=l162 lab=_087_}
C {devices/lab_pin.sym} 1550 580 0 1 {name=l163 lab=_088_}
C {@@ROOT@@/cells_tx/nor2_1.sym} 1760 870 0 0 {name=x241}
C {devices/lab_pin.sym} 1710 860 0 0 {name=l164 lab=_102_}
C {devices/lab_pin.sym} 1710 880 0 0 {name=l165 lab=_088_}
C {devices/lab_pin.sym} 1810 860 0 1 {name=l166 lab=_006_}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 2280 40 0 0 {name=x251}
C {devices/lab_pin.sym} 2230 20 0 0 {name=l167 lab=tie_hi_z}
C {devices/lab_pin.sym} 2230 40 0 0 {name=l168 lab=rst_n}
C {devices/lab_pin.sym} 2230 60 0 0 {name=l169 lab=clk}
C {devices/lab_pin.sym} 2330 20 0 1 {name=l170 lab=reset_release_0}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 2280 190 0 0 {name=x252}
C {devices/lab_pin.sym} 2230 170 0 0 {name=l171 lab=reset_release_0}
C {devices/lab_pin.sym} 2230 190 0 0 {name=l172 lab=rst_n}
C {devices/lab_pin.sym} 2230 210 0 0 {name=l173 lab=clk}
C {devices/lab_pin.sym} 2330 170 0 1 {name=l174 lab=reset_release_1}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 2280 340 0 0 {name=x253}
C {devices/lab_pin.sym} 2230 320 0 0 {name=l175 lab=ui_in_4}
C {devices/lab_pin.sym} 2230 340 0 0 {name=l176 lab=rst_n}
C {devices/lab_pin.sym} 2230 360 0 0 {name=l177 lab=clk}
C {devices/lab_pin.sym} 2330 320 0 1 {name=l178 lab=start_sync_0}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 2280 490 0 0 {name=x254}
C {devices/lab_pin.sym} 2230 470 0 0 {name=l179 lab=start_sync_0}
C {devices/lab_pin.sym} 2230 490 0 0 {name=l180 lab=rst_n}
C {devices/lab_pin.sym} 2230 510 0 0 {name=l181 lab=clk}
C {devices/lab_pin.sym} 2330 470 0 1 {name=l182 lab=start_sync_1}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 2280 640 0 0 {name=x255}
C {devices/lab_pin.sym} 2230 620 0 0 {name=l183 lab=start_sync_1}
C {devices/lab_pin.sym} 2230 640 0 0 {name=l184 lab=rst_n}
C {devices/lab_pin.sym} 2230 660 0 0 {name=l185 lab=clk}
C {devices/lab_pin.sym} 2330 620 0 1 {name=l186 lab=start_previous}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 2280 790 0 0 {name=x256}
C {devices/lab_pin.sym} 2230 770 0 0 {name=l187 lab=_011_}
C {devices/lab_pin.sym} 2230 790 0 0 {name=l188 lab=rst_n}
C {devices/lab_pin.sym} 2230 810 0 0 {name=l189 lab=clk}
C {devices/lab_pin.sym} 2330 770 0 1 {name=l190 lab=capture}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 2280 940 0 0 {name=x257}
C {devices/lab_pin.sym} 2230 920 0 0 {name=l191 lab=_012_}
C {devices/lab_pin.sym} 2230 940 0 0 {name=l192 lab=rst_n}
C {devices/lab_pin.sym} 2230 960 0 0 {name=l193 lab=clk}
C {devices/lab_pin.sym} 2330 920 0 1 {name=l194 lab=cfg_0}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 2280 1090 0 0 {name=x258}
C {devices/lab_pin.sym} 2230 1070 0 0 {name=l195 lab=_013_}
C {devices/lab_pin.sym} 2230 1090 0 0 {name=l196 lab=rst_n}
C {devices/lab_pin.sym} 2230 1110 0 0 {name=l197 lab=clk}
C {devices/lab_pin.sym} 2330 1070 0 1 {name=l198 lab=cfg_1}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 2280 1240 0 0 {name=x278}
C {devices/lab_pin.sym} 2230 1220 0 0 {name=l199 lab=_004_}
C {devices/lab_pin.sym} 2230 1240 0 0 {name=l200 lab=rst_n}
C {devices/lab_pin.sym} 2230 1260 0 0 {name=l201 lab=clk}
C {devices/lab_pin.sym} 2330 1220 0 1 {name=l202 lab=state_0}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 2280 1390 0 0 {name=x279}
C {devices/lab_pin.sym} 2230 1370 0 0 {name=l203 lab=_005_}
C {devices/lab_pin.sym} 2230 1390 0 0 {name=l204 lab=rst_n}
C {devices/lab_pin.sym} 2230 1410 0 0 {name=l205 lab=clk}
C {devices/lab_pin.sym} 2330 1370 0 1 {name=l206 lab=state_1}
C {@@ROOT@@/cells_tx/dffrnq_1.sym} 2280 1540 0 0 {name=x280}
C {devices/lab_pin.sym} 2230 1520 0 0 {name=l207 lab=_006_}
C {devices/lab_pin.sym} 2230 1540 0 0 {name=l208 lab=rst_n}
C {devices/lab_pin.sym} 2230 1560 0 0 {name=l209 lab=clk}
C {devices/lab_pin.sym} 2330 1520 0 1 {name=l210 lab=state_2}
C {@@ROOT@@/cells_tx/tieh.sym} 200 430 0 0 {name=xtie_hi}
C {devices/lab_pin.sym} 250 430 0 1 {name=l211 lab=tie_hi_z}
C {devices/ipin.sym} 60 0 0 0 {name=p212 lab=clk}
C {devices/ipin.sym} 60 40 0 0 {name=p213 lab=ena}
C {devices/ipin.sym} 60 80 0 0 {name=p214 lab=reference_fault}
C {devices/ipin.sym} 60 120 0 0 {name=p215 lab=rst_n}
C {devices/ipin.sym} 60 160 0 0 {name=p216 lab=trials_0}
C {devices/ipin.sym} 60 200 0 0 {name=p217 lab=trials_1}
C {devices/ipin.sym} 60 240 0 0 {name=p218 lab=trials_2}
C {devices/ipin.sym} 60 280 0 0 {name=p219 lab=trials_3}
C {devices/ipin.sym} 60 320 0 0 {name=p220 lab=trials_4}
C {devices/ipin.sym} 60 360 0 0 {name=p221 lab=trials_5}
C {devices/ipin.sym} 60 400 0 0 {name=p222 lab=trials_6}
C {devices/ipin.sym} 60 440 0 0 {name=p223 lab=trials_7}
C {devices/ipin.sym} 60 480 0 0 {name=p224 lab=ui_in_3}
C {devices/ipin.sym} 60 520 0 0 {name=p225 lab=ui_in_4}
C {devices/ipin.sym} 60 560 0 0 {name=p226 lab=uio_in_6}
C {devices/opin.sym} 2540 0 0 0 {name=p227 lab=_031_}
C {devices/opin.sym} 2540 40 0 0 {name=p228 lab=_034_}
C {devices/opin.sym} 2540 80 0 0 {name=p229 lab=_035_}
C {devices/opin.sym} 2540 120 0 0 {name=p230 lab=_086_}
C {devices/opin.sym} 2540 160 0 0 {name=p231 lab=_096_}
C {devices/opin.sym} 2540 200 0 0 {name=p232 lab=_101_}
C {devices/opin.sym} 2540 240 0 0 {name=p233 lab=_102_}
C {devices/opin.sym} 2540 280 0 0 {name=p234 lab=_103_}
C {devices/opin.sym} 2540 320 0 0 {name=p235 lab=_111_}
C {devices/opin.sym} 2540 360 0 0 {name=p236 lab=_113_}
C {devices/opin.sym} 2540 400 0 0 {name=p237 lab=_115_}
C {devices/opin.sym} 2540 440 0 0 {name=p238 lab=_117_}
C {devices/opin.sym} 2540 480 0 0 {name=p239 lab=_119_}
C {devices/opin.sym} 2540 520 0 0 {name=p240 lab=_120_}
C {devices/opin.sym} 2540 560 0 0 {name=p241 lab=_122_}
C {devices/opin.sym} 2540 600 0 0 {name=p242 lab=_124_}
C {devices/opin.sym} 2540 640 0 0 {name=p243 lab=capture}
C {devices/opin.sym} 2540 680 0 0 {name=p244 lab=cfg_0}
C {devices/opin.sym} 2540 720 0 0 {name=p245 lab=cfg_1}
C {devices/opin.sym} 2540 760 0 0 {name=p246 lab=state_0}
C {devices/opin.sym} 2540 800 0 0 {name=p247 lab=state_1}
C {devices/opin.sym} 2540 840 0 0 {name=p248 lab=state_2}
