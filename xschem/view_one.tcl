# Opens one sheet full screen with its net colours (started by view.sh).
set sheet $env(SHEET)
xschem load $sheet
source [file dirname [info script]]/colours.tcl
apply_colours $sheet
catch {wm attributes . -zoomed 1}
update
after 300 {xschem zoom_full}
