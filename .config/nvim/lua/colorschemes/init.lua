
local function enableColorsceme(colorscheme)
  local status_ok, _ = pcall(require, 'colorschemes.' .. colorscheme)
  if not status_ok then
    vim.notify('Error. Can not load colorscheme "' .. colorscheme .. '"')
  end
end

return enableColorsceme
