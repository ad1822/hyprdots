hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 6,
		border_size = 1,
		col = {
			active_border = {
				colors = {
					"rgb(f5c2e7)",
					"rgb(000000)",
				},
				angle = 45,
			},
			inactive_border = {
				colors = {
					"rgb(242731)",
				},
			},
		},
		resize_on_border = true,
		extend_border_grab_area = 30,
		hover_icon_on_border = true,
		resize_corner = 5,
		allow_tearing = false,
		layout = "scrolling",
	},

	scrolling = {
		focus_fit_method = 1,
		explicit_column_widths = "0.5,1",
		direction = "left",
	},
	dwindle = {
		-- pseudotile = true
		preserve_split = true,
	},
	master = {
		new_status = inherit,
		new_on_top = true,
		new_on_active = "true",
		smart_resizing = true,
	},
})
