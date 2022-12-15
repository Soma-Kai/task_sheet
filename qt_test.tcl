set value {red blue}

oo::class create Window {
    constructor {} {
        my make_button
    }

    method make_button {} {
	global value
        foreach val $value {
        button ".bt$val" -text $val -fg gray -command "assign \$window $val"
        pack .bt$val
        }
    }

    method change_fg color {
        .bt$color configure -fg $color
    }
}

proc assign {window color} {
    $window change_fg $color
}

set window [Window new]
