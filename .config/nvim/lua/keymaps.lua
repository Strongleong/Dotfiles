local M = {}

local function map(mode, keys, command, description, additional)
  local options = { silent = true, desc = description }
  local opts
  local bufnr

  if additional ~= nil then
    opts = additional.opts or {}
    bufnr = additional.bufnr or nil

    for k,v in pairs(opts) do options[k] = v end
  else
    opts = {}
    bufnr = nil
  end


  if bufnr == nil then
    vim.keymap.set(mode, keys, command, options)
  else
    vim.api.nvim_buf_set_keymap(bufnr, mode, keys, command, options)
  end
end

--  Mode  Keys          Command                             Desc
map('n', '<Tab>',      ':bnext<CR>',                       'Next buffer')
map('n', '<S-Tab>',    ':bprevious<CR>',                   'Previous buffer')
map('n', '<Leader>ve', ':tabnew ~/.config/nvim/<CR>',      'Quick edit of config')

map('n', '<C-Left>',   ':vertical resize +3<CR>',          'Increase pane height')
map('n', '<C-Right>',  ':vertical resize -3<CR>',          'Decrease pane height')
map('n', '<C-Up>',     ':resize +3<CR>',                   'Increase pane width')
map('n', '<C-Down>',   ':resize -3<CR>',                   'Decrease pane width')

map('i', 'jk',         '<ESC>',                            'Exit from insert mode')

map('v', '>',          '>gv',                              'Intent in visual mode vithout leaving to normal mode')
map('v', '<',          '<gv',                              'Unintent in visual mode vithout leaving to normal mode')

local status_ok, tmux = pcall(require, "nvim-tmux-navigation")
if status_ok then
  map('n', "<C-h>",     tmux.NvimTmuxNavigateLeft,           'Move left' )
  map('n', "<C-j>",     tmux.NvimTmuxNavigateDown,           'Move down' )
  map('n', "<C-k>",     tmux.NvimTmuxNavigateUp,             'Move up' )
  map('n', "<C-l>",     tmux.NvimTmuxNavigateRight,          'Move Right' )
  map('n', "<C-\\>",    tmux.NvimTmuxNavigateLastActive,     'Move last active' )
  map('n', "<C-Space>", tmux.NvimTmuxNavigateNext,           'Move next' )
else
  vim.notify('Error. nvim-tmux-navigation is not installed')
end

map('n', '<A-j>',      ':MoveLine(1)<CR>',                 'Move line down')
map('n', '<A-k>',      ':MoveLine(-1)<CR>',                'Move line up')
map('n', '<A-l>',      ':MoveHChar(1)<CR>',                'Move char right')
map('n', '<A-h>',      ':MoveHChar(-1)<CR>',               'Move char left')
map('v', '<A-j>',      ':MoveBlock(1)<CR>',                'Move block down')
map('v', '<A-k>',      ':MoveBlock(-1)<CR>',               'Move block up')
map('v', '<A-l>',      ':MoveHBlock(1)<CR>',               'Move block right')
map('v', '<A-h>',      ':MoveHBlock(-1)<CR>',              'Move block left')

map('n', 'tl',         ':TagbarToggle<CR>',                'Toggle Tagbar')
map('n', 'mm',         ':MinimapToggle<CR>',               'Toggle Minimap')
map('n', '<C-n>',      ':NvimTreeToggle<CR>',              'Generate PHP documentation')

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
  map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<cr>', 'Find files')
  map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").git_files()<cr>',  'Find git files')
  map('n', '<leader>fa', '<cmd>lua require("telescope.builtin").live_grep()<cr>',  'Find string')
  map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<cr>',    'Find buffer')
  map('n', '<leader>fh', '<cmd>lua require("telescope.builtin").help_tags()<cr>',  'Find help')
  map('n', '<leader>fr', '<cmd>lua require("telescope.builtin").oldfiles()<cr>',   'Find recent')
end

map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', 'Open floating window with diagnostic')
map('n', '[d',       '<cmd>lua vim.diagnostic.goto_prev()<CR>',  'Goto previous diagnostic')
map('n', ']d',       '<cmd>lua vim.diagnostic.goto_next()<CR>',  'Goto next diagnostic')
map('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', 'Open diagnostics in split')

M.on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  map('n', 'gD',           '<cmd>lua vim.lsp.buf.declaration()<CR>',                                '', {bufnr})
  map('n', 'gd',           '<cmd>lua vim.lsp.buf.definition()<CR>',                                 '', {bufnr})
  map('n', 'K',            '<cmd>lua vim.lsp.buf.hover()<CR>',                                      '', {bufnr})
  map('n', 'gi',           '<cmd>lua vim.lsp.buf.implementation()<CR>',                             '', {bufnr})
  map('n', '<space><C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',                             '', {bufnr})
  map('n', '<space>wa',    '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',                       '', {bufnr})
  map('n', '<space>wr',    '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',                    '', {bufnr})
  map('n', '<space>wl',    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', '', {bufnr})
  map('n', '<space>D',     '<cmd>lua vim.lsp.buf.type_definition()<CR>',                            '', {bufnr})
  map('n', '<space>rn',    '<cmd>lua vim.lsp.buf.rename()<CR>',                                     '', {bufnr})
  map('n', '<space>ca',    '<cmd>lua vim.lsp.buf.code_action()<CR>',                                '', {bufnr})
  map('n', 'gr',           '<cmd>lua vim.lsp.buf.references()<CR>',                                 '', {bufnr})
  map('n', '<space>f',     '<cmd>lua vim.lsp.buf.formatting()<CR>',                                 '', {bufnr})
end

map('n', 't<C-n>', ':TestNearest<CR>', 'Test nearset case')
map('n', 't<C-f>', ':TestFile<CR>',    'Test file')
map('n', 't<C-l>', ':TestLast<CR>',    'Test last case')
map('n', 't<C-a>', ':TestSuite<CR>',   'Test suite')
map('n', 't<C-v>', ':TestVisit<CR>',   'Test case under cursor')

map('n', '<leader>g', ':Neogit<CR>', 'Open Neogit')

-- Hard mode :D
map({'n', 'v'}, '<Up>',    '<Nop>')
map({'n', 'v'}, '<Down>',  '<Nop>')
map({'n', 'v'}, '<Left>',  '<Nop>')
map({'n', 'v'}, '<Right>', '<Nop>')

return M
