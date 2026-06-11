local terminal = "foot"
-- The printf business at the end makes programs with spaces in the name executable
local menu = "ls -1 --color=never /usr/local/dmenubin | sort -u | tofi --config ~/.config/tofi/tofi.ini | xargs -0 bash -c 'exec /usr/local/dmenubin/\"$(printf %s \"$@\")\"' _"

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", "Adwaita")
hl.env("ALACRITTY_SOCKET", "wayland")

hl.config({
	input = {
		kb_options = "caps:swapescape",
	},
	general = {
		gaps_in = 4,
		gaps_out = 0,
		border_size = 2,
		--col.active_border = $red,
		--col.inactive_border = $base,
		resize_on_border = false,
		layout = "master",
		no_focus_fallback = true,
	},
	decoration = {
		rounding = 0,
		rounding_power = 2.0,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = false,
		},
		blur = {
			enabled = false,
		},
	},
	animations = {
		enabled = false,
	},
	master = {
		new_status = "slave",
		mfact = 0.55,
		orientation = "left",
	},
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = true,
		font_family = "Mx437 IBM VGA 8x16",
		disable_splash_rendering = true,
	},
	cursor  = {
		no_warps = false,
		persistent_warps = true,
		warp_on_change_workspace = 0,
		hotspot_padding = 3,
	},
	input = {
		kb_layout = "us",
		kb_variant = "altgr-intl",
		kb_model = "",
		kb_options = "caps:swapescape",
		kb_rules = "",
		follow_mouse = 2,
		accel_profile = "flat",
		sensitivity = -0.03,
		touchpad = {
			natural_scroll = false,
		},
	},
	binds = {
		drag_threshold = 10,
	},
	ecosystem = {
		no_donation_nag = true,
	},
})

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("mako")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("waybar")
end)

hl.bind("ALT + SHIFT + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind("ALT + SHIFT + C", hl.dsp.window.close())
hl.bind("ALT + SHIFT + d", hl.dsp.exec_cmd(menu))
hl.bind("ALT + SHIFT + i", hl.dsp.exit(), { long_press = true })
hl.bind("ALT + SHIFT + l", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind("ALT + h", hl.dsp.focus({direction = "l"}))
hl.bind("ALT + j", hl.dsp.focus({direction = "d"}))
hl.bind("ALT + k", hl.dsp.focus({direction = "u"}))
hl.bind("ALT + l", hl.dsp.focus({direction = "r"}))
hl.bind("ALT + RETURN", hl.dsp.layout("swapwithmaster"))
hl.bind("ALT + n", hl.dsp.layout("mfact -0.05"))
hl.bind("ALT + m", hl.dsp.layout("mfact +0.05"))
hl.bind("ALT + f", hl.dsp.exec_cmd("hyprshot -z -m window -o $HOME/Screenshots -t 2000"))
hl.bind("ALT + SHIFT + f", hl.dsp.exec_cmd("hyprshot -z -m region -o $HOME/Screenshots -t 2000"))
hl.bind("CTRL + ALT + f", hl.dsp.exec_cmd("hyprshot -z -m output -o $HOME/Screenshots -t 2000"))
hl.bind("ALT + b", hl.dsp.exec_cmd("makoctl dismiss"))
hl.bind("ALT + SHIFT + b", hl.dsp.exec_cmd("makoctl invoke"))
hl.bind("F11", hl.dsp.window.fullscreen())

-- Send regular shortcuts
for i = 1, 12 do
	-- This should be able to be a single send_shortcut call but there is currently a bug
	-- https://github.com/hyprwm/Hyprland/discussions/14099
	-- hl.bind("ALT + F" .. i, hl.dsp.send_shortcut({ mods = "", key = "F" .. i }))
	hl.bind("ALT + F" .. i, function()
		hl.dispatch(hl.dsp.send_key_state({ mods = "", state = "down", key = "a" }))
		hl.dispatch(hl.dsp.send_key_state({ mods = "", state = "up", key = "a" }))
	end, { repeating = true })
end

-- Mouse
hl.bind("ALT + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("ALT + mouse:272", hl.dsp.window.float(), { mouse = true, click = true })
hl.bind("ALT + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })

-- Audio
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("SHIFT + XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-"), { repeating = true })
hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+"), { repeating = true })
hl.bind("F1", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind("F2", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
hl.bind("F3", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("SHIFT + F1", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind("SHIFT + F2", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%-"), { repeating = true })
hl.bind("SHIFT + F3", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ 5%+"), { repeating = true })

-- Audio players
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("F5", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("F6", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("F7", hl.dsp.exec_cmd("playerctl next"))

-- Backlight
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { repeating = true })
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight set 33%-"), { repeating = true })
hl.bind("XF86KbdBrightnessUp", hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight set 33%+"), { repeating = true })
hl.bind("F9", hl.dsp.exec_cmd("brightnessctl set 5%-"), { repeating = true })
hl.bind("F10", hl.dsp.exec_cmd("brightnessctl set 5%+"), { repeating = true })
hl.bind("SHIFT + F9", hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight set 33%-"), { repeating = true })
hl.bind("SHIFT + F10", hl.dsp.exec_cmd("brightnessctl -d *::kbd_backlight set 33%+"), { repeating = true })


function add_workspace (workspace, monitor, default, workspace_count)
	hl.workspace_rule({ workspace = tostring(workspace_count), default_name = workspace, persistent = true, monitor = monitor, default = default })
	hl.bind("ALT + " .. workspace, hl.dsp.focus({workspace = "name:" .. workspace}))
	hl.bind("ALT + SHIFT + " .. workspace, hl.dsp.window.move({workspace = "name:" .. workspace, follow = false}))
end

function add_workspaces (workspaces)
	for index, arr in ipairs(workspaces) do
		add_workspace(arr[1], arr[2], arr[3], index)
	end
end

hl.window_rule({
	match = {
		float = true,
	},
	opacity = 0.80
})

-- Fix some dragging issues with XWayland
hl.window_rule({
	name  = "fix-xwayland-drags",
	match = {
		class      = "^$",
		title      = "^$",
		xwayland   = true,
		float      = true,
		fullscreen = false,
		pin        = false,
	},
	no_focus = true,
})


-- Ignore maximize requests from all apps. You'll probably like this.
hl.window_rule({
	name  = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})
