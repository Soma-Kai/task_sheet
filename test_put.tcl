proc test_puts {} {
	puts hello!world!!!!
}

oo::class create text_widget {
	constructor {} {
		my mw
	}

	method mw {} {
		frame .f
		pack .f

		text .f.t
		pack .f.t
		
		.f.t insert end test
		bind .f.t <Return> {
			test $con
		}

		wm title . test
		wm geometry . +300+300
	}

	method add {} {
		frame .f.ff
		pack .f.ff

		label .f.ff.ad -text added
		pack .f.ff.ad

		wm title . test
		wm geometry . +300+300
	}
}

proc test {con} {
	puts test
	$con add
}

set con [text_widget new]
