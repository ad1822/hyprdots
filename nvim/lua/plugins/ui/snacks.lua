return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		-- Custom Catppuccin Color Palette Picker
		-- Top Pickers & Explorer
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>,",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>n",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification History",
		},
		{
			"<leader>e",
			function()
				-- vim.cmd("Explorer")
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},
		-- find
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>fp",
			function()
				Snacks.picker.projects()
			end,
			desc = "Projects",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},
		-- git
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches({ layout = "select" })
			end,
			desc = "Git Branches",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Git Log Line",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status({ layout = "default" })
			end,
			desc = "Git Status",
		},
		{
			"<leader>gS",
			function()
				Snacks.picker.git_stash()
			end,
			desc = "Git Stash",
		},
		{
			"<leader>gd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Git Diff (Hunks)",
		},
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Git Log File",
		},
		-- Grep
		{
			"<leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		-- search
		{
			'<leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>s/",
			function()
				Snacks.picker.search_history()
			end,
			desc = "Search History",
		},
		{
			"<leader>sa",
			function()
				Snacks.picker.autocmds()
			end,
			desc = "Autocmds",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>sC",
			function()
				Snacks.picker.commands()
			end,
			desc = "Commands",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>sD",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>sH",
			function()
				Snacks.picker.highlights()
			end,
			desc = "Highlights",
		},
		{
			"<leader>si",
			function()
				Snacks.picker.icons()
			end,
			desc = "Icons",
		},
		{
			"<leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>sl",
			function()
				Snacks.picker.loclist()
			end,
			desc = "Location List",
		},
		{
			"<leader>sm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>sM",
			function()
				Snacks.picker.man()
			end,
			desc = "Man Pages",
		},
		{
			"<leader>sp",
			function()
				Snacks.picker.lazy()
			end,
			desc = "Search for Plugin Spec",
		},
		{
			"<leader>sq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix List",
		},
		{
			"<leader>sR",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		{
			"<leader>uC",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Colorschemes",
		},
		-- LSP
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto T[y]pe Definition",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>sS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
		-- Other
		{
			"<leader>z",
			function()
				Snacks.zen()
			end,
			desc = "Toggle Zen Mode",
		},
		{
			"<leader>Z",
			function()
				Snacks.zen.zoom()
			end,
			desc = "Toggle Zoom",
		},
		{
			"<leader>.",
			function()
				Snacks.scratch()
			end,
			desc = "Toggle Scratch Buffer",
		},
		{
			"<leader>S",
			function()
				Snacks.scratch.select()
			end,
			desc = "Select Scratch Buffer",
		},
		{
			"<leader>n",
			function()
				Snacks.notifier.show_history()
			end,
			desc = "Notification History",
		},
		{
			"<leader>bd",
			function()
				Snacks.bufdelete()
			end,
			desc = "Delete Buffer",
		},
		{
			"<leader>cR",
			function()
				Snacks.rename.rename_file()
			end,
			desc = "Rename File",
		},
		{
			"<leader>gB",
			function()
				Snacks.gitbrowse()
			end,
			desc = "Git Browse",
			mode = { "n", "v" },
		},
		{
			"<leader>gg",
			function()
				Snacks.lazygit()
			end,
			desc = "Lazygit",
		},
		{
			"<leader>un",
			function()
				Snacks.notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
		{
			"<c-/>",
			function()
				Snacks.terminal()
			end,
			desc = "Toggle Terminal",
		},
		{
			"<c-_>",
			function()
				Snacks.terminal()
			end,
			desc = "which_key_ignore",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next Reference",
			mode = { "n", "t" },
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Prev Reference",
			mode = { "n", "t" },
		},
		{
			"<leader>N",
			desc = "Neovim News",
			function()
				Snacks.win({
					file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
					width = 0.6,
					height = 0.6,
					wo = {
						spell = false,
						wrap = false,
						signcolumn = "yes",
						statuscolumn = " ",
						conceallevel = 3,
					},
				})
			end,
		},
	},
	opts = {
		explorer = {
			replace_netrw = false,
			enabled = false,
		},
		lazygit = {
			configure = true,
		},
		notifier = {
			width = {
				min = 40,
				max = 0.8,
			},
			height = {
				min = 1,
				max = 0.8,
			},
			padding = true,
			timeout = 5000,
			styles = "compact",
			top_down = true,
			margin = { top = 1, right = 1, bottom = 0 },
		},
		toggle = {
			which_key = true,
			opts = {
				wrap = true,
			},
			notify = true,
			icon = {
				enabled = " ",
				disabled = " ",
			},
		},
		gitbrowse = {
			notify = true, -- show notification on open
			-- Handler to open the url in a browser
			---@param url string
			open = function(url)
				if vim.fn.has("nvim-0.10") == 0 then
					require("lazy.util").open(url, { system = true })
					return
				end
				vim.ui.open(url)
			end,
			---@type "repo" | "branch" | "file" | "commit" | "permalink"
			what = "commit", -- what to open. not all remotes support all types
			branch = nil, ---@type string?
			line_start = nil, ---@type number?
			line_end = nil, ---@type number?
			-- patterns to transform remotes to an actual URL
			remote_patterns = {
				{ "^(https?://.*)%.git$", "%1" },
				{ "^git@(.+):(.+)%.git$", "https://%1/%2" },
				{ "^git@(.+):(.+)$", "https://%1/%2" },
				{ "^git@(.+)/(.+)$", "https://%1/%2" },
				{ "^org%-%d+@(.+):(.+)%.git$", "https://%1/%2" },
				{ "^ssh://git@(.*)$", "https://%1" },
				{ "^ssh://([^:/]+)(:%d+)/(.*)$", "https://%1/%3" },
				{ "^ssh://([^/]+)/(.*)$", "https://%1/%2" },
				{ "ssh%.dev%.azure%.com/v3/(.*)/(.*)$", "dev.azure.com/%1/_git/%2" },
				{ "^https://%w*@(.*)", "https://%1" },
				{ "^git@(.*)", "https://%1" },
				{ ":%d+", "" },
				{ "%.git$", "" },
			},
			url_patterns = {
				["github%.com"] = {
					branch = "/tree/{branch}",
					file = "/blob/{branch}/{file}#L{line_start}-L{line_end}",
					permalink = "/blob/{commit}/{file}#L{line_start}-L{line_end}",
					commit = "/commit/{commit}",
				},
				["gitlab%.com"] = {
					branch = "/-/tree/{branch}",
					file = "/-/blob/{branch}/{file}#L{line_start}-L{line_end}",
					permalink = "/-/blob/{commit}/{file}#L{line_start}-L{line_end}",
					commit = "/-/commit/{commit}",
				},
				["bitbucket%.org"] = {
					branch = "/src/{branch}",
					file = "/src/{branch}/{file}#lines-{line_start}-L{line_end}",
					permalink = "/src/{commit}/{file}#lines-{line_start}-L{line_end}",
					commit = "/commits/{commit}",
				},
				["git.sr.ht"] = {
					branch = "/tree/{branch}",
					file = "/tree/{branch}/item/{file}",
					permalink = "/tree/{commit}/item/{file}#L{line_start}",
					commit = "/commit/{commit}",
				},
			},
		},
		terminal = {
			enabled = false,
			bo = {
				filetype = "snacks_terminal",
			},
			wo = {},
			keys = {
				q = "hide",
				gf = function(self)
					local f = vim.fn.findfile(vim.fn.expand("<cfile>"), "**")
					if f == "" then
						Snacks.notify.warn("No file under cursor")
					else
						self:hide()
						vim.schedule(function()
							vim.cmd("e " .. f)
						end)
					end
				end,
				term_normal = {
					"<esc>",
					function(self)
						self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
						if self.esc_timer:is_active() then
							self.esc_timer:stop()
							vim.cmd("stopinsert")
						else
							self.esc_timer:start(200, 0, function() end)
							return "<esc>"
						end
					end,
					mode = "t",
					expr = true,
					desc = "Double escape to normal mode",
				},
			},
		},
		zen = {
			toggles = {
				dim = true,
			},
			enter = true,
			fixbuf = false,
			minimal = true,
			width = 10,
			height = 10,
			backdrop = { transparent = true, blend = 40 },
			keys = { q = false },
			zindex = 40,
			wo = {
				winhighlight = "NormalFloat:Normal",
			},
			w = {
				snacks_main = true,
			},
		},
		styles = {
			notication = {
				wo = {
					wrap = true,
				},
			},
		},
		input = {
			backdrop = true,
			position = "float",
			border = "double",
			title_pos = "center",
			height = 1,
			width = 60,
			relative = "editor",
			noautocmd = true,
			row = 2,
			-- relative = "cursor",
			-- row = -3,
			-- col = 0,
			wo = {
				winhighlight = "NormalFloat:SnacksInputNormal,FloatBorder:SnacksInputBorder,FloatTitle:SnacksInputTitle",
				cursorline = false,
			},
			bo = {
				filetype = "snacks_input",
				buftype = "prompt",
			},
			--- buffer local variables
			b = {
				completion = false, -- disable blink completions in input
			},
			keys = {
				n_esc = { "<esc>", { "cmp_close", "cancel" }, mode = "n", expr = true },
				i_esc = { "<esc>", { "cmp_close", "stopinsert" }, mode = "i", expr = true },
				i_cr = { "<cr>", { "cmp_accept", "confirm" }, mode = { "i", "n" }, expr = true },
				i_tab = { "<tab>", { "cmp_select_next", "cmp" }, mode = "i", expr = true },
				i_ctrl_w = { "<c-w>", "<c-s-w>", mode = "i", expr = true },
				i_up = { "<up>", { "hist_up" }, mode = { "i", "n" } },
				i_down = { "<down>", { "hist_down" }, mode = { "i", "n" } },
				q = "cancel",
			},
		},
		{
			"folke/snacks.nvim",
			---@type snacks.Config
			opts = {
				explorer = { enabled = false, replace_netrw = true },
				scroll = {},
			},
		},
		picker = {
			layout = {
				preset = "telescope",
				border = "none",
			},
			layouts = {
				default = {
					layout = {
						box = "horizontal",
						width = 0.8,
						min_width = 120,
						border = "rounded",
						height = 0.8,
						{
							box = "vertical",
							border = "none",
							title = "{title} {live} ",
							{ win = "input", height = 1, border = "bottom" },
							{ win = "list", border = "none" },
						},
						{ win = "preview", title = "{preview}", border = "left", width = 0.5 },
					},
				},
				sidebar = {
					preview = "main",
					layout = {
						backdrop = false,
						width = 30,
						min_width = 40,
						height = 0,
						position = "right",
						border = "none",
						box = "vertical",
						{
							win = "input",
							height = 1,
							border = "none",
							title = "{live} ",
							title_pos = "center",
						},
						{ win = "list", border = "none" },
						{ win = "preview", title = "{preview}", height = 0.4, border = "none" },
					},
				},
				telescope = {
					reverse = true,
					layout = {
						box = "horizontal",
						backdrop = false,
						width = 0.9,
						height = 0.9,
						border = "rounded",
						{
							box = "vertical",
							{ win = "list", title = " Results ", title_pos = "center", border = "rounded" },
							{
								win = "input",
								height = 1,
								border = "rounded",
								title = "{title} {live} ",
								title_pos = "center",
							},
						},
						{
							win = "preview",
							title = "{preview:Preview}",
							width = 0.65,
							border = "rounded",
							title_pos = "center",
						},
					},
				},
				ivy = {
					layout = {
						box = "vertical",
						backdrop = false,
						row = -1,
						width = 0,
						height = 0.4,
						border = "top",
						title = " {title} {live} ",
						title_pos = "left",
						{ win = "input", height = 1, border = "bottom" },
						{
							box = "horizontal",
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", width = 0.6, border = "left" },
						},
					},
				},
				ivy_split = {
					preview = "main",
					layout = {
						box = "vertical",
						backdrop = false,
						width = 0,
						height = 0.4,
						position = "bottom",
						border = "top",
						title = " {title} {live} ",
						title_pos = "left",
						{ win = "input", height = 1, border = "bottom" },
						{
							box = "horizontal",
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", width = 0.6, border = "left" },
						},
					},
				},
				dropdown = {
					layout = {
						backdrop = false,
						row = 1,
						width = 0.4,
						min_width = 80,
						height = 0.8,
						border = "none",
						box = "vertical",
						{ win = "preview", title = "{preview}", height = 0.4, border = "rounded" },
						{
							box = "vertical",
							border = "rounded",
							title = "{title} {live} ",
							title_pos = "center",
							{ win = "input", height = 1, border = "bottom" },
							{ win = "list", border = "none" },
						},
					},
				},
				vertical = {
					layout = {
						backdrop = false,
						width = 0.5,
						min_width = 80,
						height = 0.8,
						min_height = 30,
						box = "vertical",
						border = "rounded",
						title = "{title} {live} ",
						title_pos = "center",
						{ win = "input", height = 1, border = "bottom" },
						{ win = "list", border = "none" },
						{ win = "preview", title = "{preview}", height = 0.4, border = "top" },
					},
				},
				select = {
					preview = false,
					layout = {
						backdrop = false,
						width = 0.5,
						min_width = 80,
						height = 0.4,
						min_height = 3,
						box = "vertical",
						border = "rounded",
						title = "{title}",
						title_pos = "center",
						{ win = "input", height = 1, border = "bottom" },
						{ win = "list", border = "none" },
						{ win = "preview", title = "{preview}", height = 0.4, border = "top" },
					},
				},
				vscode = {
					preview = false,
					layout = {
						backdrop = false,
						row = 1,
						width = 0.4,
						min_width = 80,
						height = 0.8,
						border = "rounded",
						box = "vertical",
						{
							win = "input",
							height = 1,
							border = "rounded",
							title = "{title} {live} ",
							title_pos = "center",
						},
						{ win = "list", border = "hpad" },
						{ win = "preview", title = "{preview}", border = "rounded" },
					},
				},
			},
			hidden = true,
			sources = {
				files = {
					hidden = true,
				},
				explorer = {
					enabled = false,
					layout = {
						-- auto_hide = { "input" },
					},
				},
				cliphist = {
					finder = "system_cliphist",
					format = "text",
					preview = "preview",
					confirm = { "copy", "close" },
				},
			},
		},
	},
	config = function(_, opts)
		require("snacks").setup(opts)
		-- Set 5 lines for scrolling
		vim.keymap.set("n", "<C-d>", "5<C-d>", { noremap = true, silent = true })
		vim.keymap.set("n", "<C-u>", "5<C-u>", { noremap = true, silent = true })

		-- vim.api.nvim_set_hl(0, "SnacksPicker", { bg = "#11111b" })

		-- vim.o.background = "dark"

		-- non-current windows (splits, sidebars)
		-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "#11111b" })
		--
		-- -- floating UIs (pickers, popups, which-key, snacks)
		-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#11111b" })

		-- normal mode
		vim.keymap.set({ "n", "v" }, "<leader>rg", function()
			require("regex-palette").display_patterns()
		end, { desc = "Regex Palette" })

		vim.keymap.set("n", "<leader>cp", function()
			require("color-palette").show_colors()
		end, {
			desc = "Color Palette",
		})
		-- Enable dim by default
		-- Snacks.toggle.dim():set(true)
	end,
}
