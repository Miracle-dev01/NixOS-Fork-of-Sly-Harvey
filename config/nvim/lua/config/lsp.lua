local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")

local capabilities = vim.lsp.protocol.make_client_capabilities()
if ok then
  capabilities = cmp_lsp.default_capabilities(capabilities)
end

-- PYTHON
vim.lsp.config("pyright", {
  capabilities = capabilities,
})

-- TYPESCRIPT
vim.lsp.config("ts_ls", {
  capabilities = capabilities,
})

-- C/C++
vim.lsp.config("clangd", {
  capabilities = capabilities,
})

-- ENABLE SERVERS
vim.lsp.enable({
  "pyright",
  "ts_ls",
  "clangd",
})
