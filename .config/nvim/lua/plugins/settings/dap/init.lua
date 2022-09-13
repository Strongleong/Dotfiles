local ok
local dap

ok, dap = pcall(require, 'dap.ext.vscode')
if not ok then
  vim.notify('Error. DAP is not installed')
  return
end

local dap_install
ok, dap_install = pcall(require, 'dap-install')
if not ok then
  vim.notify('Error. dap-install is not installed')
  return
end

local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

for _, debugger in ipairs(dbg_list) do
  dap_install.config(debugger)
end

dap.load_launchjs('dap.json')

require('plugins.settings.dap.nvim-dap-ui')
require('plugins.settings.dap.nvim-dap-virtual-text')

