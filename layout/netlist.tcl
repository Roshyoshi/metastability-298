# Netlists every bench in benches/ into sim/ (started by run_sims.sh)
set root [file dirname [file normalize [info script]]]
file mkdir $root/sim
foreach tb {tb_inv_balance tb_selector tb_duts tb_tau tb_delay tb_frontend tb_controller} {
  if {[catch {xschem load $root/benches/$tb.sch} e]} { puts "FAIL load $tb : $e"; continue }
  catch {set_netlist_dir 1 $root/sim}
  set ::netlist_dir $root/sim
  if {[catch {xschem netlist} e]} { puts "FAIL netlist $tb : $e"; continue }
  set found ""
  foreach d [list $root/sim $::netlist_dir $::env(HOME)/.xschem/simulations [pwd]/simulation [pwd]/simulations [pwd]] {
    if {[file exists $d/$tb.spice]} { set found $d/$tb.spice; break }
  }
  if {$found eq ""} { puts "NOT FOUND $tb (netlist_dir=$::netlist_dir)"; continue }
  if {$found ne "$root/sim/$tb.spice"} { file copy -force $found $root/sim/$tb.spice }
  puts "OK   netlist $tb <- $found"
}
exit
