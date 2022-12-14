#####
#toDo initialize selected list, remove the "blank" element, implement clear "add function"
#top layer
#making binding function by referencing the test file using OOP

lappend auto_path "./test_put.tcl"

set today_task {}
set TODAY_FILE {/Users/somakai/workspace/tcl-tk/study_sheet/DB/today.txt}
set i 0
variable main
font create myfont -family arial -size 14

oo::class create main_window {

	constructor {} {
		my init_mainWindow
	}

	method init_mainWindow {} {
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

		bind .fr_main <Button-1> "focus .fr_main"

		#make header
		label .fr_main.tlt -text "Today's Tasks"
		pack .fr_main.tlt -side top

		#task frame
		frame .fr_main.task
		pack .fr_main.task -side top -fill x

		button .fr_main.task.bt_gene -text "new" -command GenerateTask
		pack .fr_main.task.bt_gene 


		for {set i 0} {$i < [llength $today_task]} {incr i} {
			frame ".fr_main.task.minifr$i" 
			pack ".fr_main.task.minifr$i" -side top -fill x
			button ".fr_main.task.minifr$i.bt" -height 2 -text ">" -command "\$main add_text $i"
			pack ".fr_main.task.minifr$i.bt" -side right -anchor n 
			checkbutton .fr_main.task.minifr$i.ck -text [lindex $today_task $i] -bg gray -height 2 -variable selected($i) -command save_task
			.fr_main.task.minifr$i.ck deselect 
			pack .fr_main.task.minifr$i.ck -expand 1 -fill x -anchor w -pady 1 -side top

		}
	}

	method add_text {i} {
		global myfont
		global today_task
		destroy .fr_main.task.minifr$i.ck 
		destroy .fr_main.task.minifr$i.bt

		checkbutton .fr_main.task.minifr$i.ck -text [lindex $today_task $i] -bg gray -height 2 -variable selected($i) -command save_task
		button .fr_main.task.minifr$i.bt -height 2 -text "<" -command "\$main reverse_text $i"
		text .fr_main.task.minifr$i.txt -font myfont -height 2

		pack .fr_main.task.minifr$i.bt -side right -anchor n
		pack .fr_main.task.minifr$i.ck -expand 1 -fill x -anchor w -pady 1 -side top
		pack .fr_main.task.minifr$i.txt -fill x 

		bind ".fr_main.task.minifr$i.txt" <Return> "\$main extend_text $i"
	}

	method extend_text i {
		set row [.fr_main.task.minifr$i.txt cget -height]
		.fr_main.task.minifr$i.txt configure -height [expr $row + 1]
	}

	method reverse_text i {
		global today_task
		destroy .fr_main.task.minifr$i.ck 
		destroy .fr_main.task.minifr$i.bt
		destroy .fr_main.task.minifr$i.txt

		checkbutton .fr_main.task.minifr$i.ck -text [lindex $today_task $i] -bg gray -height 2 -variable selected($i) -command save_task
		button ".fr_main.task.minifr$i.bt" -height 2 -text ">" -command "\$main add_text $i"

		pack .fr_main.task.minifr$i.bt -side right -anchor n
		pack .fr_main.task.minifr$i.ck -expand 1 -fill x -anchor w -pady 1 -side top
	}
}


######################################
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
	
	focus .gen.task_name
	wm geometry .gen +350+350
}

proc return_gene { task_new } {
	global main
	add_task $task_new
	destroy .fr_main
	$main init_mainWindow
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

set main [main_window new]
wm title . mainwindow
wm geometry . 400x800+300+130
