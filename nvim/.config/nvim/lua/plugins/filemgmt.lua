return {
	{ --vscode style side-bar workspace viewer
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
    		"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{"<leader>gs", "<cmd>Neotree float git_status<cr>", desc = "Open Git Status in floating pane"},
			{"<leader>.", "<cmd>Neotree toggle left<cr>", desc = "Toggle Neo-tree in the side bar"},
			{"<leader>e", "<cmd>vsplit<cr><cmd>Neotree current<cr>", desc = "Open a vertical split with Neo-tree ready"},
			{"<leader>E",  "<cmd>split<cr><cmd>Neotree current<cr>", desc = "Open a horizontal split with Neo-tree ready"},
		},
		opts = {
			close_if_last_window = true,
			clipboard = {sync = "global"},
			--sources = {"filesystem", "buffers", "git_status"},
			enable_git_status = true,
			--enable_diagnostics = true,
			open_files_using_relative_paths = true,
			use_libuv_file_watcher = true,

			open_files_do_not_replace_types = {
				"term",
				"terminal",
				"Trouble",
				"trouble",
				"qf",
				"Outline"
			},

			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_ignored = false,
					hide_hidden = false,
					never_show = { ".git" },  --chat we want to avoid interacting with ti
				},
				follow_current_file = {enabled = true},
				bind_to_cwd = true,
			},

			default_component_configs = {
				git_status = {
					symbols = { --similar to vscode
						--Change Tracking
						added = "+",
						modified = "M",
						renamed = "R",
						--Git Tracking
						untracked = "U",
						ignored = "I",
						unstaged = "_",
						staged = "S",
						conflict = "!",
					},
				},
			},

			window = {
				mappings = {
					["t"] = "noop", --since i don't use tabs, but buffers instead
				},
			},
		},
	},

	--[[ I don't think it works with neositter
	{ --workspace finder
		"ahmedkhalf/project.nvim",
		event = "VeryLazy",
		config = function(_, opts)
			require('project_nvim').setup{
				detection_methods = {"pattern"},
				patterns = {".git", "Makefile"},
			}

		end,
	}, --]]
}
