v {xschem version=3.4.4 file_version=1.2}
G {}
K {}
V {}
S {}
E {}
T {bank: Flip-flop bank: three more flip-flops under test, their own capture copy, selector and early observer} 0 -200 0 0 0.45 0.45 {}
T {Press e on a block to open it; Ctrl+e returns here. Blocks connect through equal net labels.} 0 -165 0 0 0.25 0.25 {}
C {@@ROOT@@/blocks/bank_trial_clock.sym} 260 30 0 0 {name=xbank_trial_clock}
C {devices/lab_pin.sym} 180 20 0 0 {name=l1 lab=clk}
C {devices/lab_pin.sym} 180 40 0 0 {name=l2 lab=rst_n}
C {devices/lab_pin.sym} 340 20 0 1 {name=l3 lab=bank_a}
C {@@ROOT@@/blocks/bank_capture_drivers.sym} 780 20 0 0 {name=xbank_capture_drivers}
C {devices/lab_pin.sym} 700 20 0 0 {name=l4 lab=bank_a}
C {devices/lab_pin.sym} 860 20 0 1 {name=l5 lab=bank_cap}
C {@@ROOT@@/blocks/bank_data_input.sym} 1300 20 0 0 {name=xbank_data_input}
C {devices/lab_pin.sym} 1220 20 0 0 {name=l6 lab=uio_in_0}
C {devices/lab_pin.sym} 1380 20 0 1 {name=l7 lab=bank_data}
C {@@ROOT@@/blocks/bank_duts.sym} 260 220 0 0 {name=xbank_duts}
C {devices/lab_pin.sym} 180 200 0 0 {name=l8 lab=bank_cap}
C {devices/lab_pin.sym} 180 220 0 0 {name=l9 lab=bank_data}
C {devices/lab_pin.sym} 340 200 0 1 {name=l10 lab=bank_q_0}
C {devices/lab_pin.sym} 340 220 0 1 {name=l11 lab=bank_q_1}
C {devices/lab_pin.sym} 340 240 0 1 {name=l12 lab=bank_q_2}
C {@@ROOT@@/blocks/bank_selector.sym} 780 240 0 0 {name=xbank_selector}
C {devices/lab_pin.sym} 700 200 0 0 {name=l13 lab=bank_q_0}
C {devices/lab_pin.sym} 700 220 0 0 {name=l14 lab=bank_q_1}
C {devices/lab_pin.sym} 700 240 0 0 {name=l15 lab=bank_q_2}
C {devices/lab_pin.sym} 700 260 0 0 {name=l16 lab=ui_in_1}
C {devices/lab_pin.sym} 700 280 0 0 {name=l17 lab=ui_in_2}
C {devices/lab_pin.sym} 860 200 0 1 {name=l18 lab=bank_selected_q}
C {@@ROOT@@/blocks/bank_early_observer.sym} 1300 210 0 0 {name=xbank_early_observer}
C {devices/lab_pin.sym} 1220 200 0 0 {name=l19 lab=bank_selected_q}
C {devices/lab_pin.sym} 1220 220 0 0 {name=l20 lab=ui_in_5}
C {devices/lab_pin.sym} 1380 200 0 1 {name=l21 lab=bank_early_q}
