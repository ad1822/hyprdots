local colors = {
	color0 = "#181825", -- Catppuccin Mocha: Base (darkest background)
	color1 = "#1e1e2e", -- Catppuccin Mocha: Surface1 (slightly lighter background)
	color2 = "#585b70", -- Catppuccin Mocha: Surface2 (another background shade)
	color3 = "#cdd6f4", -- Catppuccin Mocha: Text (light foreground color)

	-- Catppuccin Mocha accent colors for different modes
	color4 = "#b4befe", -- Lavendar (for normal mode 'a' background)
	color5 = "#89dceb", -- Blue (for visual mode 'a' background)
	color6 = "#f9e2af", -- Yellow (for replace mode 'a' background)
	color7 = "#f38ba8", -- Maroon (for insert mode 'a' background)
	color8 = "#a6e3a1", -- Green (for terminal mode 'a' background)
	color9 = "#89b4fa", -- Blue (for command mode 'a' background)
}

local mocha = {
	inactive = {
		a = { fg = colors.color3, bg = colors.color1, gui = "bold" },
		b = { fg = colors.color3, bg = colors.color2 },
		c = { fg = colors.color3, bg = colors.color0 },
	},
	normal = {
		a = { fg = colors.color0, bg = colors.color4, gui = "bold" }, -- Mauve accent for 'a' section
		b = { fg = colors.color3, bg = colors.color1 },
		c = { fg = colors.color3, bg = colors.color0 },
	},
	visual = {
		a = { fg = colors.color0, bg = colors.color5, gui = "bold" }, -- Flamingo accent for 'a' section
		b = { fg = colors.color3, bg = colors.color1 },
	},
	replace = {
		a = { fg = colors.color0, bg = colors.color6, gui = "bold" }, -- Yellow accent for 'a' section
		b = { fg = colors.color3, bg = colors.color1 },
	},
	insert = {
		a = { fg = colors.color0, bg = colors.color7, gui = "bold" }, -- Peach accent for 'a' section
		b = { fg = colors.color3, bg = colors.color1 },
	},
	terminal = {
		a = { fg = colors.color0, bg = colors.color8, gui = "bold" }, -- Green accent for 'a' section
		b = { fg = colors.color3, bg = colors.color1 },
		c = { fg = colors.color3, bg = colors.color0 },
	},
	command = {
		a = { fg = colors.color0, bg = colors.color9, gui = "bold" }, -- Blue accent for 'a' section
		b = { fg = colors.color3, bg = colors.color1 },
		c = { fg = colors.color3, bg = colors.color0 },
	},
}
return {
	"nvim-lualine/lualine.nvim",
	enabled = true,
	opts = {
		options = {
			icons_enabled = true,
			theme = mocha,
			component_separators = { left = "::", right = "::" },
			section_separators = { left = "", right = "" },
			globalstatus = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { {
				"branch",
				icon = "󰘬",
			}, "diff", "diagnostics" },

			lualine_c = {
				{ "filename", path = 0 }, -- path=0 just filename, path=1 relative, path=2 absolute
				{ "filesize" },
			},
			-- lualine_x = {
			-- 	function()
			-- 		local encoding = vim.o.fileencoding
			-- 		if encoding == "" then
			-- 			return vim.bo.fileformat .. " :: " .. vim.bo.filetype
			-- 		else
			-- 			return encoding .. " :: " .. vim.bo.fileformat .. " :: " .. vim.bo.filetype
			-- 		end
			-- 	end,
			-- },
			lualine_x = {
				{ "encoding" },
				-- { "fileformat" },
				{ "filetype" },
				{ "lsp" },
				{ "searchcount" },
				{ "selectioncount" },
			},
			lualine_y = { "progress", {
				"os.date('%H:%M')",
			} },
			lualine_z = { "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
	},
}
