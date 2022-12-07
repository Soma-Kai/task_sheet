#####
#toDo initialize selected list, remove the "blank" element, implement clear "add function"
#top layer

set today_task {}
set TODAY_FILE {./DB/today.txt}
set selected(100) 0 

proc init_mainWindow {} {
	global today_task
	global TODAY_FILE
	global selected

	#set today_task 
	set input_stream [open $TODAY_FILE r]
	set today_task [split [gets $input_stream] :]
	#delete the null
	set index [lsearch $today_task ""]
	set today_task [lreplace $today_task $index $index]
	
	frame .fr_main
	pack .fr_main -expand 1 -fill both

	#make header
	label .fr_main.tlt -text "Today's Tasks"
	pack .fr_main.tlt -side top

	#task frame
	frame .fr_main.task
	pack .fr_main.task -side top -fill x

	button .fr_main.task.bt_gene -text "new" -command GenerateTask
	pack .fr_main.task.bt_gene 

	for {set i 0} {$i < [llength $today_task]} {incr i} {
		checkbutton .fr_main.task.ck$i -text [lindex $today_task $i] -bg gray -height 2 -variable selected($i) -command save_task
		pack .fr_main.task.ck$i -expand 1 -fill x -anchor w -pady 1
	}
}


init_mainWindow

#########
#GenerateTask
proc GenerateTask {} {
	global today_task
	toplevel .gen
	wm resizable .gen 0 0
	wm title .gen "generate new task"

	entry .gen.task_name -textvariable task_new
	pack .gen.task_name

	bind .gen.task_name <Return> {return_gene $task_new; set task_new ""}

	button .gen.bt_return -text return -command {return_gene $task_new; set task_new ""}
	pack .gen.bt_return
	
	wm geometry .gen +350+350
}

proc return_gene { task_new } {
	add_task $task_new
	destroy .fr_main
	init_mainWindow
	destroy .gen
}

###################################
#save the tasks

proc save_task {} {
	global today_task
	global selected 
	global TODAY_FILE
	#output stream
	set output_stream [open $TODAY_FILE w]
	# todo save the task which is not selected
	foreach {index boolean} [array get selected] {
		if {!$boolean} {
			puts -nonewline $output_stream [lindex $today_task $index]
			puts -nonewline $output_stream :
		}
	}
	close $output_stream
}

proc add_task {task_new} {
	global today_task
	global TODAY_FILE
	#output stream
	set outout_stream [open $TODAY_FILE a]
	puts -nonewline $outout_stream $task_new
	puts -nonewline $outout_stream :
	close $outout_stream
}

wm title . mainwindow
wm geometry . 200x300+300+300
