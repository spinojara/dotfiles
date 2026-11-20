require("common")

local m1 = "desc: Dell Inc. DELL P2725DE 99Y6JK4"

hl.monitor({
	output = m1,
	mode = "2560x1440@100",
	position = "0x0",
	scale = 1,
})

add_workspaces({
	{"1", m1, true},
	{"2", m1, false},
	{"3", m1, false},
	{"4", m1, false},
	{"5", m1, false},
	{"6", m1, false},
	{"7", m1, false},
	{"8", m1, false},
	{"9", m1, false}
})

hl.on("hyprland.start", function ()
	hl.dsp.cursor.move({ x = 960, y = 540 })
	hl.exec_cmd("gentoo-pipewire-launcher")
end)

hl.bind("ALT + SHIFT + p", hl.dsp.exec_cmd("loginctl poweroff"), { long_press = true })
hl.bind("ALT + SHIFT + o", hl.dsp.exec_cmd("loginctl reboot"), { long_press = true })
