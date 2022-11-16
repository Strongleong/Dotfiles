local M = {}

local function map(mode, keys, command, description, additional)
  local options = { silent = true }
  local opts
  local bufnr

  if description ~= nil then
    options.desc = description
  end

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

local function adjust_font_size(amount)
  local font_full = vim.api.nvim_get_option('guifont')
  local font, size = string.match(font_full, "(.*):h(.*)")
  size = size + amount
  vim.opt.guifont = font .. ":h" .. size
end

local function increment_font_size()
  adjust_font_size(1)
end

local function decrement_font_size()
  adjust_font_size(-1)
end

map(  'n', '<Tab>',      ':bnext<CR>',                  '[Buffer] Next buffer')
map(  'n', '<S-Tab>',    ':bprevious<CR>',              '[Buffer] Previous buffer')

map(  'n', '<Leader>ve', ':tabnew ~/.config/nvim/<CR>', '[Config] Quick edit of config')

map(  'n', '<C-Left>',   ':vertical resize +3<CR>',     '[Resize] Increase pane height')
map(  'n', '<C-Right>',  ':vertical resize -3<CR>',     '[Resize] Decrease pane height')
map(  'n', '<C-Up>',     ':resize +3<CR>',              '[Resize] Increase pane width')
map(  'n', '<C-Down>',   ':resize -3<CR>',              '[Resize] Decrease pane width')

map(  'v', '>',          '>gv',                         '[Indent] Indent in visual mode vithout leaving to normal mode')
map(  'v', '<',          '<gv',                         '[Indent] Unindent in visual mode vithout leaving to normal mode')

map(  'n', '-',          decrement_font_size,           '[GUI] Increase font size')
map(  'n', '+',          increment_font_size,           '[GUI] Decrease font size')
map(  'i', '<C-->',      decrement_font_size,           '[GUI] Increase font size')
map(  'i', '<C-+>',      increment_font_size,           '[GUI] Decrease font size')




-- Snitch

local ok, snitch = pcall(require, "custom.snitch")
if ok then
  map('n', '<leader>s', snitch, '[Snitch] Get all TODO\'s')
end


local status_ok, tmux = pcall(require, "nvim-tmux-navigation")
if status_ok then
  map('n', '<C-h>',     tmux.NvimTmuxNavigateLeft,       '[Navigation] Move focus left' )
  map('n', '<C-j>',     tmux.NvimTmuxNavigateDown,       '[Navigation] Move focus down' )
  map('n', '<C-k>',     tmux.NvimTmuxNavigateUp,         '[Navigation] Move focus up' )
  map('n', '<C-l>',     tmux.NvimTmuxNavigateRight,      '[Navigation] Move focus Right' )
  map('n', '<C-\\>',    tmux.NvimTmuxNavigateLastActive, '[Navigation] Move focus last active' )
  map('n', '<C-Space>', tmux.NvimTmuxNavigateNext,       '[Navigation] Move focus next' )
else
  vim.notify('Error. nvim-tmux-navigation is not installed')
end

map(  'n', '<A-j>', ':MoveLine(1)<CR>',    '[Move] Move line down')
map(  'n', '<A-k>', ':MoveLine(-1)<CR>',   '[Move] Move line up')
map(  'n', '<A-l>', ':MoveHChar(1)<CR>',   '[Move] Move char right')
map(  'n', '<A-h>', ':MoveHChar(-1)<CR>',  '[Move] Move char left')
map(  'v', '<A-j>', ':MoveBlock(1)<CR>',   '[Move] Move block down')
map(  'v', '<A-k>', ':MoveBlock(-1)<CR>',  '[Move] Move block up')
map(  'v', '<A-l>', ':MoveHBlock(1)<CR>',  '[Move] Move block right')
map(  'v', '<A-h>', ':MoveHBlock(-1)<CR>', '[Move] Move block left')

map(  'n', '<leader>g', ':Neogit<CR>',                 '[Neogit] Open Neogit')
map(  'n', 'tl',        ':TagbarToggle<CR>',           '[Tagbar] Toggle Tagbar')
map(  'n', 'mm',        ':MinimapToggle<CR>',          '[Minimap] Toggle Minimap')
map(  'n', '<C-n>',     ':NvimTreeFindFileToggle<CR>', '[NvimTree] Toggle NvimTree')

status_ok, _ = pcall(require, 'telescope')
if status_ok then
  map('n', '<leader>ff',      '<cmd>lua require("telescope.builtin").find_files()<cr>', '[Telescope] Find files')
  map('n', '<leader>fg',      '<cmd>lua require("telescope.builtin").git_files()<cr>',  '[Telescope] Find git files')
  map('n', '<leader>fa',      '<cmd>lua require("telescope.builtin").live_grep()<cr>',  '[Telescope] Find string')
  map('n', '<leader>fb',      '<cmd>lua require("telescope.builtin").buffers()<cr>',    '[Telescope] Find buffer')
  map('n', '<leader>fh',      '<cmd>lua require("telescope.builtin").help_tags()<cr>',  '[Telescope] Find help')
  map('n', '<leader>fr',      '<cmd>lua require("telescope.builtin").oldfiles()<cr>',   '[Telescope] Find recent')
else
  vim.notify('Error. Telescope not found')
end

map('n', '<space>gh', '<cmd>Lspsaga lsp_finder<CR>',              '[LSP] Open finder')
map('n', '<space>e',  '<cmd>lua vim.diagnostic.open_float()<CR>', '[LSP] Open floating window with diagnostic')
map('n', '[d',        '<cmd>Lspsaga diagnostic_jump_prev<CR>',    '[LSP] Goto previous diagnostic')
map('n', ']d',        '<cmd>Lspsaga diagnostic_jump_next<CR>',    '[LSP] Goto next diagnostic')

-- Only jump to error

map("n", "[D", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end,     '[LSP] Jump to previous error')
map("n", "]D", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end,     '[LSP] Jump to next error')

map('n', 'K',            '<cmd>Lspsaga hover_doc<CR>',                                            '[LSP] Open hover window'       )
map('n', 'gp',           '<cmd>Lspsaga peek_definition<CR>',                                      '[LSP] Peek definition'         )
map('n', 'gd',           '<cmd>lua vim.lsp.buf.definition()<CR>',                                 '[LSP] Go to definition'        )
map('n', 'gD',           '<cmd>lua vim.lsp.buf.declaration()<CR>',                                '[LSP] Go to declaration'       )
map('n', 'gi',           '<cmd>lua vim.lsp.buf.implementation()<CR>',                             '[LSP] Go to implementation'    )
map('n', 'gr',           '<cmd>lua vim.lsp.buf.references()<CR>',                                 '[LSP] Find all references'     )
map('n', '<space>o',     '<cmd>LSoutlineToggle<CR>',                                              '[LSP] Open outline'            )
map('n', '<space><C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>',                             '[LSP] Signature help'          )
map('n', '<space>wa',    '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',                       '[LSP] Add workspace folder'    )
map('n', '<space>wr',    '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',                    '[LSP] Remove workspace folder' )
map('n', '<space>wl',    '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', '[LSP] List workspace folders'  )
map('n', '<space>D',     '<cmd>lua vim.lsp.buf.type_definition()<CR>',                            '[LSP] Open type definition'    )
map('n', '<space>rn',    '<cmd>Lspsaga rename<CR>"',                                              '[LSP] Rename selected element' )
map('n', '<space>ca',    '<cmd>Lspsaga code_action<CR>',                                          '[LSP] Open code action pop-up' )
map('n', '<space>f',     '<cmd>lua vim.lsp.buf.format({ async = true})<CR>',                      '[LSP] Format buffer'           )

map(  'n', 't<C-n>', ':TestNearest<CR>', '[VimTest] Test nearset case')
map(  'n', 't<C-f>', ':TestFile<CR>',    '[VimTest] Test file')
map(  'n', 't<C-l>', ':TestLast<CR>',    '[VimTest] Test last case')
map(  'n', 't<C-a>', ':TestSuite<CR>',   '[VimTest] Test suite')
map(  'n', 't<C-v>', ':TestVisit<CR>',   '[VimTest] Test case under cursor')

map(  'n', '<leader>lo', '<cmd>lua require"qf".open("l")<CR>',        '[QuicFix] Open location list')
map(  'n', '<leader>lc', '<cmd>lua require"qf".close("l")<CR>',       '[QuicFix] Close location list')
map(  'n', '<leader>ll', '<cmd>lua require"qf".toggle("l",true)<CR>', '[QuicFix] Toggle location list and stay in current window')
map(  'n', '<leader>co', '<cmd>lua require"qf".open("c")<CR>',        '[QuicFix] Open quickfix list')
map(  'n', '<leader>cc', '<cmd>lua require"qf".close("c")<CR>',       '[QuicFix] Close quickfix list')
map(  'n', '<leader>cl', '<cmd>lua require"qf".toggle("c",true)<CR>', '[QuicFix] Toggle quickfix list and stay in current window')
map(  'n', '<leader>j',  '<cmd>lua require"qf".below("l")<CR>',       '[QuicFix] Go to next location list entry from cursor')
map(  'n', '<leader>k',  '<cmd>lua require"qf".above("l")<CR>',       '[QuicFix] Go to previous location list entry from cursor')
map(  'n', '<leader>J',  '<cmd>lua require"qf".below("c")<CR>',       '[QuicFix] Go to next quickfix entry from cursor')
map(  'n', '<leader>K',  '<cmd>lua require"qf".above("c")<CR>',       '[QuicFix] Go to previous quickfix entry from cursor')
map(  'n', ']q',         '<cmd>lua require"qf".below("visible")<CR>', '[QuicFix] Go to next entry from cursor in visible list')
map(  'n', '[q',         '<cmd>lua require"qf".above("visible")<CR>', '[QuicFix] Go to previous entry from cursor in visible list')

local dap
status_ok, dap = pcall(require, 'dap')
if status_ok then
  local function set_cond_breakpoint()
    dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
  end

  local function set_log_point()
    dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
  end

  map('n', '<F5>',       dap.continue,          '[DAP] Continue')
  map('n', '<F10>',      dap.step_over,         '[DAP] Step over')
  map('n', '<F11>',      dap.step_into,         '[DAP] Step into')
  map('n', '<F12>',      dap.step_out,          '[DAP] Step out')
  map('n', '<F9>',       dap.toggle_breakpoint, '[DAP] Toggle breakpoint')
  map('n', '<Leader>B',  set_cond_breakpoint,   '[DAP] Set conditional breakpoint')
  map('n', '<Leader>lp', set_log_point,         '[DAP] Set log point')
  map('n', '<Leader>dr', dap.repl.open,         '[DAP] Open repl')
  map('n', '<Leader>dl', dap.run_last,          '[DAP] Run last')
else
  vim.notify('Error. DAP not found')
end

-- Hop.nvim
map('', 'f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR,  current_line_only = true })<cr>", '[HOP] Jump to symbol')
map('', 'F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", '[HOP] Jump back to symbol')
map('', 't', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR,  current_line_only = true, hint_offset = -1 })<cr>", '[HOP] Jump before symbol')
map('', 'T', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 })<cr>", '[HOP] Jump back before symbol')

map('', '<leader>e', "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", '[HOP] Jump to word')

-- EasyAlign
map('x', 'ga', '<Plug>(EasyAlign)', '[EasyAlign] Start interactive EasyAlign in visual mode')
map('n', 'ga', '<Plug>(EasyAlign)', '[EasyAlign] Start interactive EasyAlign for a motion/text object')


-- ToggleTerm
function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  map('t', '<C-h>', [[<Cmd>wincmd h<CR>]], '[ToggleTerm] Go to left pane',  opts)
  map('t', '<C-j>', [[<Cmd>wincmd j<CR>]], '[ToggleTerm] Go to down pane',  opts)
  map('t', '<C-k>', [[<Cmd>wincmd k<CR>]], '[ToggleTerm] Go to up pane',    opts)
  map('t', '<C-l>', [[<Cmd>wincmd l<CR>]], '[ToggleTerm] Go to right pane', opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')


-- Hard mode :D
map({'n', 'v'}, '<Up>',    '<Nop>', '[Hard mode :D] Disable UP key')
map({'n', 'v'}, '<Down>',  '<Nop>', '[Hard mode :D] Disable DOWN key')
map({'n', 'v'}, '<Left>',  '<Nop>', '[Hard mode :D] Disable LEFT key')
map({'n', 'v'}, '<Right>', '<Nop>', '[Hard mode :D] Disable RIGHT key')

-- CP command
vim.cmd([[
nmap <silent> cp :set opfunc=ChangePaste<CR>g@
function! ChangePaste(type, ...)
    silent exe "normal! `[v`]\"_c"
    silent exe "normal! p"
endfunction
]])

return M
