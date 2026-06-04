-- modules/binds.lua
local vars = require("modules.variables")

local mod = "SUPER"
local mods = "SUPER + SHIFT"
local moda = "SUPER + ALT"
local modc = "SUPER + CTRL"
local modcs = "SUPER + CTRL + SHIFT"

local function bind(modifier, key, cmd)
	hl.bind(modifier .. " + " .. key, hl.dsp.exec_cmd(cmd))
end

local function bindDsp(modifier, key, dispatcher)
	hl.bind(modifier .. " + " .. key, dispatcher)
end

-- Scrolling layout binds using native dispatchers
hl.bind(mod .. " + equal", hl.dsp.layout("colresize +0.1"))
hl.bind(mod .. " + minus", hl.dsp.layout("colresize -0.1"))
hl.bind(mod .. " + comma", hl.dsp.layout("swapcol l"))
hl.bind(mod .. " + period", hl.dsp.layout("swapcol r"))

-- ── Apps ─────────────────────────────────────────────────────────
bind(mod, "T", vars.terminal)
bind(mod, "E", vars.terminal .. " -e " .. vars.fileManager)
bind(mod, "C", vars.colorpicker .. " -a")
bind(mod, "B", vars.zenBrowser)
bind(mod, "O", vars.note)

-- ── Rofi ─────────────────────────────────────────────────────────
bind(mod, "P", "~/.config/rofi/powermenu/powermenu.sh")
bind(mod, "SPACE", "~/.config/rofi/launcher/launcher.sh")
bind(mod, "M", "~/.config/rofi/clipboard/launcher.sh")
bind(mod, "A", "bash ~/.config/rofi/wifi/wifi.sh")

-- ── Wallpaper ────────────────────────────────────────────────────
bind(mods, "R", "~/.config/rofi/wallselect/script.sh && hyprpaper")
bind(mod, "I", "sh -c '~/.config/waybar/scripts/change-wallpaper.sh && hyprpaper'")

-- ── Waybar ───────────────────────────────────────────────────────
bind("ALT + SHIFT", "W", "pkill -9 waybar || waybar &")
bind("ALT + SHIFT", "T", "~/config_bak/waybar/scripts/toggle-trans.sh")

-- ── Task Manager ─────────────────────────────────────────────────
bind(modcs, "Tab", vars.terminal .. " -e " .. vars.taskManager)

-- ── Screenshots ──────────────────────────────────────────────────
bind(
	mods,
	"S",
	'sh -c \'slurp | grim -g - /tmp/photo.png && wl-copy --type image/png < /tmp/photo.png && notify-send -w "Screenshot" "Screenshot copied to clipboard" -i /tmp/photo.png\''
)
bind(
	mods,
	"L",
	'sh -c \'~/work/side/vim-screenshot/vim-screenshot && sleep 1 && wl-copy --type image/png < /tmp/photo.png && notify-send -w "Screenshot" "Screenshot copied to clipboard" -i /tmp/photo.png\''
)
bind(
	moda,
	"S",
	'sh -c \'FILE=$HOME/Pictures/Screenshot/$(date +%m-%d-%H-%M-%S).png && grim -g "$(slurp)" "$FILE" && notify-send "Screenshot Saved" -i "$FILE"\''
)

-- ── Volume ───────────────────────────────────────────────────────
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("sh -c 'pamixer -i 2 --allow-boost && ~/.local/bin/volume.sh'"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("sh -c 'pamixer -d 2 --allow-boost && ~/.local/bin/volume.sh'"))
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd(
		"sh -c 'pamixer -t && dunstify -i ~/.config/dunst/assets/$(pamixer --get-mute | grep -q true && echo volume-mute.svg || echo volume.svg) -t 500 -r 2593 \"Toggle Mute\"'"
	)
)

-- ── Player ───────────────────────────────────────────────────────
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"))

-- ── Brightness ───────────────────────────────────────────────────
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("sh -c 'brightnessctl set 2%- && ~/.local/bin/brightness.sh'"))
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("sh -c 'brightnessctl set +2% && ~/.local/bin/brightness.sh'"))

-- ── Window Controls ──────────────────────────────────────────────
bindDsp(mod, "W", hl.dsp.window.close())

bindDsp("SUPER", "F", function()
	hl.dispatch(hl.dsp.layout("colresize +conf"))
	hl.dispatch(hl.dsp.layout("focus r"))
	hl.dispatch(hl.dsp.layout("focus l"))
end)

-- bindDsp(mod, "F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
bindDsp(mod, "G", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

bindDsp(mod, "V", hl.dsp.window.float({ action = "toggle" }))

-- bindDsp("ALT", "Tab", hl.dsp.window.focus_cycle({ direction = "next" }))
-- Bind SUPER + Tab to toggle the Hyprspace overview
-- hl.bind({
-- 	mod = "SUPER",
-- 	key = "Tab",
-- 	dispatcher = "overview:toggle",
-- 	args = "",
-- })
-- bindDsp("ALT + SHIFT", "Tab", hl.dsp.focus_cycle({ direction = "prev" }))

-- ── Vim Navigation ───────────────────────────────────────────────
bindDsp(mod, "H", hl.dsp.focus({ direction = "l" }))
bindDsp(mod, "L", hl.dsp.focus({ direction = "r" }))
bindDsp(mod, "K", hl.dsp.focus({ direction = "u" }))
bindDsp(mod, "J", hl.dsp.focus({ direction = "d" }))

-- ── Workspaces ───────────────────────────────────────────────────
for i = 1, 10 do
	local key = tostring(i % 10)
	local ws = tostring(i)

	hl.bind(mod .. " + " .. key, function()
		local current = hl.get_active_workspace()
		if current ~= nil and current.id == i then
			-- already on this workspace, go back to previous
			hl.dispatch(hl.dsp.focus({ workspace = "previous" }))
		else
			hl.dispatch(hl.dsp.focus({ workspace = ws }))
		end
	end)

	hl.bind(mods .. " + " .. key, hl.dsp.window.move({ workspace = ws }))
end

-- ── Mouse Workspace Scroll ───────────────────────────────────────
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ── Hyprlock ─────────────────────────────────────────────────────
bind(mod, "L", "hyprlock")
