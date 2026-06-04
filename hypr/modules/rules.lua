local function windowRule(class, workspace, silent)
	if silent == nil then
		silent = false
	end

	local ws = silent and (workspace .. " silent") or workspace

	hl.window_rule({
		match = {
			class = class,
		},
		workspace = ws,
	})
end

hl.window_rule({
	match = {
		class = "screensaver",
	},
	fullscreen = true,
	workspace = "special:screensaver",
})

-- Workspace 1: Browsers
windowRule("zen", "1", true)
windowRule("google-chrome", "5")
windowRule("firefox", "1")

-- Workspace 2: Terminals
windowRule("kitty", "2")
-- hl.window_rule({
-- 	match = {
-- 		class = "zen",
-- 	},
-- 	monitor = "HDMI-A-1",
-- 	workspace = 6,
-- })

-- hl.window_rule({
-- 	match = {
-- 		class = "kitty",
-- 	},
-- 	monitor = "HDMI-A-1",
-- 	workspace = 5,
-- })
windowRule("com.mitchellh.ghostty", "2")

-- Workspace 3: Productivity & Dev
windowRule("obsidian", "3")
windowRule("Code", "3")
windowRule("discord", "3")

-- Workspace 4: Media & Tools (Silent)
windowRule("hyprland-dialog", "4", true)
windowRule("mpv", "4", true)
windowRule("Docker Desktop", "4", true)
windowRule("GitKraken", "4", true)
