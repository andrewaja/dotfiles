-- Disable netrw to avoid conflicts
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Setup
require("nvim-tree").setup({
  hijack_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  respect_buf_cwd = true,
  auto_reload_on_write = true,
  view = {
    preserve_window_proportions = true,
  },
  actions = {
    open_file = {
      quit_on_open = false,
      resize_window = true,
    },
  },
})

vim.keymap.set('n', '<C-n>', ':NvimTreeFindFileToggle<CR>', { desc = "Toggle NvimTree" })

-- Flag managed by auto-session plugin, no need to shadow it
-- vim.g.auto_session_last_session_loaded will be set automatically
vim.api.nvim_create_autocmd("User", {
  pattern = "SessionLoadPost",
  callback = function()
    session_restored = true
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local is_directory = vim.fn.argv(0) == "."
    local session_restored = vim.g.auto_session_last_session_loaded == true
    local session_file = vim.fn.expand("~/.local/share/nvim/sessions/" .. vim.fn.getcwd():gsub("/", "%%") .. ".vim")

    if is_directory and not session_restored and vim.fn.filereadable(session_file) == 0 then
      require("nvim-tree.api").tree.open()
    end
  end,
})
