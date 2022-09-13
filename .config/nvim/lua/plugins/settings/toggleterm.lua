local ok, toggleterm = pcall(require, 'toggleterm')
if not ok then
  vim.notify('Error. Toggleterm is not installed')
  return
end

toggleterm.setup({
 size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping      = [[<Leader>t]],
  on_open = function (t)
    t:send('zsh_short_prompt')
  end,
  terminal_mappings = true,
  close_on_exit     = true,
  direction         = 'vertical',
  shade_terminals = false
})
