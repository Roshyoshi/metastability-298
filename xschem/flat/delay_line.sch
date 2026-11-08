v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {delay_line: isolation buffer + current-starved inverter + timing capacitor + three restorers} 0 -230 0 0 0.45 0.45 {}
T {iso0, iso1: buffer from capture_local. MP/MN: inverter on launch; MC (gate ua_0) starves the pull-down; MCT: gate capacitor on slow. XR0-XR2 restore a sharp edge.} 0 -190 0 0 0.26 0.26 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 620 0 0 {name=Miso0_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=Miso0_i_1 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 500 620 0 0 {name=Miso1_i_0_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 700 620 0 0 {name=Miso1_i_0_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 500 60 0 0 {name=Miso1_i_1_0 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 700 60 0 0 {name=Miso1_i_1_1 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1780 620 0 0 {name=MXR0_i_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1780 60 0 0 {name=MXR0_i_1 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2140 620 0 0 {name=MXR1_i_0_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2340 620 0 0 {name=MXR1_i_0_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2140 60 0 0 {name=MXR1_i_1_0 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2340 60 0 0 {name=MXR1_i_1_1 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2700 620 0 0 {name=MXR2_i_0_0 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2900 620 0 0 {name=MXR2_i_0_1 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2700 60 0 0 {name=MXR2_i_1_0 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2900 60 0 0 {name=MXR2_i_1_1 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1060 60 0 0 {name=MP L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1060 470 0 0 {name=MN L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1060 620 0 0 {name=MC L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1420 620 0 0 {name=MCT L=1u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_06v0 spiceprefix=X}
T {iso0} 110 -35 0 0 0.3 0.3 {}
T {iso1} 470 -35 0 0 0.3 0.3 {}
T {XR0} 1750 -35 0 0 0.3 0.3 {}
T {XR1} 2110 -35 0 0 0.3 0.3 {}
T {XR2} 2670 -35 0 0 0.3 0.3 {}
T {MP} 1030 -35 0 0 0.3 0.3 {}
T {MN} 1030 -35 0 0 0.3 0.3 {}
T {MC} 1030 -35 0 0 0.3 0.3 {}
T {MCT} 1390 -35 0 0 0.3 0.3 {}
N 160 650 160 670 {lab=0}
C {devices/gnd.sym} 160 670 0 0 {name=s1 lab=0}
N 160 620 190 620 {lab=0}
C {devices/gnd.sym} 190 620 0 0 {name=s2 lab=0}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s3 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s4 lab=VDD}
N 520 650 520 670 {lab=0}
C {devices/gnd.sym} 520 670 0 0 {name=s5 lab=0}
N 520 620 550 620 {lab=0}
C {devices/gnd.sym} 550 620 0 0 {name=s6 lab=0}
N 720 650 720 670 {lab=0}
C {devices/gnd.sym} 720 670 0 0 {name=s7 lab=0}
N 720 620 750 620 {lab=0}
C {devices/gnd.sym} 750 620 0 0 {name=s8 lab=0}
N 520 30 520 10 {lab=VDD}
C {devices/vdd.sym} 520 10 0 0 {name=s9 lab=VDD}
N 520 60 550 60 {lab=VDD}
C {devices/vdd.sym} 550 60 0 0 {name=s10 lab=VDD}
N 720 30 720 10 {lab=VDD}
C {devices/vdd.sym} 720 10 0 0 {name=s11 lab=VDD}
N 720 60 750 60 {lab=VDD}
C {devices/vdd.sym} 750 60 0 0 {name=s12 lab=VDD}
N 1800 650 1800 670 {lab=0}
C {devices/gnd.sym} 1800 670 0 0 {name=s13 lab=0}
N 1800 620 1830 620 {lab=0}
C {devices/gnd.sym} 1830 620 0 0 {name=s14 lab=0}
N 1800 30 1800 10 {lab=VDD}
C {devices/vdd.sym} 1800 10 0 0 {name=s15 lab=VDD}
N 1800 60 1830 60 {lab=VDD}
C {devices/vdd.sym} 1830 60 0 0 {name=s16 lab=VDD}
N 2160 650 2160 670 {lab=0}
C {devices/gnd.sym} 2160 670 0 0 {name=s17 lab=0}
N 2160 620 2190 620 {lab=0}
C {devices/gnd.sym} 2190 620 0 0 {name=s18 lab=0}
N 2360 650 2360 670 {lab=0}
C {devices/gnd.sym} 2360 670 0 0 {name=s19 lab=0}
N 2360 620 2390 620 {lab=0}
C {devices/gnd.sym} 2390 620 0 0 {name=s20 lab=0}
N 2160 30 2160 10 {lab=VDD}
C {devices/vdd.sym} 2160 10 0 0 {name=s21 lab=VDD}
N 2160 60 2190 60 {lab=VDD}
C {devices/vdd.sym} 2190 60 0 0 {name=s22 lab=VDD}
N 2360 30 2360 10 {lab=VDD}
C {devices/vdd.sym} 2360 10 0 0 {name=s23 lab=VDD}
N 2360 60 2390 60 {lab=VDD}
C {devices/vdd.sym} 2390 60 0 0 {name=s24 lab=VDD}
N 2720 650 2720 670 {lab=0}
C {devices/gnd.sym} 2720 670 0 0 {name=s25 lab=0}
N 2720 620 2750 620 {lab=0}
C {devices/gnd.sym} 2750 620 0 0 {name=s26 lab=0}
N 2920 650 2920 670 {lab=0}
C {devices/gnd.sym} 2920 670 0 0 {name=s27 lab=0}
N 2920 620 2950 620 {lab=0}
C {devices/gnd.sym} 2950 620 0 0 {name=s28 lab=0}
N 2720 30 2720 10 {lab=VDD}
C {devices/vdd.sym} 2720 10 0 0 {name=s29 lab=VDD}
N 2720 60 2750 60 {lab=VDD}
C {devices/vdd.sym} 2750 60 0 0 {name=s30 lab=VDD}
N 2920 30 2920 10 {lab=VDD}
C {devices/vdd.sym} 2920 10 0 0 {name=s31 lab=VDD}
N 2920 60 2950 60 {lab=VDD}
C {devices/vdd.sym} 2950 60 0 0 {name=s32 lab=VDD}
N 1080 30 1080 10 {lab=VDD}
C {devices/vdd.sym} 1080 10 0 0 {name=s33 lab=VDD}
N 1080 60 1110 60 {lab=VDD}
C {devices/vdd.sym} 1110 60 0 0 {name=s34 lab=VDD}
N 1080 470 1110 470 {lab=0}
C {devices/gnd.sym} 1110 470 0 0 {name=s35 lab=0}
N 1080 650 1080 670 {lab=0}
C {devices/gnd.sym} 1080 670 0 0 {name=s36 lab=0}
N 1080 620 1110 620 {lab=0}
C {devices/gnd.sym} 1110 620 0 0 {name=s37 lab=0}
N 1440 590 1440 570 {lab=0}
C {devices/gnd.sym} 1440 570 0 0 {name=s38 lab=0}
N 1440 650 1440 670 {lab=0}
C {devices/gnd.sym} 1440 670 0 0 {name=s39 lab=0}
N 1440 620 1470 620 {lab=0}
C {devices/gnd.sym} 1470 620 0 0 {name=s40 lab=0}
N 2160 590 2160 580 {lab=r1}
N 2160 580 2360 580 {lab=r1}
N 2160 580 2160 100 {lab=r1}
N 2360 580 2360 590 {lab=r1}
N 2360 590 2400 590 {lab=r1}
N 2160 100 2160 90 {lab=r1}
N 2160 100 2360 100 {lab=r1}
N 2400 590 2400 620 {lab=r1}
N 2400 620 2670 620 {lab=r1}
N 2670 620 2670 580 {lab=r1}
N 2670 620 2680 620 {lab=r1}
N 2360 100 2360 90 {lab=r1}
N 2360 90 2400 90 {lab=r1}
N 2670 580 2760 580 {lab=r1}
N 2760 580 2760 620 {lab=r1}
N 2760 620 2880 620 {lab=r1}
N 2400 90 2400 60 {lab=r1}
N 2400 60 2670 60 {lab=r1}
N 2670 60 2670 100 {lab=r1}
N 2670 60 2680 60 {lab=r1}
N 2670 100 2760 100 {lab=r1}
N 2760 100 2760 60 {lab=r1}
N 2760 60 2880 60 {lab=r1}
N 160 590 160 90 {lab=capture_iso_b}
N 160 590 200 590 {lab=capture_iso_b}
N 200 590 200 620 {lab=capture_iso_b}
N 200 620 470 620 {lab=capture_iso_b}
N 470 620 470 580 {lab=capture_iso_b}
N 470 620 480 620 {lab=capture_iso_b}
N 160 90 200 90 {lab=capture_iso_b}
N 470 580 560 580 {lab=capture_iso_b}
N 560 580 560 620 {lab=capture_iso_b}
N 560 620 680 620 {lab=capture_iso_b}
N 200 90 200 60 {lab=capture_iso_b}
N 200 60 470 60 {lab=capture_iso_b}
N 470 60 470 100 {lab=capture_iso_b}
N 470 60 480 60 {lab=capture_iso_b}
N 470 100 560 100 {lab=capture_iso_b}
N 560 100 560 60 {lab=capture_iso_b}
N 560 60 680 60 {lab=capture_iso_b}
N 520 590 520 570 {lab=launch}
N 520 570 720 570 {lab=launch}
N 520 570 520 110 {lab=launch}
N 720 570 720 470 {lab=launch}
N 720 570 720 590 {lab=launch}
N 520 110 720 110 {lab=launch}
N 520 110 520 90 {lab=launch}
N 720 470 1040 470 {lab=launch}
N 720 110 720 90 {lab=launch}
N 720 90 760 90 {lab=launch}
N 760 90 760 60 {lab=launch}
N 760 60 1040 60 {lab=launch}
N 1800 590 1840 590 {lab=r0}
N 1800 590 1800 90 {lab=r0}
N 1840 590 1840 620 {lab=r0}
N 1840 620 2110 620 {lab=r0}
N 2110 620 2110 680 {lab=r0}
N 2110 620 2120 620 {lab=r0}
N 1800 90 1840 90 {lab=r0}
N 2110 680 2200 680 {lab=r0}
N 2200 680 2200 620 {lab=r0}
N 2200 620 2320 620 {lab=r0}
N 1840 90 1840 60 {lab=r0}
N 1840 60 2110 60 {lab=r0}
N 2110 60 2120 60 {lab=r0}
N 2110 60 2110 0 {lab=r0}
N 2110 0 2200 0 {lab=r0}
N 2200 0 2200 60 {lab=r0}
N 2200 60 2320 60 {lab=r0}
N 1760 620 1750 620 {lab=slow}
N 1750 620 1750 60 {lab=slow}
N 1750 620 1750 680 {lab=slow}
N 1750 680 1390 680 {lab=slow}
N 1390 680 1390 620 {lab=slow}
N 1390 620 1400 620 {lab=slow}
N 1390 620 1390 440 {lab=slow}
N 1750 60 1760 60 {lab=slow}
N 1390 440 1080 440 {lab=slow}
N 1080 440 1080 90 {lab=slow}
N 2720 590 2720 570 {lab=early_clk}
N 2720 570 2720 400 {lab=early_clk}
N 2720 570 2920 570 {lab=early_clk}
N 2920 570 2920 590 {lab=early_clk}
N 2720 400 2720 110 {lab=early_clk}
N 2720 400 3300 400 {lab=early_clk}
N 2720 110 2920 110 {lab=early_clk}
N 2720 110 2720 90 {lab=early_clk}
N 2920 110 2920 90 {lab=early_clk}
N 120 620 110 620 {lab=capture_local}
N 110 620 110 380 {lab=capture_local}
N 110 380 -60 380 {lab=capture_local}
N 110 380 110 60 {lab=capture_local}
N 110 60 120 60 {lab=capture_local}
N 1040 620 1030 620 {lab=ua_0}
N 1030 620 1030 420 {lab=ua_0}
N 1030 420 -60 420 {lab=ua_0}
N 1080 500 1080 590 {lab=foot}
C {devices/ipin.sym} -60 380 0 0 {name=p41 lab=capture_local}
C {devices/ipin.sym} -60 420 0 0 {name=p42 lab=ua_0}
C {devices/opin.sym} 3300 400 0 0 {name=p43 lab=early_clk}
C {devices/lab_pin.sym} 1760 620 0 0 {name=l44 lab=slow}
C {devices/lab_pin.sym} 2120 620 0 0 {name=l45 lab=r0}
C {devices/lab_pin.sym} 2680 620 0 0 {name=l46 lab=r1}
C {devices/lab_pin.sym} 1040 60 0 0 {name=l47 lab=launch}
