hl.config({
	animations = {
		enabled = true, -- Disables all animations globally
	},
})

-- Main motion curve
hl.curve("motion", {
	type = "bezier",
	points = {
		{ 0.05, 0.9 },
		{ 0.1, 1.2 },
	},
})

-- Smooth fade curve
hl.curve("fade", {
	type = "bezier",
	points = {
		{ 0.25, 0.1 },
		{ 0.25, 1.0 },
	},
})

-- Workspace glide
hl.curve("glide", {
	type = "bezier",
	points = {
		{ 0.25, 1 },
		{ 0.5, 1 },
	},
	-- time, animation progress
	-- (0,0)
	-- At only 22% of the time, try to already reach 100% speed/progress pull.
	-- At 36% of the time, overshoot beyond normal progress
	-- (1,1)
})

-- Gentle spring
hl.curve("springy", {
	type = "spring",
	mass = 1,
	stiffness = 65,
	dampening = 14,
})

-- ── Windows ──────────────────────────────────────────────────────

hl.animation({
	leaf = "windowsIn",
	enabled = true,
	speed = 4,
	bezier = "fade",
	style = "popin 92%",
})

hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 3,
	bezier = "fade",
	style = "popin 94%",
})

hl.animation({
	leaf = "windowsMove",
	enabled = true,
	speed = 4,
	bezier = "motion",
})

-- ── Fades ────────────────────────────────────────────────────────

hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 3,
	bezier = "fade",
})

hl.animation({
	leaf = "fadeIn",
	enabled = true,
	speed = 4,
	bezier = "fade",
})

hl.animation({
	leaf = "fadeOut",
	enabled = true,
	speed = 3,
	bezier = "fade",
})

hl.animation({
	leaf = "fadeSwitch",
	enabled = true,
	speed = 3,
	bezier = "fade",
})

hl.animation({
	leaf = "fadeShadow",
	enabled = true,
	speed = 4,
	bezier = "fade",
})

hl.animation({
	leaf = "fadeDim",
	enabled = true,
	speed = 4,
	bezier = "fade",
})

-- ── Layers ───────────────────────────────────────────────────────

hl.animation({
	leaf = "layers",
	enabled = true,
	speed = 6,
	bezier = "motion",
	style = "slide",
})

hl.animation({
	leaf = "layersOut",
	enabled = true,
	speed = 10,
	bezier = "fade",
	style = "slide",
})

-- ── Workspaces ───────────────────────────────────────────────────

hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 5,
	bezier = "glide",
	style = "slide",
})

hl.animation({
	leaf = "workspacesIn",
	enabled = true,
	speed = 5,
	bezier = "glide",
	style = "slide",
})

hl.animation({
	leaf = "workspacesOut",
	enabled = true,
	speed = 4,
	bezier = "fade",
	style = "slide",
})

-- ── Special Workspace ────────────────────────────────────────────

hl.animation({
	leaf = "specialWorkspace",
	enabled = true,
	speed = 5,
	spring = "springy",
	style = "slidevert",
})

-- ── Borders ──────────────────────────────────────────────────────

hl.animation({
	leaf = "border",
	enabled = true,
	speed = 3,
	bezier = "motion",
})

hl.animation({
	leaf = "borderangle",
	enabled = true,
	speed = 4,
	bezier = "motion",
})

-- ── Zoom ─────────────────────────────────────────────────────────

hl.animation({
	leaf = "zoomFactor",
	enabled = true,
	speed = 4,
	bezier = "motion",
})
