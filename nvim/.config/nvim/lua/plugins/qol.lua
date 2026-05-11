return {
	--[[{ --Helpful extra keys, might remove
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{"<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)"},
		},
	}, --]]

	--Does work, just needed most recent neovim version
	--[[{
		"rcarriga/nvim-notify",
		lazy = false,
		opts = {
			stages = "fade_in_slide_out",
			timeout = 3000,
		},
		config = function(_, opts)
			notif = require("notify")
			notif.setup(opts)

			vim.notify = notif
		end,
	}, --]]

	{ --Override the default notifications
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		opts = {
			lsp = { enabled = false }, --no lsp
			cmdline = { view = "cmdline" }, --default, cause I prefer that
		},
	}, --]]

	{
		"folke/snacks.nvim",
		priority = 1000,
		opts = {
			bigfile = {
				notify = true,
				size = 1 * 1024 * 1024,
				line_length = 1500,
			},
		},
	},

	--[[{ --Doesn't work?
		"laytan/cloak.nvim",
		opts = {
			enabled = true,
			cloak_character = "*",
			cloak_length = nil,

			highlight_group = 'Comment',

			try_all_patterns = true,
			cloak_telescope = false, --don't have it
			cloak_on_leave = true,

			patterns = {
				file_pattern = '.env*',
				cloak_pattern = "=.+",
				replace = nil,
			},
		},
	}, --]]


	--[[{ //Idk if it's very necessary
		"rachartier/tiny-glimmer.nvim",
		event = "VeryLazy",
		priority = 10,
		opts = {
			autoreload = true,
			overwrite = {
				paste = {
					enabled = false,
				},
			},
		},
	}, --]]
}
