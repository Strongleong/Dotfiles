local ok
local dap
ok, dap = pcall(require, 'dap')
if not ok then
  vim.notify('Error. Can\'t local DAP settings')
  return
end

require('plugins.settings.dap.nvim-dap-ui')
require('plugins.settings.dap.nvim-dap-virtual-text')

local debbugersPath = vim.fn.stdpath('config') .. '/lua/plugins/settings/dap/debbugers/'
for _, file in ipairs(vim.fn.readdir(debbugersPath, [[v:val =~ '\.lua$']])) do
  local settings
  ok, settings = pcall(require, 'plugins.settings.dap.debbugers.' .. file:gsub('%.lua$', ''))
  if not ok then
    vim.notify('Error. could not load file ' .. debbugersPath .. file)
  end


  if settings.adapters ~= nil then
    for name, opts in pairs(settings.adapters) do
      dap.adapters[name] = opts
    end
  end

  if settings.configurations ~= nil then
    for name, opts in pairs(settings.configurations) do
      dap.configurations[name] = opts
    end
  end
end
