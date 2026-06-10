hl.config({
	decoration = {
		dim_special = 0.2,
		rounding = 0,
    active_opacity = 1,
    inactive_opacity = 1,
		blur = {
			enabled = true,
			size = 5,
			popups = true,
			passes = 4,
			new_optimizations = true,
			vibrancy = 0.4,
			ignore_opacity = true,
			special = true,
		},
		shadow = {
			enabled = false,
			range = 300,
			render_power = 3,
			color = "rgba(1a1a1aaf)",
			offset = "10 10",
			-- scale = 0.95,
			-- ignore_window = true,
		},
	},
})
