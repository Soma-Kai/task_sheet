#####
#top layer

set today_task {}

proc init_mainWindow {} {
	#set today_task {}
	frame .fr_main
	pack .fr_main

	#make header
	label .fr_main.tlt -text "Today's Tasks"
	pack .fr_main.tlt -side left

	#task frame
	frame .fr_main.task
	pack .fr_main.task -side top

	button .fr_main.task.bt_gene -text "new" -command GenerateTask
	pack .fr_main.task.bt_gene
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

	bind .gen.task_name <Return> {return_gene $task_new}

	button .gen.bt_return -text return -command {
		lappend today_task $task_new;
		puts $today_task;
		destroy .fr_main;
		init_mainWindow;
		destroy .gen;
	}
	pack .gen.bt_return

}

proc return_gene { task_new } {
	global today_task
	lappend today_task $task_new;
	puts $today_task;
	destroy .fr_main;
	init_mainWindow;
	destroy .gen;
}

wm title . mainwindow
wm geometry . 200x300+300+300
