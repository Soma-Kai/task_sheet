#####
#toDo initialize selected list, remove the "blank" element, implement clear "add function"
#top layer
#making binding function by referencing the test file using OOP

lappend auto_path "./test_put.tcl"

set today_task {}
set TODAY_FILE {/Users/somakai/workspace/tcl-tk/study_sheet/DB/today.txt}
set i 0
variable path

proc init_mainWindow {} {
	global today_task
	global TODAY_FILE
	global selected
	global i

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
		.fr_main.task.ck$i deselect 
		pack .fr_main.task.ck$i -expand 1 -fill x -anchor w -pady 1

		bind .fr_main.task.ck$i <Button-2> {
			puts [.fr_main.task.ck$i cget -text]
			destroy .fr_main
			memo [lindex $today_task $i]
		}
	}
}

#############
#binding function
proc memo {task_name} {
	global path
	#operation of file
	puts $task_name
	set path /Users/somakai/workspace/tcl-tk/study_sheet/DB/$task_name.txt
	#exec touch $path
	puts check
	frame .f
	pack .f
	text .f.t 
	pack .f.t 
	.f.t insert end "remarks"
	wm title . remarks
	wm geometry . +300+300
	bind .f.t <Return> {
		global path
		#save the remarks binding the corresponding task
		set txt_remark [.f.t get 1.0 end]
		#puts -nonewline $path $txt_remark
		init_mainWindow
		destroy .f
	}
}




#########
#GenerateTask
proc GenerateTask {} {
	global today_task
	toplevel .gen
	wm resizable .gen 0 0
	wm title .gen "generate new task"

	entry .gen.task_name -textvariable task_new
	pack .gen.task_name

	.gen.task_name selection clear
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
			upvar selected($index) init
			set init 0
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

init_mainWindow
wm title . mainwindow
wm geometry . 400x800+300+130
