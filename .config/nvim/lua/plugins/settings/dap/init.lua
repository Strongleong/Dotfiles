local ok, dap = pcall(require, 'dap')
if not ok then
  vim.notify('Error. Can\'t local DAP settings')
  return
end

require('plugins.settings.dap.nvim-dap-ui')
require('plugins.settings.dap.nvim-dap-virtual-text')

local cmd = "fd .lua /home/$USER/.config/nvim/lua/plugins/settings/dap/debbugers --color=never -e lua -d 1"
cmd = cmd .. " | sed -r 's/^.*\\/lua\\///' "
cmd = cmd .. " | sed 's/\\.lua//' "
cmd = cmd .. " | sed 's/\\//./g'"

local handle = io.popen(cmd)
if handle == nil then
  vim.notify('Error. Can\'t load dap settings')
  return ''
end

local debbugers = handle:read('*a')
handle:close()

for debbuger in string.gmatch(debbugers,'[^\r\n]+') do
  local settings = require(debbuger)

  if settings.adapters ~= nil then
    for name,opts in pairs(settings.adapters) do
      dap.adapters[name] = opts
    end
  end

  if settings.configurations ~= nil then
    for name,opts in pairs(settings.configurations) do
      dap.configurations[name] = opts
    end
  end
end
