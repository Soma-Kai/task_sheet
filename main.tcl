frame .header
pack .header -side top

label .header.lbl -text "Task Tree" 
pack .header.lbl 

canvas .header.border -height 20
pack .header.border 
.header.border create line 20 10 180 10 -fill black

frame .body_test
pack .body_test -side top

label .body_test.tst -text "verification of frame"
pack .body_test.tst

canvas .body_test.can
pack .body_test.can

.body_test.can create line 80 75 120 75 -fill red



wm title . "first commit of main window"
wm geometry . 200x150+300+300
