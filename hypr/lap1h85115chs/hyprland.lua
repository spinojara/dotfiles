require("common")

local m1 = "desc:BOE 0x0C32"

hl.monitor({
	output = m1,
	mode = "1920x1200@60",
	position = "0x0",
	scale = 1,
})

add_workspaces({
	["1"] = m1,
	["2"] = m1,
	["3"] = m1,
	["4"] = m1,
	["5"] = m1,
	["6"] = m1,
	["7"] = m1,
	["8"] = m1,
	["9"] = m1
})
