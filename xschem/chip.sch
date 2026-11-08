v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {chip: tt_um_metastability_characterizer: the whole tile (GF180, 1x2 analog template)} 0 -200 0 0 0.45 0.45 {}
T {Press e on a block to open it; Ctrl+e returns here. Blocks connect through equal net labels.} 0 -165 0 0 0.25 0.25 {}
C {@@ROOT@@/blocks/data_input.sym} 260 20 0 0 {name=xdata_input}
C {devices/lab_pin.sym} 180 20 0 0 {name=l1 lab=ui_in_6}
C {devices/lab_pin.sym} 340 20 0 1 {name=l2 lab=data_local}
C {@@ROOT@@/blocks/capture_drivers.sym} 780 20 0 0 {name=xcapture_drivers}
C {devices/lab_pin.sym} 700 20 0 0 {name=l3 lab=capture}
C {devices/lab_pin.sym} 860 20 0 1 {name=l4 lab=capture_local}
C {@@ROOT@@/blocks/delay.sym} 1300 30 0 0 {name=xdelay}
C {devices/lab_pin.sym} 1220 20 0 0 {name=l5 lab=capture_local}
C {devices/lab_pin.sym} 1220 40 0 0 {name=l6 lab=ua_0}
C {devices/lab_pin.sym} 1380 20 0 1 {name=l7 lab=early_clk}
C {@@ROOT@@/blocks/duts.sym} 260 230 0 0 {name=xduts}
C {devices/lab_pin.sym} 180 200 0 0 {name=l8 lab=capture_local}
C {devices/lab_pin.sym} 180 220 0 0 {name=l9 lab=data_local}
C {devices/lab_pin.sym} 340 200 0 1 {name=l10 lab=q_0}
C {devices/lab_pin.sym} 340 220 0 1 {name=l11 lab=q_1}
C {devices/lab_pin.sym} 340 240 0 1 {name=l12 lab=q_2}
C {devices/lab_pin.sym} 340 260 0 1 {name=l13 lab=q_3}
C {@@ROOT@@/blocks/selector.sym} 780 250 0 0 {name=xselector}
C {devices/lab_pin.sym} 700 200 0 0 {name=l14 lab=cfg_0}
C {devices/lab_pin.sym} 700 220 0 0 {name=l15 lab=cfg_1}
C {devices/lab_pin.sym} 700 240 0 0 {name=l16 lab=q_0}
C {devices/lab_pin.sym} 700 260 0 0 {name=l17 lab=q_1}
C {devices/lab_pin.sym} 700 280 0 0 {name=l18 lab=q_2}
C {devices/lab_pin.sym} 700 300 0 0 {name=l19 lab=q_3}
C {devices/lab_pin.sym} 860 200 0 1 {name=l20 lab=selected_q}
C {@@ROOT@@/blocks/early_observer.sym} 1300 210 0 0 {name=xearly_observer}
C {devices/lab_pin.sym} 1220 200 0 0 {name=l21 lab=early_clk}
C {devices/lab_pin.sym} 1220 220 0 0 {name=l22 lab=selected_q}
C {devices/lab_pin.sym} 1380 200 0 1 {name=l23 lab=early_q}
C {@@ROOT@@/blocks/controller.sym} 260 590 0 0 {name=xcontroller}
C {devices/lab_pin.sym} 180 460 0 0 {name=l24 lab=clk}
C {devices/lab_pin.sym} 180 480 0 0 {name=l25 lab=early_q}
C {devices/lab_pin.sym} 180 500 0 0 {name=l26 lab=ena}
C {devices/lab_pin.sym} 180 520 0 0 {name=l27 lab=rst_n}
C {devices/lab_pin.sym} 180 540 0 0 {name=l28 lab=selected_q}
C {devices/lab_pin.sym} 180 560 0 0 {name=l29 lab=ui_in_3}
C {devices/lab_pin.sym} 180 580 0 0 {name=l30 lab=ui_in_4}
C {devices/lab_pin.sym} 180 600 0 0 {name=l31 lab=uio_in_6}
C {devices/lab_pin.sym} 340 460 0 1 {name=l32 lab=capture}
C {devices/lab_pin.sym} 340 480 0 1 {name=l33 lab=cfg_0}
C {devices/lab_pin.sym} 340 500 0 1 {name=l34 lab=cfg_1}
C {devices/lab_pin.sym} 340 520 0 1 {name=l35 lab=uio_out_1}
C {devices/lab_pin.sym} 340 540 0 1 {name=l36 lab=uio_out_2}
C {devices/lab_pin.sym} 340 560 0 1 {name=l37 lab=uio_out_3}
C {devices/lab_pin.sym} 340 580 0 1 {name=l38 lab=uo_out_0}
C {devices/lab_pin.sym} 340 600 0 1 {name=l39 lab=uo_out_1}
C {devices/lab_pin.sym} 340 620 0 1 {name=l40 lab=uo_out_2}
C {devices/lab_pin.sym} 340 640 0 1 {name=l41 lab=uo_out_3}
C {devices/lab_pin.sym} 340 660 0 1 {name=l42 lab=uo_out_4}
C {devices/lab_pin.sym} 340 680 0 1 {name=l43 lab=uo_out_5}
C {devices/lab_pin.sym} 340 700 0 1 {name=l44 lab=uo_out_6}
C {devices/lab_pin.sym} 340 720 0 1 {name=l45 lab=uo_out_7}
C {@@ROOT@@/blocks/monitors.sym} 780 470 0 0 {name=xmonitors}
C {devices/lab_pin.sym} 700 460 0 0 {name=l46 lab=capture_local}
C {devices/lab_pin.sym} 700 480 0 0 {name=l47 lab=early_clk}
C {devices/lab_pin.sym} 860 460 0 1 {name=l48 lab=uio_out_4}
C {devices/lab_pin.sym} 860 480 0 1 {name=l49 lab=uio_out_5}
C {@@ROOT@@/blocks/pin_drivers.sym} 1300 560 0 0 {name=xpin_drivers}
C {devices/lab_pin.sym} 1220 460 0 0 {name=l50 lab=ena}
C {devices/lab_pin.sym} 1380 460 0 1 {name=l51 lab=uio_oe_0}
C {devices/lab_pin.sym} 1380 480 0 1 {name=l52 lab=uio_oe_1}
C {devices/lab_pin.sym} 1380 500 0 1 {name=l53 lab=uio_oe_2}
C {devices/lab_pin.sym} 1380 520 0 1 {name=l54 lab=uio_oe_3}
C {devices/lab_pin.sym} 1380 540 0 1 {name=l55 lab=uio_oe_4}
C {devices/lab_pin.sym} 1380 560 0 1 {name=l56 lab=uio_oe_5}
C {devices/lab_pin.sym} 1380 580 0 1 {name=l57 lab=uio_oe_6}
C {devices/lab_pin.sym} 1380 600 0 1 {name=l58 lab=uio_oe_7}
C {devices/lab_pin.sym} 1380 620 0 1 {name=l59 lab=uio_out_0}
C {devices/lab_pin.sym} 1380 640 0 1 {name=l60 lab=uio_out_6}
C {devices/lab_pin.sym} 1380 660 0 1 {name=l61 lab=uio_out_7}
T {Tile pins (Tiny Tapeout template names; brackets written as _n)} 0 900 0 0 0.3 0.3 {}
C {devices/ipin.sym} 60 940 0 0 {name=p62 lab=clk}
C {devices/ipin.sym} 240 940 0 0 {name=p63 lab=ena}
C {devices/ipin.sym} 420 940 0 0 {name=p64 lab=rst_n}
C {devices/ipin.sym} 600 940 0 0 {name=p65 lab=ua_0}
C {devices/ipin.sym} 780 940 0 0 {name=p66 lab=ui_in_3}
C {devices/ipin.sym} 960 940 0 0 {name=p67 lab=ui_in_4}
C {devices/ipin.sym} 1140 940 0 0 {name=p68 lab=ui_in_6}
C {devices/ipin.sym} 1320 940 0 0 {name=p69 lab=uio_in_6}
C {devices/opin.sym} 60 1060 0 0 {name=p70 lab=uio_oe_0}
C {devices/opin.sym} 240 1060 0 0 {name=p71 lab=uio_oe_1}
C {devices/opin.sym} 420 1060 0 0 {name=p72 lab=uio_oe_2}
C {devices/opin.sym} 600 1060 0 0 {name=p73 lab=uio_oe_3}
C {devices/opin.sym} 780 1060 0 0 {name=p74 lab=uio_oe_4}
C {devices/opin.sym} 960 1060 0 0 {name=p75 lab=uio_oe_5}
C {devices/opin.sym} 1140 1060 0 0 {name=p76 lab=uio_oe_6}
C {devices/opin.sym} 1320 1060 0 0 {name=p77 lab=uio_oe_7}
C {devices/opin.sym} 60 1100 0 0 {name=p78 lab=uio_out_0}
C {devices/opin.sym} 240 1100 0 0 {name=p79 lab=uio_out_1}
C {devices/opin.sym} 420 1100 0 0 {name=p80 lab=uio_out_2}
C {devices/opin.sym} 600 1100 0 0 {name=p81 lab=uio_out_3}
C {devices/opin.sym} 780 1100 0 0 {name=p82 lab=uio_out_4}
C {devices/opin.sym} 960 1100 0 0 {name=p83 lab=uio_out_5}
C {devices/opin.sym} 1140 1100 0 0 {name=p84 lab=uio_out_6}
C {devices/opin.sym} 1320 1100 0 0 {name=p85 lab=uio_out_7}
C {devices/opin.sym} 60 1140 0 0 {name=p86 lab=uo_out_0}
C {devices/opin.sym} 240 1140 0 0 {name=p87 lab=uo_out_1}
C {devices/opin.sym} 420 1140 0 0 {name=p88 lab=uo_out_2}
C {devices/opin.sym} 600 1140 0 0 {name=p89 lab=uo_out_3}
C {devices/opin.sym} 780 1140 0 0 {name=p90 lab=uo_out_4}
C {devices/opin.sym} 960 1140 0 0 {name=p91 lab=uo_out_5}
C {devices/opin.sym} 1140 1140 0 0 {name=p92 lab=uo_out_6}
C {devices/opin.sym} 1320 1140 0 0 {name=p93 lab=uo_out_7}
