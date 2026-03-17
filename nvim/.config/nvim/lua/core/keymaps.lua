vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.backspace = '2'
vim.opt.laststatus = 2
vim.opt.autowrite = true
vim.opt.autoread = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.shiftround = true
vim.opt.expandtab = true

vim.wo.number = true
vim.opt.relativenumber = true

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.keymap.set('v', '<leader>y', '"+y')

-- LSP go-to-definition
vim.keymap.set("n", "gd", function()
  require("telescope.builtin").lsp_definitions()
end, { silent = true })

-- Jump BACK
vim.keymap.set("n", "<leader>b", "<C-o>", { silent = true })
vim.keymap.set("n", "<leader>f", "<C-i>", { silent = true }) -- forward
