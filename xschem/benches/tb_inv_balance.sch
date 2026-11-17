v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {tb_inv_balance: Balance point: inv_1 and nand2_1 (A2 high) transfer curves} -400 -260 0 0 0.45 0.45 {}
T {Expected: inv1_switch_V = 1.39 (earlier inv_1 reference); nand2_switch_V = about 1.44 (master-latch balance 1.442 V)} -400 -225 0 0 0.22 0.22 {}
C {devices/vsource.sym} -200 0 0 0 {name=vvdd value="3.3"}
C {devices/lab_pin.sym} -200 -30 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} -200 30 0 0 {name=gvvdd}
C {devices/vsource.sym} -80 0 0 0 {name=vin value="0"}
C {devices/lab_pin.sym} -80 -30 0 0 {name=l2 lab=vin}
C {devices/gnd.sym} -80 30 0 0 {name=gvin}
C {/home/oshan/metastability-298/xschem/cells_tx/inv_1.sym} 200 0 0 0 {name=xinv}
C {devices/lab_pin.sym} 150 0 0 0 {name=l3 lab=vin}
C {devices/lab_pin.sym} 250 0 0 1 {name=l4 lab=vout_inv}
C {/home/oshan/metastability-298/xschem/cells_tx/nand2_1.sym} 200 150 0 0 {name=xnand}
C {devices/lab_pin.sym} 150 140 0 0 {name=l5 lab=vin}
C {devices/lab_pin.sym} 150 160 0 0 {name=l6 lab=VDD}
C {devices/lab_pin.sym} 250 140 0 1 {name=l7 lab=vout_nand}
C {devices/code_shown.sym} 420 -150 0 0 {name=SIM only_toplevel=false value=".include /home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/ngspice/design.ngspice
.lib /home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/ngspice/sm141064.ngspice typical
.lib /home/oshan/.ciel/ciel/gf180mcu/versions/5740c4a81c42f9fe4af5ef2ee258a99151053d28/gf180mcuD/libs.tech/ngspice/sm141064.ngspice diode_typical
.global VDD
.param sw_stat_global=0 sw_stat_mismatch=0
.control
set filetype=ascii
dc vin 0 3.3 0.001
meas dc sw_inv find v(vin) when v(vout_inv)=v(vin)
meas dc sw_nand find v(vin) when v(vout_nand)=v(vin)
echo RESULT inv1_switch_V $&sw_inv
echo RESULT nand2_switch_V $&sw_nand
wrdata tb_inv_balance.dat v(vout_inv) v(vout_nand)
.endc"}
