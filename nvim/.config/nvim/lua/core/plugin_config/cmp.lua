local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
        elseif require("luasnip").expand_or_jumpable() then
            require("luasnip").expand_or_jump()
        else
            fallback()
        end
    end, { "i", "s" }),

    ['<CR>'] = cmp.mapping(function(fallback)
        if cmp.visible() and cmp.get_selected_entry() then
            cmp.confirm({ select = true })
        else
            fallback()
        end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim-lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig").rust_analyzer.setup {
  capabilities = capabilities
}

require("lspconfig").pyright.setup {
  capabilities = capabilities
}

require("lspconfig").clangd.setup {
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--query-driver=/usr/bin/g++,/usr/bin/*-g++,/usr/bin/clang++,/usr/bin/*-clang++",
  },
}

function ToggleNoDiagnostics()
  vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = false
  })
end

