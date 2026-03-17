vim.keymap.set("n", "<leader>ss", ":SessionSave<CR>")
vim.keymap.set("n", "<leader>sl", ":SessionRestore<CR>")

return function(use)
  use({
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_restore = true,
        auto_save = true,
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_suppress_dirs = {}, 
        cwd_change_handling = {
          restore_upcoming_session = true,
          pre_cwd_changed_hook = nil,
          post_cwd_changed_hook = function()
            require("lualine").refresh()
          end,
        }
      })
    end
  })
end

