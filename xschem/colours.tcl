# Net colours of a sheet: the .hl file next to it lists 'net colour-index' (Xschem highlight colours).
proc apply_colours {sheet} {
  set hl [file rootname $sheet].hl
  if {![file exists $hl]} { return }
  set fh [open $hl r]
  foreach line [split [read $fh] "\n"] {
    if {[llength $line] == 2} {
      catch {xschem set hilight_color [lindex $line 1]}
      catch {xschem hilight_netname [lindex $line 0]}
    }
  }
  close $fh
  catch {xschem redraw}
}
