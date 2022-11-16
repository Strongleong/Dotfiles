local ok, surround = pcall(require, 'nvim-surround')
if not ok then
  vim.notify('Error. nvim-surround is not installed')
  return
end

surround.setup({
})
