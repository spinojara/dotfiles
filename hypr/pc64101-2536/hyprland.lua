require("common")

m1 = "desc:HP Inc. HP 527pq VNG50805YW"
m2 = "desc:HP Inc. HP 527pq VNG53002J4"
m3 = "desc:HP Inc. HP 527pq VNG5480H24"

hl.monitor({
	output = m1,
	mode = "2560x1440@100",
	position = "0x395",
	scale = 1,
})

hl.monitor({
	output = m2,
	mode = "2560x1440@100",
	position = "2560x395",
	scale = 1,
})

hl.monitor({
	output = m3,
	mode = "2560x1440@100",
	position = "-1440x0",
	scale = 1,
	transform = 3,
})

add_workspaces({
	{ "1", m1, true },
	{ "2", m1, false },
	{ "3", m1, false },
	{ "4", m1, false },
	{ "5", m1, false },
	{ "6", m1, false },
	{ "7", m1, false },
	{ "8", m1, false },
	{ "9", m1, false },
	{ "q", m2, true },
	{ "w", m2, false },
	{ "e", m2, false },
	{ "r", m2, false },
	{ "t", m2, false },
	{ "a", m3, true },
	{ "s", m3, false },
})

-- 720 + 395 = 1115
hl.on("hyprland.start", function ()
	hl.dsp.cursor.move({ x = 1280, y = 1115 })
	hl.exec_cmd("nuclear-xdg-desktop-portal")
end)

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKENDS_PATH", "/usr/lib/x86_64-linux-gnu/gbm")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

hl.bind("ALT + SHIFT + p", hl.dsp.exec_cmd("systemctl poweroff"), { long_press = true })
hl.bind("ALT + SHIFT + o", hl.dsp.exec_cmd("systemctl poweroff"), { long_press = true })

hl.window_rule({
	match = {
		class = "(i?)firefox.*",
		workspace = "r[1-9]w[v2-100]",
	},
	workspace = "name:q silent",
})
