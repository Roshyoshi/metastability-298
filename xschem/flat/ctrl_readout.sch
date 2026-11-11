v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {ctrl_readout: controller block "readout" at transistor level (8 cells)} 0 -230 0 0 0.45 0.45 {}
T {Readout: uo_out = k[7:0] when byte_sel (ui_in_0) is 0, k[15:8] when it is 1} 0 -190 0 0 0.26 0.26 {}
T {From src/gf180/compact_control.v; every cell opened up. Stage labels are the cell instance names.} 0 -162 0 0 0.26 0.26 {}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 7500 770 0 0 {name=Mbyte0_mux_MN2 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 500 770 0 0 {name=Mbyte0_mux_MN4 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 500 620 0 0 {name=Mbyte0_mux_MN8 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 700 620 0 0 {name=Mbyte0_mux_MN7 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 700 770 0 0 {name=Mbyte0_mux_MN3 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 140 770 0 0 {name=Mbyte0_mux_MN1 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 7500 60 0 0 {name=Mbyte0_mux_MP5 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 500 60 0 0 {name=Mbyte0_mux_MP4 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 500 210 0 0 {name=Mbyte0_mux_MP8 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 700 210 0 0 {name=Mbyte0_mux_MP7 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 700 60 0 0 {name=Mbyte0_mux_MP3 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 140 60 0 0 {name=Mbyte0_mux_MP1 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 7860 770 0 0 {name=Mbyte1_mux_MN2 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1420 770 0 0 {name=Mbyte1_mux_MN4 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1420 620 0 0 {name=Mbyte1_mux_MN8 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1620 620 0 0 {name=Mbyte1_mux_MN7 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1620 770 0 0 {name=Mbyte1_mux_MN3 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1060 770 0 0 {name=Mbyte1_mux_MN1 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 7860 60 0 0 {name=Mbyte1_mux_MP5 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1420 60 0 0 {name=Mbyte1_mux_MP4 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1420 210 0 0 {name=Mbyte1_mux_MP8 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1620 210 0 0 {name=Mbyte1_mux_MP7 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1620 60 0 0 {name=Mbyte1_mux_MP3 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1060 60 0 0 {name=Mbyte1_mux_MP1 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 8220 770 0 0 {name=Mbyte2_mux_MN2 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2340 770 0 0 {name=Mbyte2_mux_MN4 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2340 620 0 0 {name=Mbyte2_mux_MN8 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2540 620 0 0 {name=Mbyte2_mux_MN7 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2540 770 0 0 {name=Mbyte2_mux_MN3 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 1980 770 0 0 {name=Mbyte2_mux_MN1 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 8220 60 0 0 {name=Mbyte2_mux_MP5 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2340 60 0 0 {name=Mbyte2_mux_MP4 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2340 210 0 0 {name=Mbyte2_mux_MP8 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2540 210 0 0 {name=Mbyte2_mux_MP7 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2540 60 0 0 {name=Mbyte2_mux_MP3 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 1980 60 0 0 {name=Mbyte2_mux_MP1 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 8580 770 0 0 {name=Mbyte3_mux_MN2 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3260 770 0 0 {name=Mbyte3_mux_MN4 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3260 620 0 0 {name=Mbyte3_mux_MN8 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3460 620 0 0 {name=Mbyte3_mux_MN7 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3460 770 0 0 {name=Mbyte3_mux_MN3 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 2900 770 0 0 {name=Mbyte3_mux_MN1 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 8580 60 0 0 {name=Mbyte3_mux_MP5 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3260 60 0 0 {name=Mbyte3_mux_MP4 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3260 210 0 0 {name=Mbyte3_mux_MP8 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3460 210 0 0 {name=Mbyte3_mux_MP7 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3460 60 0 0 {name=Mbyte3_mux_MP3 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 2900 60 0 0 {name=Mbyte3_mux_MP1 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 8940 770 0 0 {name=Mbyte4_mux_MN2 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4180 770 0 0 {name=Mbyte4_mux_MN4 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4180 620 0 0 {name=Mbyte4_mux_MN8 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4380 620 0 0 {name=Mbyte4_mux_MN7 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4380 770 0 0 {name=Mbyte4_mux_MN3 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 3820 770 0 0 {name=Mbyte4_mux_MN1 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 8940 60 0 0 {name=Mbyte4_mux_MP5 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4180 60 0 0 {name=Mbyte4_mux_MP4 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4180 210 0 0 {name=Mbyte4_mux_MP8 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4380 210 0 0 {name=Mbyte4_mux_MP7 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4380 60 0 0 {name=Mbyte4_mux_MP3 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 3820 60 0 0 {name=Mbyte4_mux_MP1 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 9300 770 0 0 {name=Mbyte5_mux_MN2 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5100 770 0 0 {name=Mbyte5_mux_MN4 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5100 620 0 0 {name=Mbyte5_mux_MN8 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5300 620 0 0 {name=Mbyte5_mux_MN7 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5300 770 0 0 {name=Mbyte5_mux_MN3 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 4740 770 0 0 {name=Mbyte5_mux_MN1 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 9300 60 0 0 {name=Mbyte5_mux_MP5 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5100 60 0 0 {name=Mbyte5_mux_MP4 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5100 210 0 0 {name=Mbyte5_mux_MP8 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5300 210 0 0 {name=Mbyte5_mux_MP7 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5300 60 0 0 {name=Mbyte5_mux_MP3 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 4740 60 0 0 {name=Mbyte5_mux_MP1 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 9660 770 0 0 {name=Mbyte6_mux_MN2 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6020 770 0 0 {name=Mbyte6_mux_MN4 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6020 620 0 0 {name=Mbyte6_mux_MN8 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6220 620 0 0 {name=Mbyte6_mux_MN7 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6220 770 0 0 {name=Mbyte6_mux_MN3 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 5660 770 0 0 {name=Mbyte6_mux_MN1 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 9660 60 0 0 {name=Mbyte6_mux_MP5 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6020 60 0 0 {name=Mbyte6_mux_MP4 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6020 210 0 0 {name=Mbyte6_mux_MP8 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6220 210 0 0 {name=Mbyte6_mux_MP7 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6220 60 0 0 {name=Mbyte6_mux_MP3 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 5660 60 0 0 {name=Mbyte6_mux_MP1 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 10020 770 0 0 {name=Mbyte7_mux_MN2 L=0.6u W=0.82u nf=1 m=1 ad=4.1e-13 as=4.1e-13 pd=2.64e-06 ps=2.64e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6940 770 0 0 {name=Mbyte7_mux_MN4 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6940 620 0 0 {name=Mbyte7_mux_MN8 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 7140 620 0 0 {name=Mbyte7_mux_MN7 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 7140 770 0 0 {name=Mbyte7_mux_MN3 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/nfet_06v0.sym} 6580 770 0 0 {name=Mbyte7_mux_MN1 L=0.6u W=0.36u nf=1 m=1 ad=1.8e-13 as=1.8e-13 pd=1.72e-06 ps=1.72e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=nfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 10020 60 0 0 {name=Mbyte7_mux_MP5 L=0.5u W=1.22u nf=1 m=1 ad=6.1e-13 as=6.1e-13 pd=3.44e-06 ps=3.44e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6940 60 0 0 {name=Mbyte7_mux_MP4 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6940 210 0 0 {name=Mbyte7_mux_MP8 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 7140 210 0 0 {name=Mbyte7_mux_MP7 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 7140 60 0 0 {name=Mbyte7_mux_MP3 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
C {/usr/local/share/pdk/gf180mcuD/libs.tech/xschem/symbols/pfet_06v0.sym} 6580 60 0 0 {name=Mbyte7_mux_MP1 L=0.5u W=0.615u nf=1 m=1 ad=3.075e-13 as=3.075e-13 pd=2.23e-06 ps=2.23e-06 nrd=0 nrs=0 sa=0 sb=0 sd=0 model=pfet_05v0 spiceprefix=X}
T {byte0_mux} 110 -35 0 0 0.3 0.3 {}
T {byte1_mux} 1030 -35 0 0 0.3 0.3 {}
T {byte2_mux} 1950 -35 0 0 0.3 0.3 {}
T {byte3_mux} 2870 -35 0 0 0.3 0.3 {}
T {byte4_mux} 3790 -35 0 0 0.3 0.3 {}
T {byte5_mux} 4710 -35 0 0 0.3 0.3 {}
T {byte6_mux} 5630 -35 0 0 0.3 0.3 {}
T {byte7_mux} 6550 -35 0 0 0.3 0.3 {}
N 7520 800 7520 820 {lab=0}
C {devices/gnd.sym} 7520 820 0 0 {name=s1 lab=0}
N 7520 770 7550 770 {lab=0}
C {devices/gnd.sym} 7550 770 0 0 {name=s2 lab=0}
N 520 800 520 820 {lab=0}
C {devices/gnd.sym} 520 820 0 0 {name=s3 lab=0}
N 520 770 550 770 {lab=0}
C {devices/gnd.sym} 550 770 0 0 {name=s4 lab=0}
N 520 620 550 620 {lab=0}
C {devices/gnd.sym} 550 620 0 0 {name=s5 lab=0}
N 720 620 750 620 {lab=0}
C {devices/gnd.sym} 750 620 0 0 {name=s6 lab=0}
N 720 800 720 820 {lab=0}
C {devices/gnd.sym} 720 820 0 0 {name=s7 lab=0}
N 720 770 750 770 {lab=0}
C {devices/gnd.sym} 750 770 0 0 {name=s8 lab=0}
N 160 800 160 820 {lab=0}
C {devices/gnd.sym} 160 820 0 0 {name=s9 lab=0}
N 160 770 190 770 {lab=0}
C {devices/gnd.sym} 190 770 0 0 {name=s10 lab=0}
N 7520 30 7520 10 {lab=VDD}
C {devices/vdd.sym} 7520 10 0 0 {name=s11 lab=VDD}
N 7520 60 7550 60 {lab=VDD}
C {devices/vdd.sym} 7550 60 0 0 {name=s12 lab=VDD}
N 520 30 520 10 {lab=VDD}
C {devices/vdd.sym} 520 10 0 0 {name=s13 lab=VDD}
N 520 60 550 60 {lab=VDD}
C {devices/vdd.sym} 550 60 0 0 {name=s14 lab=VDD}
N 520 210 550 210 {lab=VDD}
C {devices/vdd.sym} 550 210 0 0 {name=s15 lab=VDD}
N 720 210 750 210 {lab=VDD}
C {devices/vdd.sym} 750 210 0 0 {name=s16 lab=VDD}
N 720 30 720 10 {lab=VDD}
C {devices/vdd.sym} 720 10 0 0 {name=s17 lab=VDD}
N 720 60 750 60 {lab=VDD}
C {devices/vdd.sym} 750 60 0 0 {name=s18 lab=VDD}
N 160 30 160 10 {lab=VDD}
C {devices/vdd.sym} 160 10 0 0 {name=s19 lab=VDD}
N 160 60 190 60 {lab=VDD}
C {devices/vdd.sym} 190 60 0 0 {name=s20 lab=VDD}
N 7880 800 7880 820 {lab=0}
C {devices/gnd.sym} 7880 820 0 0 {name=s21 lab=0}
N 7880 770 7910 770 {lab=0}
C {devices/gnd.sym} 7910 770 0 0 {name=s22 lab=0}
N 1440 800 1440 820 {lab=0}
C {devices/gnd.sym} 1440 820 0 0 {name=s23 lab=0}
N 1440 770 1470 770 {lab=0}
C {devices/gnd.sym} 1470 770 0 0 {name=s24 lab=0}
N 1440 620 1470 620 {lab=0}
C {devices/gnd.sym} 1470 620 0 0 {name=s25 lab=0}
N 1640 620 1670 620 {lab=0}
C {devices/gnd.sym} 1670 620 0 0 {name=s26 lab=0}
N 1640 800 1640 820 {lab=0}
C {devices/gnd.sym} 1640 820 0 0 {name=s27 lab=0}
N 1640 770 1670 770 {lab=0}
C {devices/gnd.sym} 1670 770 0 0 {name=s28 lab=0}
N 1080 800 1080 820 {lab=0}
C {devices/gnd.sym} 1080 820 0 0 {name=s29 lab=0}
N 1080 770 1110 770 {lab=0}
C {devices/gnd.sym} 1110 770 0 0 {name=s30 lab=0}
N 7880 30 7880 10 {lab=VDD}
C {devices/vdd.sym} 7880 10 0 0 {name=s31 lab=VDD}
N 7880 60 7910 60 {lab=VDD}
C {devices/vdd.sym} 7910 60 0 0 {name=s32 lab=VDD}
N 1440 30 1440 10 {lab=VDD}
C {devices/vdd.sym} 1440 10 0 0 {name=s33 lab=VDD}
N 1440 60 1470 60 {lab=VDD}
C {devices/vdd.sym} 1470 60 0 0 {name=s34 lab=VDD}
N 1440 210 1470 210 {lab=VDD}
C {devices/vdd.sym} 1470 210 0 0 {name=s35 lab=VDD}
N 1640 210 1670 210 {lab=VDD}
C {devices/vdd.sym} 1670 210 0 0 {name=s36 lab=VDD}
N 1640 30 1640 10 {lab=VDD}
C {devices/vdd.sym} 1640 10 0 0 {name=s37 lab=VDD}
N 1640 60 1670 60 {lab=VDD}
C {devices/vdd.sym} 1670 60 0 0 {name=s38 lab=VDD}
N 1080 30 1080 10 {lab=VDD}
C {devices/vdd.sym} 1080 10 0 0 {name=s39 lab=VDD}
N 1080 60 1110 60 {lab=VDD}
C {devices/vdd.sym} 1110 60 0 0 {name=s40 lab=VDD}
N 8240 800 8240 820 {lab=0}
C {devices/gnd.sym} 8240 820 0 0 {name=s41 lab=0}
N 8240 770 8270 770 {lab=0}
C {devices/gnd.sym} 8270 770 0 0 {name=s42 lab=0}
N 2360 800 2360 820 {lab=0}
C {devices/gnd.sym} 2360 820 0 0 {name=s43 lab=0}
N 2360 770 2390 770 {lab=0}
C {devices/gnd.sym} 2390 770 0 0 {name=s44 lab=0}
N 2360 620 2390 620 {lab=0}
C {devices/gnd.sym} 2390 620 0 0 {name=s45 lab=0}
N 2560 620 2590 620 {lab=0}
C {devices/gnd.sym} 2590 620 0 0 {name=s46 lab=0}
N 2560 800 2560 820 {lab=0}
C {devices/gnd.sym} 2560 820 0 0 {name=s47 lab=0}
N 2560 770 2590 770 {lab=0}
C {devices/gnd.sym} 2590 770 0 0 {name=s48 lab=0}
N 2000 800 2000 820 {lab=0}
C {devices/gnd.sym} 2000 820 0 0 {name=s49 lab=0}
N 2000 770 2030 770 {lab=0}
C {devices/gnd.sym} 2030 770 0 0 {name=s50 lab=0}
N 8240 30 8240 10 {lab=VDD}
C {devices/vdd.sym} 8240 10 0 0 {name=s51 lab=VDD}
N 8240 60 8270 60 {lab=VDD}
C {devices/vdd.sym} 8270 60 0 0 {name=s52 lab=VDD}
N 2360 30 2360 10 {lab=VDD}
C {devices/vdd.sym} 2360 10 0 0 {name=s53 lab=VDD}
N 2360 60 2390 60 {lab=VDD}
C {devices/vdd.sym} 2390 60 0 0 {name=s54 lab=VDD}
N 2360 210 2390 210 {lab=VDD}
C {devices/vdd.sym} 2390 210 0 0 {name=s55 lab=VDD}
N 2560 210 2590 210 {lab=VDD}
C {devices/vdd.sym} 2590 210 0 0 {name=s56 lab=VDD}
N 2560 30 2560 10 {lab=VDD}
C {devices/vdd.sym} 2560 10 0 0 {name=s57 lab=VDD}
N 2560 60 2590 60 {lab=VDD}
C {devices/vdd.sym} 2590 60 0 0 {name=s58 lab=VDD}
N 2000 30 2000 10 {lab=VDD}
C {devices/vdd.sym} 2000 10 0 0 {name=s59 lab=VDD}
N 2000 60 2030 60 {lab=VDD}
C {devices/vdd.sym} 2030 60 0 0 {name=s60 lab=VDD}
N 8600 800 8600 820 {lab=0}
C {devices/gnd.sym} 8600 820 0 0 {name=s61 lab=0}
N 8600 770 8630 770 {lab=0}
C {devices/gnd.sym} 8630 770 0 0 {name=s62 lab=0}
N 3280 800 3280 820 {lab=0}
C {devices/gnd.sym} 3280 820 0 0 {name=s63 lab=0}
N 3280 770 3310 770 {lab=0}
C {devices/gnd.sym} 3310 770 0 0 {name=s64 lab=0}
N 3280 620 3310 620 {lab=0}
C {devices/gnd.sym} 3310 620 0 0 {name=s65 lab=0}
N 3480 620 3510 620 {lab=0}
C {devices/gnd.sym} 3510 620 0 0 {name=s66 lab=0}
N 3480 800 3480 820 {lab=0}
C {devices/gnd.sym} 3480 820 0 0 {name=s67 lab=0}
N 3480 770 3510 770 {lab=0}
C {devices/gnd.sym} 3510 770 0 0 {name=s68 lab=0}
N 2920 800 2920 820 {lab=0}
C {devices/gnd.sym} 2920 820 0 0 {name=s69 lab=0}
N 2920 770 2950 770 {lab=0}
C {devices/gnd.sym} 2950 770 0 0 {name=s70 lab=0}
N 8600 30 8600 10 {lab=VDD}
C {devices/vdd.sym} 8600 10 0 0 {name=s71 lab=VDD}
N 8600 60 8630 60 {lab=VDD}
C {devices/vdd.sym} 8630 60 0 0 {name=s72 lab=VDD}
N 3280 30 3280 10 {lab=VDD}
C {devices/vdd.sym} 3280 10 0 0 {name=s73 lab=VDD}
N 3280 60 3310 60 {lab=VDD}
C {devices/vdd.sym} 3310 60 0 0 {name=s74 lab=VDD}
N 3280 210 3310 210 {lab=VDD}
C {devices/vdd.sym} 3310 210 0 0 {name=s75 lab=VDD}
N 3480 210 3510 210 {lab=VDD}
C {devices/vdd.sym} 3510 210 0 0 {name=s76 lab=VDD}
N 3480 30 3480 10 {lab=VDD}
C {devices/vdd.sym} 3480 10 0 0 {name=s77 lab=VDD}
N 3480 60 3510 60 {lab=VDD}
C {devices/vdd.sym} 3510 60 0 0 {name=s78 lab=VDD}
N 2920 30 2920 10 {lab=VDD}
C {devices/vdd.sym} 2920 10 0 0 {name=s79 lab=VDD}
N 2920 60 2950 60 {lab=VDD}
C {devices/vdd.sym} 2950 60 0 0 {name=s80 lab=VDD}
N 8960 800 8960 820 {lab=0}
C {devices/gnd.sym} 8960 820 0 0 {name=s81 lab=0}
N 8960 770 8990 770 {lab=0}
C {devices/gnd.sym} 8990 770 0 0 {name=s82 lab=0}
N 4200 800 4200 820 {lab=0}
C {devices/gnd.sym} 4200 820 0 0 {name=s83 lab=0}
N 4200 770 4230 770 {lab=0}
C {devices/gnd.sym} 4230 770 0 0 {name=s84 lab=0}
N 4200 620 4230 620 {lab=0}
C {devices/gnd.sym} 4230 620 0 0 {name=s85 lab=0}
N 4400 620 4430 620 {lab=0}
C {devices/gnd.sym} 4430 620 0 0 {name=s86 lab=0}
N 4400 800 4400 820 {lab=0}
C {devices/gnd.sym} 4400 820 0 0 {name=s87 lab=0}
N 4400 770 4430 770 {lab=0}
C {devices/gnd.sym} 4430 770 0 0 {name=s88 lab=0}
N 3840 800 3840 820 {lab=0}
C {devices/gnd.sym} 3840 820 0 0 {name=s89 lab=0}
N 3840 770 3870 770 {lab=0}
C {devices/gnd.sym} 3870 770 0 0 {name=s90 lab=0}
N 8960 30 8960 10 {lab=VDD}
C {devices/vdd.sym} 8960 10 0 0 {name=s91 lab=VDD}
N 8960 60 8990 60 {lab=VDD}
C {devices/vdd.sym} 8990 60 0 0 {name=s92 lab=VDD}
N 4200 30 4200 10 {lab=VDD}
C {devices/vdd.sym} 4200 10 0 0 {name=s93 lab=VDD}
N 4200 60 4230 60 {lab=VDD}
C {devices/vdd.sym} 4230 60 0 0 {name=s94 lab=VDD}
N 4200 210 4230 210 {lab=VDD}
C {devices/vdd.sym} 4230 210 0 0 {name=s95 lab=VDD}
N 4400 210 4430 210 {lab=VDD}
C {devices/vdd.sym} 4430 210 0 0 {name=s96 lab=VDD}
N 4400 30 4400 10 {lab=VDD}
C {devices/vdd.sym} 4400 10 0 0 {name=s97 lab=VDD}
N 4400 60 4430 60 {lab=VDD}
C {devices/vdd.sym} 4430 60 0 0 {name=s98 lab=VDD}
N 3840 30 3840 10 {lab=VDD}
C {devices/vdd.sym} 3840 10 0 0 {name=s99 lab=VDD}
N 3840 60 3870 60 {lab=VDD}
C {devices/vdd.sym} 3870 60 0 0 {name=s100 lab=VDD}
N 9320 800 9320 820 {lab=0}
C {devices/gnd.sym} 9320 820 0 0 {name=s101 lab=0}
N 9320 770 9350 770 {lab=0}
C {devices/gnd.sym} 9350 770 0 0 {name=s102 lab=0}
N 5120 800 5120 820 {lab=0}
C {devices/gnd.sym} 5120 820 0 0 {name=s103 lab=0}
N 5120 770 5150 770 {lab=0}
C {devices/gnd.sym} 5150 770 0 0 {name=s104 lab=0}
N 5120 620 5150 620 {lab=0}
C {devices/gnd.sym} 5150 620 0 0 {name=s105 lab=0}
N 5320 620 5350 620 {lab=0}
C {devices/gnd.sym} 5350 620 0 0 {name=s106 lab=0}
N 5320 800 5320 820 {lab=0}
C {devices/gnd.sym} 5320 820 0 0 {name=s107 lab=0}
N 5320 770 5350 770 {lab=0}
C {devices/gnd.sym} 5350 770 0 0 {name=s108 lab=0}
N 4760 800 4760 820 {lab=0}
C {devices/gnd.sym} 4760 820 0 0 {name=s109 lab=0}
N 4760 770 4790 770 {lab=0}
C {devices/gnd.sym} 4790 770 0 0 {name=s110 lab=0}
N 9320 30 9320 10 {lab=VDD}
C {devices/vdd.sym} 9320 10 0 0 {name=s111 lab=VDD}
N 9320 60 9350 60 {lab=VDD}
C {devices/vdd.sym} 9350 60 0 0 {name=s112 lab=VDD}
N 5120 30 5120 10 {lab=VDD}
C {devices/vdd.sym} 5120 10 0 0 {name=s113 lab=VDD}
N 5120 60 5150 60 {lab=VDD}
C {devices/vdd.sym} 5150 60 0 0 {name=s114 lab=VDD}
N 5120 210 5150 210 {lab=VDD}
C {devices/vdd.sym} 5150 210 0 0 {name=s115 lab=VDD}
N 5320 210 5350 210 {lab=VDD}
C {devices/vdd.sym} 5350 210 0 0 {name=s116 lab=VDD}
N 5320 30 5320 10 {lab=VDD}
C {devices/vdd.sym} 5320 10 0 0 {name=s117 lab=VDD}
N 5320 60 5350 60 {lab=VDD}
C {devices/vdd.sym} 5350 60 0 0 {name=s118 lab=VDD}
N 4760 30 4760 10 {lab=VDD}
C {devices/vdd.sym} 4760 10 0 0 {name=s119 lab=VDD}
N 4760 60 4790 60 {lab=VDD}
C {devices/vdd.sym} 4790 60 0 0 {name=s120 lab=VDD}
N 9680 800 9680 820 {lab=0}
C {devices/gnd.sym} 9680 820 0 0 {name=s121 lab=0}
N 9680 770 9710 770 {lab=0}
C {devices/gnd.sym} 9710 770 0 0 {name=s122 lab=0}
N 6040 800 6040 820 {lab=0}
C {devices/gnd.sym} 6040 820 0 0 {name=s123 lab=0}
N 6040 770 6070 770 {lab=0}
C {devices/gnd.sym} 6070 770 0 0 {name=s124 lab=0}
N 6040 620 6070 620 {lab=0}
C {devices/gnd.sym} 6070 620 0 0 {name=s125 lab=0}
N 6240 620 6270 620 {lab=0}
C {devices/gnd.sym} 6270 620 0 0 {name=s126 lab=0}
N 6240 800 6240 820 {lab=0}
C {devices/gnd.sym} 6240 820 0 0 {name=s127 lab=0}
N 6240 770 6270 770 {lab=0}
C {devices/gnd.sym} 6270 770 0 0 {name=s128 lab=0}
N 5680 800 5680 820 {lab=0}
C {devices/gnd.sym} 5680 820 0 0 {name=s129 lab=0}
N 5680 770 5710 770 {lab=0}
C {devices/gnd.sym} 5710 770 0 0 {name=s130 lab=0}
N 9680 30 9680 10 {lab=VDD}
C {devices/vdd.sym} 9680 10 0 0 {name=s131 lab=VDD}
N 9680 60 9710 60 {lab=VDD}
C {devices/vdd.sym} 9710 60 0 0 {name=s132 lab=VDD}
N 6040 30 6040 10 {lab=VDD}
C {devices/vdd.sym} 6040 10 0 0 {name=s133 lab=VDD}
N 6040 60 6070 60 {lab=VDD}
C {devices/vdd.sym} 6070 60 0 0 {name=s134 lab=VDD}
N 6040 210 6070 210 {lab=VDD}
C {devices/vdd.sym} 6070 210 0 0 {name=s135 lab=VDD}
N 6240 210 6270 210 {lab=VDD}
C {devices/vdd.sym} 6270 210 0 0 {name=s136 lab=VDD}
N 6240 30 6240 10 {lab=VDD}
C {devices/vdd.sym} 6240 10 0 0 {name=s137 lab=VDD}
N 6240 60 6270 60 {lab=VDD}
C {devices/vdd.sym} 6270 60 0 0 {name=s138 lab=VDD}
N 5680 30 5680 10 {lab=VDD}
C {devices/vdd.sym} 5680 10 0 0 {name=s139 lab=VDD}
N 5680 60 5710 60 {lab=VDD}
C {devices/vdd.sym} 5710 60 0 0 {name=s140 lab=VDD}
N 10040 800 10040 820 {lab=0}
C {devices/gnd.sym} 10040 820 0 0 {name=s141 lab=0}
N 10040 770 10070 770 {lab=0}
C {devices/gnd.sym} 10070 770 0 0 {name=s142 lab=0}
N 6960 800 6960 820 {lab=0}
C {devices/gnd.sym} 6960 820 0 0 {name=s143 lab=0}
N 6960 770 6990 770 {lab=0}
C {devices/gnd.sym} 6990 770 0 0 {name=s144 lab=0}
N 6960 620 6990 620 {lab=0}
C {devices/gnd.sym} 6990 620 0 0 {name=s145 lab=0}
N 7160 620 7190 620 {lab=0}
C {devices/gnd.sym} 7190 620 0 0 {name=s146 lab=0}
N 7160 800 7160 820 {lab=0}
C {devices/gnd.sym} 7160 820 0 0 {name=s147 lab=0}
N 7160 770 7190 770 {lab=0}
C {devices/gnd.sym} 7190 770 0 0 {name=s148 lab=0}
N 6600 800 6600 820 {lab=0}
C {devices/gnd.sym} 6600 820 0 0 {name=s149 lab=0}
N 6600 770 6630 770 {lab=0}
C {devices/gnd.sym} 6630 770 0 0 {name=s150 lab=0}
N 10040 30 10040 10 {lab=VDD}
C {devices/vdd.sym} 10040 10 0 0 {name=s151 lab=VDD}
N 10040 60 10070 60 {lab=VDD}
C {devices/vdd.sym} 10070 60 0 0 {name=s152 lab=VDD}
N 6960 30 6960 10 {lab=VDD}
C {devices/vdd.sym} 6960 10 0 0 {name=s153 lab=VDD}
N 6960 60 6990 60 {lab=VDD}
C {devices/vdd.sym} 6990 60 0 0 {name=s154 lab=VDD}
N 6960 210 6990 210 {lab=VDD}
C {devices/vdd.sym} 6990 210 0 0 {name=s155 lab=VDD}
N 7160 210 7190 210 {lab=VDD}
C {devices/vdd.sym} 7190 210 0 0 {name=s156 lab=VDD}
N 7160 30 7160 10 {lab=VDD}
C {devices/vdd.sym} 7160 10 0 0 {name=s157 lab=VDD}
N 7160 60 7190 60 {lab=VDD}
C {devices/vdd.sym} 7190 60 0 0 {name=s158 lab=VDD}
N 6600 30 6600 10 {lab=VDD}
C {devices/vdd.sym} 6600 10 0 0 {name=s159 lab=VDD}
N 6600 60 6630 60 {lab=VDD}
C {devices/vdd.sym} 6630 60 0 0 {name=s160 lab=VDD}
N 480 620 470 620 {lab=ui_in_0}
N 470 620 470 580 {lab=ui_in_0}
N 470 620 110 620 {lab=ui_in_0}
N 110 620 110 770 {lab=ui_in_0}
N 110 620 110 60 {lab=ui_in_0}
N 110 770 110 790 {lab=ui_in_0}
N 110 770 120 770 {lab=ui_in_0}
N 470 580 560 580 {lab=ui_in_0}
N 560 580 760 580 {lab=ui_in_0}
N 560 580 560 210 {lab=ui_in_0}
N 560 210 680 210 {lab=ui_in_0}
N 760 580 760 770 {lab=ui_in_0}
N 760 770 1030 770 {lab=ui_in_0}
N 1030 770 1030 620 {lab=ui_in_0}
N 1030 770 1040 770 {lab=ui_in_0}
N 110 790 -60 790 {lab=ui_in_0}
N 110 60 120 60 {lab=ui_in_0}
N 1030 620 1390 620 {lab=ui_in_0}
N 1030 620 1030 250 {lab=ui_in_0}
N 1390 620 1390 660 {lab=ui_in_0}
N 1390 620 1400 620 {lab=ui_in_0}
N 1030 250 1030 60 {lab=ui_in_0}
N 1030 250 1480 250 {lab=ui_in_0}
N 1030 60 1040 60 {lab=ui_in_0}
N 1480 250 1480 210 {lab=ui_in_0}
N 1480 210 1600 210 {lab=ui_in_0}
N 1390 660 1680 660 {lab=ui_in_0}
N 1680 660 1680 770 {lab=ui_in_0}
N 1680 770 1950 770 {lab=ui_in_0}
N 1950 770 1950 620 {lab=ui_in_0}
N 1950 770 1960 770 {lab=ui_in_0}
N 1950 620 2310 620 {lab=ui_in_0}
N 1950 620 1950 250 {lab=ui_in_0}
N 2310 620 2320 620 {lab=ui_in_0}
N 2310 620 2310 660 {lab=ui_in_0}
N 1950 250 2400 250 {lab=ui_in_0}
N 1950 250 1950 60 {lab=ui_in_0}
N 1950 60 1960 60 {lab=ui_in_0}
N 2400 250 2400 210 {lab=ui_in_0}
N 2400 210 2520 210 {lab=ui_in_0}
N 2310 660 2600 660 {lab=ui_in_0}
N 2600 660 2600 770 {lab=ui_in_0}
N 2600 770 2870 770 {lab=ui_in_0}
N 2870 770 2870 620 {lab=ui_in_0}
N 2870 770 2880 770 {lab=ui_in_0}
N 2870 620 2870 250 {lab=ui_in_0}
N 2870 620 3230 620 {lab=ui_in_0}
N 3230 620 3240 620 {lab=ui_in_0}
N 3230 620 3230 660 {lab=ui_in_0}
N 2870 250 3320 250 {lab=ui_in_0}
N 2870 250 2870 60 {lab=ui_in_0}
N 2870 60 2880 60 {lab=ui_in_0}
N 3320 250 3320 210 {lab=ui_in_0}
N 3320 210 3440 210 {lab=ui_in_0}
N 3230 660 3520 660 {lab=ui_in_0}
N 3520 660 3520 770 {lab=ui_in_0}
N 3520 770 3790 770 {lab=ui_in_0}
N 3790 770 3800 770 {lab=ui_in_0}
N 3790 770 3790 620 {lab=ui_in_0}
N 3790 620 3790 250 {lab=ui_in_0}
N 3790 620 4150 620 {lab=ui_in_0}
N 4150 620 4160 620 {lab=ui_in_0}
N 4150 620 4150 660 {lab=ui_in_0}
N 3790 250 4240 250 {lab=ui_in_0}
N 3790 250 3790 60 {lab=ui_in_0}
N 3790 60 3800 60 {lab=ui_in_0}
N 4240 250 4240 210 {lab=ui_in_0}
N 4240 210 4360 210 {lab=ui_in_0}
N 4150 660 4440 660 {lab=ui_in_0}
N 4440 660 4440 770 {lab=ui_in_0}
N 4440 770 4710 770 {lab=ui_in_0}
N 4710 770 4720 770 {lab=ui_in_0}
N 4710 770 4710 620 {lab=ui_in_0}
N 4710 620 4710 250 {lab=ui_in_0}
N 4710 620 5070 620 {lab=ui_in_0}
N 5070 620 5070 660 {lab=ui_in_0}
N 5070 620 5080 620 {lab=ui_in_0}
N 4710 250 5160 250 {lab=ui_in_0}
N 4710 250 4710 60 {lab=ui_in_0}
N 4710 60 4720 60 {lab=ui_in_0}
N 5160 250 5160 210 {lab=ui_in_0}
N 5160 210 5280 210 {lab=ui_in_0}
N 5070 660 5360 660 {lab=ui_in_0}
N 5360 660 5360 770 {lab=ui_in_0}
N 5360 770 5630 770 {lab=ui_in_0}
N 5630 770 5640 770 {lab=ui_in_0}
N 5630 770 5630 620 {lab=ui_in_0}
N 5630 620 5630 250 {lab=ui_in_0}
N 5630 620 5990 620 {lab=ui_in_0}
N 5990 620 5990 660 {lab=ui_in_0}
N 5990 620 6000 620 {lab=ui_in_0}
N 5630 250 6080 250 {lab=ui_in_0}
N 5630 250 5630 60 {lab=ui_in_0}
N 5630 60 5640 60 {lab=ui_in_0}
N 6080 250 6080 210 {lab=ui_in_0}
N 6080 210 6200 210 {lab=ui_in_0}
N 5990 660 6280 660 {lab=ui_in_0}
N 6280 660 6280 770 {lab=ui_in_0}
N 6280 770 6550 770 {lab=ui_in_0}
N 6550 770 6560 770 {lab=ui_in_0}
N 6550 770 6550 620 {lab=ui_in_0}
N 6550 620 6920 620 {lab=ui_in_0}
N 6550 620 6550 250 {lab=ui_in_0}
N 6550 250 6550 60 {lab=ui_in_0}
N 6550 250 7000 250 {lab=ui_in_0}
N 6550 60 6560 60 {lab=ui_in_0}
N 7000 250 7000 210 {lab=ui_in_0}
N 7000 210 7120 210 {lab=ui_in_0}
N 7480 770 7470 770 {lab=byte0_mux.int04}
N 7470 770 7470 560 {lab=byte0_mux.int04}
N 7470 560 720 560 {lab=byte0_mux.int04}
N 7470 560 7470 60 {lab=byte0_mux.int04}
N 7470 60 7480 60 {lab=byte0_mux.int04}
N 720 560 720 250 {lab=byte0_mux.int04}
N 720 560 720 590 {lab=byte0_mux.int04}
N 720 560 520 560 {lab=byte0_mux.int04}
N 520 560 520 590 {lab=byte0_mux.int04}
N 720 250 520 250 {lab=byte0_mux.int04}
N 720 250 720 240 {lab=byte0_mux.int04}
N 520 250 520 240 {lab=byte0_mux.int04}
N 7840 770 7830 770 {lab=byte1_mux.int04}
N 7830 770 7830 580 {lab=byte1_mux.int04}
N 7830 580 1640 580 {lab=byte1_mux.int04}
N 7830 580 7830 60 {lab=byte1_mux.int04}
N 7830 60 7840 60 {lab=byte1_mux.int04}
N 1640 580 1440 580 {lab=byte1_mux.int04}
N 1640 580 1640 270 {lab=byte1_mux.int04}
N 1640 580 1640 590 {lab=byte1_mux.int04}
N 1440 580 1440 590 {lab=byte1_mux.int04}
N 1640 270 1640 240 {lab=byte1_mux.int04}
N 1640 270 1440 270 {lab=byte1_mux.int04}
N 1440 270 1440 240 {lab=byte1_mux.int04}
N 8200 770 8190 770 {lab=byte2_mux.int04}
N 8190 770 8190 540 {lab=byte2_mux.int04}
N 8190 540 8190 60 {lab=byte2_mux.int04}
N 8190 540 2560 540 {lab=byte2_mux.int04}
N 8190 60 8200 60 {lab=byte2_mux.int04}
N 2560 540 2360 540 {lab=byte2_mux.int04}
N 2560 540 2560 270 {lab=byte2_mux.int04}
N 2560 540 2560 590 {lab=byte2_mux.int04}
N 2360 540 2360 590 {lab=byte2_mux.int04}
N 2560 270 2360 270 {lab=byte2_mux.int04}
N 2560 270 2560 240 {lab=byte2_mux.int04}
N 2360 270 2360 240 {lab=byte2_mux.int04}
N 8560 770 8550 770 {lab=byte3_mux.int04}
N 8550 770 8550 520 {lab=byte3_mux.int04}
N 8550 520 3480 520 {lab=byte3_mux.int04}
N 8550 520 8550 60 {lab=byte3_mux.int04}
N 8550 60 8560 60 {lab=byte3_mux.int04}
N 3480 520 3480 240 {lab=byte3_mux.int04}
N 3480 520 3480 590 {lab=byte3_mux.int04}
N 3480 520 3280 520 {lab=byte3_mux.int04}
N 3280 520 3280 590 {lab=byte3_mux.int04}
N 3280 520 3280 240 {lab=byte3_mux.int04}
N 8920 770 8910 770 {lab=byte4_mux.int04}
N 8910 770 8910 500 {lab=byte4_mux.int04}
N 8910 500 4400 500 {lab=byte4_mux.int04}
N 8910 500 8910 60 {lab=byte4_mux.int04}
N 8910 60 8920 60 {lab=byte4_mux.int04}
N 4400 500 4400 590 {lab=byte4_mux.int04}
N 4400 500 4200 500 {lab=byte4_mux.int04}
N 4400 500 4400 240 {lab=byte4_mux.int04}
N 4200 500 4200 240 {lab=byte4_mux.int04}
N 4200 500 4200 590 {lab=byte4_mux.int04}
N 9280 770 9270 770 {lab=byte5_mux.int04}
N 9270 770 9270 830 {lab=byte5_mux.int04}
N 9270 770 9270 60 {lab=byte5_mux.int04}
N 9270 60 9280 60 {lab=byte5_mux.int04}
N 9270 830 5380 830 {lab=byte5_mux.int04}
N 5380 830 5380 680 {lab=byte5_mux.int04}
N 5380 680 5160 680 {lab=byte5_mux.int04}
N 5380 680 5380 590 {lab=byte5_mux.int04}
N 5380 590 5320 590 {lab=byte5_mux.int04}
N 5320 590 5320 270 {lab=byte5_mux.int04}
N 5160 680 5160 590 {lab=byte5_mux.int04}
N 5160 590 5120 590 {lab=byte5_mux.int04}
N 5320 270 5320 240 {lab=byte5_mux.int04}
N 5320 270 5120 270 {lab=byte5_mux.int04}
N 5120 270 5120 240 {lab=byte5_mux.int04}
N 9640 770 9630 770 {lab=byte6_mux.int04}
N 9630 770 9630 660 {lab=byte6_mux.int04}
N 9630 660 9630 60 {lab=byte6_mux.int04}
N 9630 660 6300 660 {lab=byte6_mux.int04}
N 9630 60 9640 60 {lab=byte6_mux.int04}
N 6300 660 6300 590 {lab=byte6_mux.int04}
N 6300 660 6300 680 {lab=byte6_mux.int04}
N 6300 590 6240 590 {lab=byte6_mux.int04}
N 6240 590 6240 270 {lab=byte6_mux.int04}
N 6300 680 6080 680 {lab=byte6_mux.int04}
N 6080 680 6080 590 {lab=byte6_mux.int04}
N 6080 590 6040 590 {lab=byte6_mux.int04}
N 6240 270 6040 270 {lab=byte6_mux.int04}
N 6240 270 6240 240 {lab=byte6_mux.int04}
N 6040 270 6040 240 {lab=byte6_mux.int04}
N 10000 770 9990 770 {lab=byte7_mux.int04}
N 9990 770 9990 600 {lab=byte7_mux.int04}
N 9990 600 7200 600 {lab=byte7_mux.int04}
N 9990 600 9990 60 {lab=byte7_mux.int04}
N 9990 60 10000 60 {lab=byte7_mux.int04}
N 7200 600 7170 600 {lab=byte7_mux.int04}
N 7200 600 7200 680 {lab=byte7_mux.int04}
N 7170 600 7170 590 {lab=byte7_mux.int04}
N 7170 590 7160 590 {lab=byte7_mux.int04}
N 7160 590 7160 270 {lab=byte7_mux.int04}
N 7200 680 7000 680 {lab=byte7_mux.int04}
N 7000 680 7000 590 {lab=byte7_mux.int04}
N 7000 590 6960 590 {lab=byte7_mux.int04}
N 7160 270 6960 270 {lab=byte7_mux.int04}
N 7160 270 7160 240 {lab=byte7_mux.int04}
N 6960 270 6960 240 {lab=byte7_mux.int04}
N 680 620 670 620 {lab=byte0_mux.sel1_n}
N 670 620 670 540 {lab=byte0_mux.sel1_n}
N 670 540 470 540 {lab=byte0_mux.sel1_n}
N 470 540 160 540 {lab=byte0_mux.sel1_n}
N 470 540 470 210 {lab=byte0_mux.sel1_n}
N 470 210 480 210 {lab=byte0_mux.sel1_n}
N 160 540 160 90 {lab=byte0_mux.sel1_n}
N 160 540 160 740 {lab=byte0_mux.sel1_n}
N 1600 620 1590 620 {lab=byte1_mux.sel1_n}
N 1590 620 1590 540 {lab=byte1_mux.sel1_n}
N 1590 540 1390 540 {lab=byte1_mux.sel1_n}
N 1390 540 1080 540 {lab=byte1_mux.sel1_n}
N 1390 540 1390 210 {lab=byte1_mux.sel1_n}
N 1390 210 1400 210 {lab=byte1_mux.sel1_n}
N 1390 210 1390 90 {lab=byte1_mux.sel1_n}
N 1080 540 1080 740 {lab=byte1_mux.sel1_n}
N 1390 90 1080 90 {lab=byte1_mux.sel1_n}
N 2520 620 2510 620 {lab=byte2_mux.sel1_n}
N 2510 620 2510 520 {lab=byte2_mux.sel1_n}
N 2510 520 2310 520 {lab=byte2_mux.sel1_n}
N 2310 520 2310 210 {lab=byte2_mux.sel1_n}
N 2310 520 2000 520 {lab=byte2_mux.sel1_n}
N 2310 210 2320 210 {lab=byte2_mux.sel1_n}
N 2000 520 2000 90 {lab=byte2_mux.sel1_n}
N 2000 520 2000 740 {lab=byte2_mux.sel1_n}
N 3440 620 3430 620 {lab=byte3_mux.sel1_n}
N 3430 620 3430 500 {lab=byte3_mux.sel1_n}
N 3430 500 3230 500 {lab=byte3_mux.sel1_n}
N 3230 500 2920 500 {lab=byte3_mux.sel1_n}
N 3230 500 3230 210 {lab=byte3_mux.sel1_n}
N 3230 210 3240 210 {lab=byte3_mux.sel1_n}
N 2920 500 2920 90 {lab=byte3_mux.sel1_n}
N 2920 500 2920 740 {lab=byte3_mux.sel1_n}
N 4360 620 4350 620 {lab=byte4_mux.sel1_n}
N 4350 620 4350 480 {lab=byte4_mux.sel1_n}
N 4350 620 4350 680 {lab=byte4_mux.sel1_n}
N 4350 480 4150 480 {lab=byte4_mux.sel1_n}
N 4150 480 4150 210 {lab=byte4_mux.sel1_n}
N 4150 210 4150 90 {lab=byte4_mux.sel1_n}
N 4150 210 4160 210 {lab=byte4_mux.sel1_n}
N 4350 680 3840 680 {lab=byte4_mux.sel1_n}
N 3840 680 3840 740 {lab=byte4_mux.sel1_n}
N 4150 90 3840 90 {lab=byte4_mux.sel1_n}
N 5280 620 5270 620 {lab=byte5_mux.sel1_n}
N 5270 620 5270 700 {lab=byte5_mux.sel1_n}
N 5270 620 5270 480 {lab=byte5_mux.sel1_n}
N 5270 480 5070 480 {lab=byte5_mux.sel1_n}
N 5070 480 5070 210 {lab=byte5_mux.sel1_n}
N 5070 210 5070 90 {lab=byte5_mux.sel1_n}
N 5070 210 5080 210 {lab=byte5_mux.sel1_n}
N 5270 700 4760 700 {lab=byte5_mux.sel1_n}
N 4760 700 4760 740 {lab=byte5_mux.sel1_n}
N 5070 90 4760 90 {lab=byte5_mux.sel1_n}
N 6200 620 6190 620 {lab=byte6_mux.sel1_n}
N 6190 620 6190 700 {lab=byte6_mux.sel1_n}
N 6190 620 6190 480 {lab=byte6_mux.sel1_n}
N 6190 480 5990 480 {lab=byte6_mux.sel1_n}
N 5990 480 5990 210 {lab=byte6_mux.sel1_n}
N 5990 210 6000 210 {lab=byte6_mux.sel1_n}
N 5990 210 5990 90 {lab=byte6_mux.sel1_n}
N 6190 700 5680 700 {lab=byte6_mux.sel1_n}
N 5680 700 5680 740 {lab=byte6_mux.sel1_n}
N 5990 90 5680 90 {lab=byte6_mux.sel1_n}
N 7120 620 7110 620 {lab=byte7_mux.sel1_n}
N 7110 620 7110 700 {lab=byte7_mux.sel1_n}
N 7110 620 7110 480 {lab=byte7_mux.sel1_n}
N 7110 480 6910 480 {lab=byte7_mux.sel1_n}
N 6910 480 6910 210 {lab=byte7_mux.sel1_n}
N 6910 210 6920 210 {lab=byte7_mux.sel1_n}
N 6910 210 6910 90 {lab=byte7_mux.sel1_n}
N 7110 700 6600 700 {lab=byte7_mux.sel1_n}
N 6600 700 6600 740 {lab=byte7_mux.sel1_n}
N 6910 90 6600 90 {lab=byte7_mux.sel1_n}
N 7120 770 7090 770 {lab=k_7}
N 7090 770 7090 60 {lab=k_7}
N 7090 770 7090 850 {lab=k_7}
N 7090 60 7120 60 {lab=k_7}
N 7090 850 -70 850 {lab=k_7}
N -70 850 -70 670 {lab=k_7}
N -70 670 -60 670 {lab=k_7}
N 6920 770 6890 770 {lab=k_15}
N 6890 770 6890 60 {lab=k_15}
N 6890 60 6920 60 {lab=k_15}
N 6890 60 6890 0 {lab=k_15}
N 6890 0 90 0 {lab=k_15}
N 90 0 90 390 {lab=k_15}
N 90 390 -60 390 {lab=k_15}
N 6200 770 6170 770 {lab=k_6}
N 6170 770 6170 60 {lab=k_6}
N 6170 770 6170 870 {lab=k_6}
N 6170 60 6200 60 {lab=k_6}
N 6170 870 -90 870 {lab=k_6}
N -90 870 -90 630 {lab=k_6}
N -90 630 -60 630 {lab=k_6}
N 6000 770 5970 770 {lab=k_14}
N 5970 770 5970 60 {lab=k_14}
N 5970 60 6000 60 {lab=k_14}
N 5970 60 5970 -20 {lab=k_14}
N 5970 -20 70 -20 {lab=k_14}
N 70 -20 70 350 {lab=k_14}
N 70 350 -60 350 {lab=k_14}
N 5280 770 5250 770 {lab=k_5}
N 5250 770 5250 830 {lab=k_5}
N 5250 770 5250 60 {lab=k_5}
N 5250 60 5280 60 {lab=k_5}
N 5250 830 90 830 {lab=k_5}
N 90 830 90 590 {lab=k_5}
N 90 590 -60 590 {lab=k_5}
N 5080 770 5050 770 {lab=k_13}
N 5050 770 5050 60 {lab=k_13}
N 5050 60 5080 60 {lab=k_13}
N 5050 60 5050 -40 {lab=k_13}
N 5050 -40 50 -40 {lab=k_13}
N 50 -40 50 310 {lab=k_13}
N 50 310 -60 310 {lab=k_13}
N 4360 770 4330 770 {lab=k_4}
N 4330 770 4330 890 {lab=k_4}
N 4330 770 4330 60 {lab=k_4}
N 4330 60 4360 60 {lab=k_4}
N 4330 890 -110 890 {lab=k_4}
N -110 890 -110 550 {lab=k_4}
N -110 550 -60 550 {lab=k_4}
N 4160 770 4130 770 {lab=k_12}
N 4130 770 4130 170 {lab=k_12}
N 4130 170 450 170 {lab=k_12}
N 4130 170 4130 60 {lab=k_12}
N 4130 60 4160 60 {lab=k_12}
N 450 170 450 270 {lab=k_12}
N 450 270 -60 270 {lab=k_12}
N 3440 770 3410 770 {lab=k_3}
N 3410 770 3410 480 {lab=k_3}
N 3410 480 -60 480 {lab=k_3}
N 3410 480 3410 60 {lab=k_3}
N 3410 60 3440 60 {lab=k_3}
N -60 480 -60 510 {lab=k_3}
N 3240 770 3210 770 {lab=k_11}
N 3210 770 3210 150 {lab=k_11}
N 3210 150 430 150 {lab=k_11}
N 3210 150 3210 60 {lab=k_11}
N 3210 60 3240 60 {lab=k_11}
N 430 150 430 230 {lab=k_11}
N 430 230 -60 230 {lab=k_11}
N 7520 740 7520 330 {lab=uo_out_0}
N 7520 330 10420 330 {lab=uo_out_0}
N 7520 330 7520 90 {lab=uo_out_0}
N 2520 770 2490 770 {lab=k_2}
N 2490 770 2490 460 {lab=k_2}
N 2490 460 -60 460 {lab=k_2}
N 2490 460 2490 60 {lab=k_2}
N 2490 60 2520 60 {lab=k_2}
N -60 460 -60 470 {lab=k_2}
N 7880 740 7880 370 {lab=uo_out_1}
N 7880 370 10420 370 {lab=uo_out_1}
N 7880 370 7880 90 {lab=uo_out_1}
N 2320 770 2290 770 {lab=k_10}
N 2290 770 2290 130 {lab=k_10}
N 2290 130 410 130 {lab=k_10}
N 2290 130 2290 60 {lab=k_10}
N 2290 60 2320 60 {lab=k_10}
N 410 130 410 190 {lab=k_10}
N 410 190 -60 190 {lab=k_10}
N 8240 740 8240 410 {lab=uo_out_2}
N 8240 410 10420 410 {lab=uo_out_2}
N 8240 410 8240 90 {lab=uo_out_2}
N 8600 740 8600 450 {lab=uo_out_3}
N 8600 450 10420 450 {lab=uo_out_3}
N 8600 450 8600 90 {lab=uo_out_3}
N 1600 770 1570 770 {lab=k_1}
N 1570 770 1570 430 {lab=k_1}
N 1570 430 -60 430 {lab=k_1}
N 1570 430 1570 60 {lab=k_1}
N 1570 60 1600 60 {lab=k_1}
N 1400 770 1370 770 {lab=k_9}
N 1370 770 1370 730 {lab=k_9}
N 1370 730 1370 60 {lab=k_9}
N 1370 730 -60 730 {lab=k_9}
N 1370 60 1400 60 {lab=k_9}
N -60 730 -60 750 {lab=k_9}
N 8960 740 8960 490 {lab=uo_out_4}
N 8960 490 8960 90 {lab=uo_out_4}
N 8960 490 10420 490 {lab=uo_out_4}
N 9320 740 9320 530 {lab=uo_out_5}
N 9320 530 9320 90 {lab=uo_out_5}
N 9320 530 10420 530 {lab=uo_out_5}
N 680 770 650 770 {lab=k_0}
N 650 770 650 110 {lab=k_0}
N 650 110 -60 110 {lab=k_0}
N 650 110 650 60 {lab=k_0}
N 650 60 680 60 {lab=k_0}
N -60 110 -60 150 {lab=k_0}
N 9680 740 9680 570 {lab=uo_out_6}
N 9680 570 10420 570 {lab=uo_out_6}
N 9680 570 9680 90 {lab=uo_out_6}
N 480 770 470 770 {lab=k_8}
N 470 770 470 710 {lab=k_8}
N 470 710 390 710 {lab=k_8}
N 390 710 -60 710 {lab=k_8}
N 390 710 390 60 {lab=k_8}
N 390 60 480 60 {lab=k_8}
N 10040 740 10040 610 {lab=uo_out_7}
N 10040 610 10040 90 {lab=uo_out_7}
N 10040 610 10420 610 {lab=uo_out_7}
N 520 740 520 650 {lab=byte0_mux.net_1}
N 720 650 720 740 {lab=byte0_mux.net_3}
N 520 90 520 180 {lab=byte0_mux.net_0}
N 720 180 720 90 {lab=byte0_mux.net_2}
N 1440 740 1440 650 {lab=byte1_mux.net_1}
N 1640 650 1640 740 {lab=byte1_mux.net_3}
N 1440 90 1440 180 {lab=byte1_mux.net_0}
N 1640 180 1640 90 {lab=byte1_mux.net_2}
N 2360 740 2360 650 {lab=byte2_mux.net_1}
N 2560 650 2560 740 {lab=byte2_mux.net_3}
N 2360 90 2360 180 {lab=byte2_mux.net_0}
N 2560 180 2560 90 {lab=byte2_mux.net_2}
N 3280 740 3280 650 {lab=byte3_mux.net_1}
N 3480 650 3480 740 {lab=byte3_mux.net_3}
N 3280 90 3280 180 {lab=byte3_mux.net_0}
N 3480 180 3480 90 {lab=byte3_mux.net_2}
N 4200 740 4200 650 {lab=byte4_mux.net_1}
N 4400 650 4400 740 {lab=byte4_mux.net_3}
N 4200 90 4200 180 {lab=byte4_mux.net_0}
N 4400 180 4400 90 {lab=byte4_mux.net_2}
N 5120 740 5120 650 {lab=byte5_mux.net_1}
N 5320 650 5320 740 {lab=byte5_mux.net_3}
N 5120 90 5120 180 {lab=byte5_mux.net_0}
N 5320 180 5320 90 {lab=byte5_mux.net_2}
N 6040 740 6040 650 {lab=byte6_mux.net_1}
N 6240 650 6240 740 {lab=byte6_mux.net_3}
N 6040 90 6040 180 {lab=byte6_mux.net_0}
N 6240 180 6240 90 {lab=byte6_mux.net_2}
N 6960 740 6960 650 {lab=byte7_mux.net_1}
N 7160 650 7160 740 {lab=byte7_mux.net_3}
N 6960 90 6960 180 {lab=byte7_mux.net_0}
N 7160 180 7160 90 {lab=byte7_mux.net_2}
C {devices/ipin.sym} -60 150 0 0 {name=p161 lab=k_0}
C {devices/ipin.sym} -60 190 0 0 {name=p162 lab=k_10}
C {devices/ipin.sym} -60 230 0 0 {name=p163 lab=k_11}
C {devices/ipin.sym} -60 270 0 0 {name=p164 lab=k_12}
C {devices/ipin.sym} -60 310 0 0 {name=p165 lab=k_13}
C {devices/ipin.sym} -60 350 0 0 {name=p166 lab=k_14}
C {devices/ipin.sym} -60 390 0 0 {name=p167 lab=k_15}
C {devices/ipin.sym} -60 430 0 0 {name=p168 lab=k_1}
C {devices/ipin.sym} -60 470 0 0 {name=p169 lab=k_2}
C {devices/ipin.sym} -60 510 0 0 {name=p170 lab=k_3}
C {devices/ipin.sym} -60 550 0 0 {name=p171 lab=k_4}
C {devices/ipin.sym} -60 590 0 0 {name=p172 lab=k_5}
C {devices/ipin.sym} -60 630 0 0 {name=p173 lab=k_6}
C {devices/ipin.sym} -60 670 0 0 {name=p174 lab=k_7}
C {devices/ipin.sym} -60 710 0 0 {name=p175 lab=k_8}
C {devices/ipin.sym} -60 750 0 0 {name=p176 lab=k_9}
C {devices/ipin.sym} -60 790 0 0 {name=p177 lab=ui_in_0}
C {devices/opin.sym} 10420 330 0 0 {name=p178 lab=uo_out_0}
C {devices/opin.sym} 10420 370 0 0 {name=p179 lab=uo_out_1}
C {devices/opin.sym} 10420 410 0 0 {name=p180 lab=uo_out_2}
C {devices/opin.sym} 10420 450 0 0 {name=p181 lab=uo_out_3}
C {devices/opin.sym} 10420 490 0 0 {name=p182 lab=uo_out_4}
C {devices/opin.sym} 10420 530 0 0 {name=p183 lab=uo_out_5}
C {devices/opin.sym} 10420 570 0 0 {name=p184 lab=uo_out_6}
C {devices/opin.sym} 10420 610 0 0 {name=p185 lab=uo_out_7}
