return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	lazy = false,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				dark = "mocha",
			},
			transparent_background = true, -- disables setting the background color.
			float = {
				transparent = true, -- enable transparent floating windows
				solid = true, -- use solid styling for floating windows, see |winborder|
			},
			show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
			term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
			dim_inactive = {
				enabled = true, -- dims the background color of inactive window
				shade = "dark",
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
			no_italic = true, -- Force no italic
			no_bold = true, -- Force no bold
			no_underline = true, -- Force no underline
			styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
				comments = { "italic" }, -- Change the style of comments
				conditionals = { "italic" },
				loops = {},
				functions = {},
				keywords = {},
				strings = {},
				variables = {},
				numbers = {},
				booleans = {},
				properties = {},
				types = {},
				operators = {},
				miscs = {}, -- Uncomment to turn off hard-coded styles
			},
			color_overrides = {},
			custom_highlights = function()
				return {
					-- Custom background (mantle) color
					Normal = { bg = "#11111b" },
					NormalNC = { bg = "#11111b" },
					NormalFloat = { bg = "#11111b" },
				}
			end,
			default_integrations = true,
			auto_integrations = false,
			integrations = {
				dap = true,
				cmp = false,
				nvim_surround = false,
				telescope = {
					enabled = true,
				},
				blink_cmp = {
					style = "solid",
				},
				which_key = false,
				gitsigns = {
					enabled = true,
					transparent = true,
				},
				mason = true,
				noice = true,
				barbecue = {
					dim_dirname = true, -- directory name is dimmed by default
					bold_basename = true,
					dim_context = false,
					alt_background = true,
				},
				nvimtree = false,
				treesitter = false,
				notify = true,
				mini = {
					enabled = false,
					indentscope_color = "",
				},
				snacks = {
					enabled = true,
					indent_scope_color = "mauve",
				},
			},
		})

		vim.cmd.colorscheme("catppuccin")
		vim.opt.winborder = "rounded"
	end,
}
