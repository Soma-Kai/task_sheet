frame .header
pack .header -side top

label .header.lbl -text "Task Tree" 
pack .header.lbl 

frame .body_test
pack .body_test -side top

label .body_test.tst -text "verification of frame"
pack .body_test.tst



wm title . "first commit of main window"
wm geometry . 200x150+300+300
