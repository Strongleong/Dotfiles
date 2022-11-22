local mason, masonlspconfig, lspconfig, keymaps, cmp_nvim_lsp
local status_ok

status_ok, mason = pcall(require, "mason")
if not status_ok then
  vim.notify("Error. Mason is not installed")
  return
end

status_ok, masonlspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
  vim.notify("Error. Mason-lspconfig is not installed")
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

mason.setup({})
masonlspconfig.setup({})

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

vim.cmd([[
  sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
  sign define DiagnosticSignWarn  text= texthl=DiagnosticSignWarn  linehl= numhl=
  sign define DiagnosticSignInfo  text= texthl=DiagnosticSignInfo  linehl= numhl=
  sign define DiagnosticSignHint  text= texthl=DiagnosticSignHint  linehl= numhl=
]])

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "none",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "none",
})

local capabilities = cmp_nvim_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
local servers = masonlspconfig.get_installed_servers()

for _, server in pairs(servers) do

  local ok, settings = pcall(require, "plugins.settings.lsp." .. server)
  local srv_config = {}

  if not ok then
    srv_config = {
      on_attach = keymaps.on_attach,
      capabilities = capabilities,
    }
  else
    srv_config = {
      on_attach = keymaps.on_attach,
      capabilities = capabilities,
      settings = settings,
    }
  end

  lspconfig[server].setup(srv_config)
end
