hl.monitor({ output = "eDP-2", mode = "1920x1080@144", position = "auto", scale = 1.5 })
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@60", position = "auto", scale = 1 })

hl.workspace_rule({
	workspace = "1",
	monitor = "eDP-2",
})
hl.workspace_rule({
	workspace = "2",
	monitor = "eDP-2",
})
hl.workspace_rule({
	workspace = "3",
	monitor = "eDP-2",
})
hl.workspace_rule({
	workspace = "4",
	monitor = "eDP-2",
})

hl.workspace_rule({
	workspace = "5",
	monitor = "HDMI-A-1",
})
hl.workspace_rule({
	workspace = "6",
	monitor = "HDMI-A-1",
})
hl.workspace_rule({
	workspace = "7",
	monitor = "HDMI-A-1",
})
hl.workspace_rule({
	workspace = "8",
	monitor = "HDMI-A-1",
})
