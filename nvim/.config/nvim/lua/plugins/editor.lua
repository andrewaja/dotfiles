return {
	{ --Color Theme
		"RRethy/base16-nvim",
		lazy = false,
		priority = 1000,
		config = function() --TODO: apply get something that I like better
			vim.cmd [[colorscheme base16-onedark-dark]]
		end,
	},

	{ --Git Diffs in file editor
		"lewis6991/gitsigns.nvim",
		lazy = false,
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")
				local function map(m, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(m, l, r, opts)
				end

				map("n", "<leader>hb", function() gitsigns.blame_line({ full = true }) end)
				map("n", "<leader>hd", gitsigns.diffthis)
				map("n", "<leader>hD", function() gitsigns.diffthis("~") end)

				map("n", "<leader>tb", gitsigns.toggle_current_line_blame)
				map("n", "<leader>tw", gitsigns.toggle_word_diff)
			end
		},
	},

	{ --Better Status bar in editor
		"nvim-lualine/lualine.nvim",
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		opts = {
			options = {
				icons_enabled = true,
				theme = '16color',
				component_separators = { left = '', right = ''},
    			section_separators = { left = '', right = ''},
				disabled_filetypes = {
					statusline = {'neo-tree'},
					winbar = {'neo-tree'},
				},
				ignore_focus = {},
				always_divide_middle = true,
				always_show_tabline = true,
				globalstatus = false,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
					refresh_time = 16,
					events = {
						"WinEnter",
						"BufEnter",
						"BufWritePost",
						"SessionLoadPost",
						"FileChangedShellPost",
						"VimResized",
						"FileType",
						"CursorMoved",
						"CursorMovedI",
						"ModeChanged",
					},
				},
			},

			sections = {
				lualine_a = {'mode'},
				lualine_b = {'branch', 'diff', 'diagnostics'},
				lualine_c = {'filename'},
				lualine_x = {'encoding', 'fileformat', 'filetype'},
				lualine_y = {'location'},
				lualine_z = {"vim.api.nvim_buf_line_count(0)"},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = {'filename'},
				lualine_x = {'location'},
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		},
	},

	{ --Prettier Buffers/Tabs
		"akinsho/bufferline.nvim",
		event = "VeryLazy", --Fix for if the buffer line at the top doesn't show up
		version = "*",
		dependencies = {'nvim-tree/nvim-web-devicons'},
		keys = {
    		{"<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
			{"<leader>bl", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
			{"<M-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer"},
			{"<M-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		},
		opts = {
			options = {
				numbers = "buffer_id",
				show_close_icon = false,
				always_show_bufferline = true,
				--auto_toggle_bufferline = true,
				--separator_style = "slant",
				offsets = {
					{
						filetype = 'neo-tree',
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left"
					},
				},
			},
		}
	},

	{--Indent scoping and blanklines
		"lukas-reineke/indent-blankline.nvim",
		--event = "LazyFile", --we aren't using lazy vim, whoops
		main = 'ibl',
		opts = {
			indent = {
				char = "╎",
				tab_char = "╎",
			},
			scope = {
				--show_start = false, show_end = false
				enabled = false, --I don't have an LSP or Treesitter so
			},
			whitespace = {
				highlight = {"Whitespace", "NonText"},
			},
			exclude = {
				filetypes = {
					"Trouble",
					"trouble",
					"help",
					"lazy",
					"meson",
					"neo-tree",
					"terminal",
					"toggleterm",
				},
			},
		},
	},

	{--Better cursor tracking, and fun :)
		"sphamba/smear-cursor.nvim",
		opts = {
			smear_insert_mode = false,

			stiffness = 0.8, --fast mode
			trailing_stiffness = 0.6,
			damping = 0.95,
			distance_stop_animating = 0.5,
		},
	},

	--[[{ --doesn't work
		"kevinhwang91/nvim-hlslens",
		keys = {
			{'*', "*<cmd>lua require('hlslens').start()<cr>", noremap = true, silent = true},
			{'n', "<cmd>execute('normal! ' . v:count1 . 'n')<cr><cmd>lua require('hlslens').start()<cr>", noremap = true, silent = true},
			{'N', "<cmd>execute('normal! ' . v:count1 . 'N')<cr><cmd>lua require('hlslens').start()<cr>", noremap = true, silent = true},
		},
	}, --]]

	--[[{ --Vscode style file change tracker
		"petertriho/nvim-scrollbar",
		dependencies = {
			--"kevinhwang91/nvim-hlslens",
			"lewis6991/gitsigns.nvim",
		},
		event = "VeryLazy",
		opts = {
			excluded_filetypes = {
				"neo-tree",
				"lazy"
			},

			handlers = {
				gitsigns = true,
				--search = true,
			}
		},
	}, --]]

	{ --this also includes search results
		"lewis6991/satellite.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim"
		},
		opts = {
			current_only = false,
			excluded_filetypes = {
				"neo-tree",
				"lazy",
			},

			handlers = {
				cursor = {enable = true},
				search = {enable = true},
				diagnostic = {enable = false}, --no lsp
				gitsigns = {enable = true},
				marks = {enabled = true},
			},
		},
	},
}
