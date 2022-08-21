require('plugins.install')

local debbugersPath = vim.fn.stdpath('config') .. '/lua/plugins/settings'
for _, file in ipairs(vim.fn.readdir(debbugersPath, [[v:val =~ '\.lua$']])) do
  local ok, error = pcall(require, 'plugins.settings.' .. file:gsub('%.lua$', ''))
  if not ok then
    vim.notify('Error. could not load file ' .. debbugersPath .. file .. ': ' .. error)
  end
end

local ok, error = pcall(require, 'plugins.settings.lsp')
if not ok then
  vim.notify('Error. Can\'t load LSP settings: ' .. error)
end

ok, error = pcall(require, 'plugins.settings.dap.init')
if not ok then
  vim.notify('Error. Can\'t load DAP settings: ' .. error)
end
