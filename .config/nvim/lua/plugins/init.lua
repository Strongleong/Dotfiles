require('plugins.install')

local cmd = "fd .lua /home/$USER/.config/nvim/lua/plugins/settings --color=never -e lua -d 1"
cmd = cmd .. " | sed -r 's/^.*\\/lua\\///' "
cmd = cmd .. " | sed 's/\\.lua//' "
cmd = cmd .. " | sed 's/\\//./g'"

local handle = io.popen(cmd)
if handle == nil then
  vim.notify('Error. Can\'t load plugins settings')
  return ''
end

local plugins = handle:read('*a')
handle:close()

for plugin in string.gmatch(plugins,'[^\r\n]+') do
  local ok, error = pcall(require, plugin)
  if not ok then
    vim.notify(error)
  end
end

local ok, _ = pcall(require, 'plugins.settings.lsp')
if not ok then
  vim.notify('Error. Can\'t load LSP settings')
end

ok, _ = pcall(require, 'plugins.settings.dap')
if not ok then
  vim.notify('Error. Can\'t load DAP settings')
end
