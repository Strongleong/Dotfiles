local ok, fidget = pcall(require, 'fidget')
if not ok then
  vim.notify('Error. Vidget is not installed')
  return
end

fidget.setup{}
