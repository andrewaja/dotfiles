--Standard
vim.g.mapleader = " "

--NetRW Configs
--vim.g.netrw_banner = 0
--vim.g.netrw_browse_split = 4
--vim.g.netrw_altv = 1
--vim.g.netrw_liststyle = 3

--Options
vim.opt.syntax = "ON"
vim.opt.backup = false
vim.opt.compatible = false
vim.opt.number = true
--vim.opt.relativenumber = false --for now I don't enjoy this
--vim.opt.mouse = 'a' --annoying
vim.opt.showbreak = "> "
--vim.opt.showtabline = 1

vim.opt.tabstop = 4 --spaces
vim.opt.shiftwidth = 4

vim.opt.fileencoding = "utf-8"
vim.opt.pumheight = 5
--vim.opt.showtabline = 2
--vim.opt.laststatus = 2
--vim.opt.showcmd = true
--vim.opt.showmode = true
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 1
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.cmdheight = 0
--vim.cmd('colorscheme koehler')
--vim.cmd('filetype plugin on')
--vim.cmd('set wildmenu')

--Remove trailing whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	command = [[%s/\s\+$//e]],
})

--Highlight what ever you are yanking
local yank_group = vim.api.nvim_create_augroup('HighlightYank', {})
vim.api.nvim_create_autocmd({ "TextYankPost" }, { --Shamelessly stolen from ThePrimeagen's dotfiles
	group = yank_group,
	pattern = { "*" },
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 50,
		})
	end
})

function map(mode, lhs, rhs, opts)
	local options = {noremap = true}
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function unmap(mode, lhs)
	local status, err = pcall(vim.api.nvim_del_keymap(mode, lhs))
	if not status then
		print("Could not unmap " .. mode .. " " .. lhs .. ": " .. err)
	end
	return status
end

--Normal Section
---Leader
--map("n", "<leader>dot", ":!make -C ~/dotfiles<CR>");
--map("n", "<leader>r", ":source ~/.config/nvim/init.lua<CR>") --reload nvim init
--map("n", "<leader>e", ":vnew .<CR>") --split window and open netrw
--map("n", "<leader>E", ":new .<CR>") --split window horizontal and open netrw
--map("n", "<leader>.", ":e .<CR>") --find a new location
map("n", "<leader>t", "<cmd>split<cr><cmd>term<cr><C-w>J<cmd>resize 15<cr>") --Create VSCode style terminal
map("n", "<leader>p", "\"+p"); --pasting from system clipboard
--map("n", "<leader><leader>", "@@") --repeat a saved method
---Else

--Old tab management, switching to buffers with bufferline.nvim
--map('n', '<M-l>', ":tabn<CR>");
--map('n', '<M-h>', ":tabp<CR>");
--map('n', '<M-w>', ":tabnew .<CR>");
map("n", "<esc>", ":noh<cr>")

--unmap("n", "J") --join, but that's annoying
map("n", "J", "Lzz")

--unmap("n", "K") --on unix it's mapped to 'man', but idc
map("n", "K", "Hzz")

map("v", "<leader>/", "y/<C-r>\"<CR>");
map("v", "<leader>y", "\"+y");

--Insert Section
--map("i", "jk", "<esc>")

--Terminal Section
map("t", "<ESC>", "<C-\\><C-n>");
map("t", "<esc>", "<C-\\><C-n>");

require("config.lazy");
map('n', '<leader>l', '<cmd>Lazy<cr>');
