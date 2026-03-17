local rt = require("rust-tools")

rt.setup({
  server = {
    cmd = { "/home/drew/.cargo/bin/rust-analyzer" }, 
    on_attach = function(_, bufnr)
      local opts = { buffer = bufnr, noremap=true, silent=true }
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    end,
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = {
          command = "clippy"
        },
      }
    }
  }
})
