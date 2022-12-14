proc test_puts {} {
	puts hello!world!!!!
}

oo::class create add_widget {
	constructor {} {
		make_mw
		wm title . "tst"
		wm geometry 300+300
	}

	method make_mw {} {
		frame .f
		pack .f

		button .f.bt -text test -command add_label
		pack .f.bt
	}

	method add_label {} {
		destroy .f
		make_mw
		label .f.lbl -text "added label"
		pack .f.lbl
		wm title . "tst"
		wm geometry 300+300
	}
}

set instance [add_widget new]
instance
