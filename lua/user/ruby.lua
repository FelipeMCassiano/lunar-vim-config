lvim.lang.ruby.lsp.setup.cmd = { "solargraph", "stdio" }
lvim.lang.ruby.lsp.setup.on_attach = function(client, bufnr)
    require("lsp").on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end
