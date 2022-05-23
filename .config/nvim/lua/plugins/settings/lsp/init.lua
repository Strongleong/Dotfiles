local installer, lspconfig, keymaps, cmp_nvim_lsp
local status_ok

status_ok, installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  vim.notify("Error. Nvim LSP installer is not installed")
  return
end

status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  vim.notify("Error. LSP confgiguraton is not installed")
  return
end

status_ok, keymaps = pcall(require, "keymaps")
if not status_ok then
  vim.notify("Error. keymaps.lua is not found")
  return
end

status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  vim.notify("Error. cmp_nvim_lsp is not installed")
  return
end

installer.setup({})

local config = {
  virtual_text = true,
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "single",
    source = "always",
  },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "none",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "none",
})

local capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = installer.get_installed_servers()

for _, server in pairs(servers) do
  local ok, settings = pcall(require, "plugins.settings.lsp." .. server.name)
  if not ok then
    -- vim.notify('Error. Can\'t load ' .. server.name .. ' LSP settings')
    settings = {}
  end

  lspconfig[server.name].setup({
    on_attach = keymaps.on_attach,
    capabilities = capabilities,
    settings = settings,
  })
end
