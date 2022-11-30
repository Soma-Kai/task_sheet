frame .header
pack .header -side top

label .header.lbl -text "Task Tree" 
pack .header.lbl 

canvas .header.border -height 20
pack .header.border 
.header.border create line 20 10 180 10 -fill black

entry .header.e0 -textvariable buffer
pack .header.e0

puts $buffer

frame .body_test
pack .body_test -side top

label .body_test.tst -text "verification of frame"
pack .body_test.tst

set test {task1 task2 task3}

for {set i 0} {$i < [llength $test]} {incr i} {
	frame .body_test.fr_ck$i -height 20
	pack .body_test.fr_ck$i -side top
	checkbutton .body_test.fr_ck${i}.ck$i -text [lindex $test $i] 
	pack .body_test.fr_ck${i}.ck$i -side left 
	button .body_test.fr_ck${i}.bt$i -text "generating task"
	pack .body_test.fr_ck${i}.bt$i -side left 
}
canvas .body_test.can
pack .body_test.can

proc assign_gen {} {

	toplevel .gen
	wm resizable .gen 0 0
	wm title .gen "generate new task"

	entry .gen.task_name -textvariable task_new
	pack .gen.task_name

	button .gen.bt_return -text return -command {destroy .gen}
	pack .gen.bt_return

}

bind .body_test.fr_ck1.bt1 <Button-1> {
	puts "check"	
	assign_gen
}

wm title . "first commit of main window"
wm geometry . 200x300+300+300
