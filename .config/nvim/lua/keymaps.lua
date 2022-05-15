local M = {}

local map = vim.keymap.set

--  Mode  Keys          Command                             Args
map('n', '<Tab>',      ':bnext<CR>',                       {silent = true, desc = 'Next buffer'})
map('n', '<S-Tab>',    ':bprevious<CR>',                   {silent = true, desc = 'Previous buffer'})
map('n', '<Leader>ve', ':tabnew ~/.config/nvim/<CR>',      {silent = true, desc = 'Quick edit of config'})

map('n', '<C-Left>',   ':vertical resize +3<CR>',          {silent = true, desc = 'Increase pane height'})
map('n', '<C-Right>',  ':vertical resize -3<CR>',          {silent = true, desc = 'Decrease pane height'})
map('n', '<C-Up>',     ':resize +3<CR>',                   {silent = true, desc = 'Increase pane width'})
map('n', '<C-Down>',   ':resize -3<CR>',                   {silent = true, desc = 'Decrease pane width'})

map('i', 'jk',         '<ESC>',                            {silent = true, desc='Exit from insert mode'})

map('v', '>',          '>gv',                              {silent = true, desc = 'Intent in visual mode vithout leaving to normal mode'})
map('v', '<',          '<gv',                              {silent = true, desc = 'Unintent in visual mode vithout leaving to normal mode'})

map('n', '<A-j>',      ':MoveLine(1)<CR>',                 {silent = true, desc = 'Move line down'})
map('n', '<A-k>',      ':MoveLine(-1)<CR>',                {silent = true, desc = 'Move line up'})
map('n', '<A-l>',      ':MoveHChar(1)<CR>',                {silent = true, desc = 'Move char right'})
map('n', '<A-h>',      ':MoveHChar(-1)<CR>',               {silent = true, desc = 'Move char left'})
map('v', '<A-j>',      ':MoveBlock(1)<CR>',                {silent = true, desc = 'Move block down'})
map('v', '<A-k>',      ':MoveBlock(-1)<CR>',               {silent = true, desc = 'Move block up'})
map('v', '<A-l>',      ':MoveHBlock(1)<CR>',               {silent = true, desc = 'Move block right'})
map('v', '<A-h>',      ':MoveHBlock(-1)<CR>',              {silent = true, desc = 'Move block left'})

map('n', 'tl',         ':TagbarToggle<CR>',                {silent = true, desc = 'Toggle Tagbar'})
map('n', 'mm',         ':MinimapToggle<CR>',               {silent = true, desc = 'Toggle Minimap'})
map('n', '<C-n>',      ':NvimTreeToggle<CR>',              {silent = true, desc = 'Generate PHP documentation'})

vim.cmd([[
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
    silent exe "normal! `[v`]\"_c"
    silent exe "normal! p"
endfunction
]])


local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
  vim.notify('Error. Telescope not found')
  return
else
  map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', {desc='Find files'})
  map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").git_files()<cr>',  {desc='Find git files'})
  map('n', '<leader>fa', '<cmd>lua require("telescope.builtin").live_grep()<cr>',  {desc='Find string'})
  map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>',    {desc='Find buffer'})
  map('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>',  {desc='Find help'})
  map('n', '<leader>fr', '<cmd>lua require("telescope.builtin").oldfiles()<cr>',   {desc='Find recent'})
end

map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', {silent=true, desc='Open floating window with diagnostic'})
map('n', '[d',       '<cmd>lua vim.diagnostic.goto_prev()<CR>',  {silent=true, desc='Goto previous diagnostic'})
map('n', ']d',       '<cmd>lua vim.diagnostic.goto_next()<CR>',  {silent=true, desc='Goto next diagnostic'})
map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', {silent=true, desc='Open diagnostics in split'})

M.on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = {silent = true}
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',           '<cmd>lua vim.lsp.buf.declaration()<CR>',                                opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',           '<cmd>lua vim.lsp.buf.definition()<CR>',                                 opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K',            '<cmd>lua vim.lsp.buf.hover()<CR>',                                      opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',           '<cmd>lua vim.lsp.buf.implementation()<CR>',                             opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space><C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',                             opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa',    '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',                       opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr',    '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',                    opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl',    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D',     '<cmd>lua vim.lsp.buf.type_definition()<CR>',                            opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn',    '<cmd>lua vim.lsp.buf.rename()<CR>',                                     opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca',    '<cmd>lua vim.lsp.buf.code_action()<CR>',                                opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',           '<cmd>lua vim.lsp.buf.references()<CR>',                                 opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f',     '<cmd>lua vim.lsp.buf.formatting()<CR>',                                 opts)
end

map('n', 't<C-n>', ':TestNearest<CR>', {silent = true, desc = 'Test nearset case'})
map('n', 't<C-f>', ':TestFile<CR>',    {silent = true, desc = 'Test file'})
map('n', 't<C-l>', ':TestLast<CR>',    {silent = true, desc = 'Test last case'})
map('n', 't<C-a>', ':TestSuite<CR>',   {silent = true, desc = 'Test suite'})
map('n', 't<C-v>', ':TestVisit<CR>',   {silent = true, desc = 'Test case under cursor'})

map({'n', 'v'}, '<Up>',    '<Nop>')
map({'n', 'v'}, '<Down>',  '<Nop>')
map({'n', 'v'}, '<Left>',  '<Nop>')
map({'n', 'v'}, '<Right>', '<Nop>')

return M
