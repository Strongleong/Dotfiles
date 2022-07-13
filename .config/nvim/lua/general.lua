vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

local path        = vim.opt.path + '**'
local clipboard   = 'unnamedplus'
local completeopt = {'menuone', 'noselect'}
local foldexpr    = 'nvim_treesitter#foldexpr()'
local undodir     = os.getenv('HOME') .. '/.nvim/undo'
local font        = 'RobotoMono Nerd Font:h11'

vim.opt.hidden         = true          -- Allow files to remain open without saving
vim.opt.number         = true          -- Line numbers
vim.opt.autoindent     = true          -- Auto indenting
vim.opt.relativenumber = true          -- Line numbers count away from current position
vim.opt.tabstop        = 2             -- Tab width
vim.opt.softtabstop    = 2             -- Soft tab width
vim.opt.shiftwidth     = 2             -- Shift width
vim.opt.expandtab      = true          -- Use spaces instead of tabs
vim.opt.path           = path          -- Searches current directory recursively.
vim.opt.clipboard      = clipboard     -- Copy/paste between vim and other programs
vim.opt.undofile       = true          -- Allow do undo even after restart
vim.opt.undodir        = undodir       -- Directory where the undo files will be stored
vim.opt.cursorline     = true          -- Hilight line cursor on
vim.opt.foldmethod     = 'expr'        -- Set foldlding method to 'expression'
vim.opt.foldlevelstart = 20            -- Make that folds don't fold on startup
vim.opt.foldexpr       = foldexpr      -- Enable Treesittier folding
vim.opt.termguicolors  = true          -- Pretty colors
vim.opt.backup         = false         -- Creates a backup file
vim.opt.cmdheight      = 1             -- No more space in the neovim command line for displaying messages
vim.opt.completeopt    = completeopt   -- Mostly just for cmp
vim.opt.conceallevel   = 0             -- So that `` is visible in markdown files
vim.opt.fileencoding   = 'utf-8'       -- the encoding written to a file
vim.opt.hlsearch       = true          -- Highlight all matches on previous search pattern
vim.opt.ignorecase     = true          -- Ignore case in search patterns
vim.opt.mouse          = 'a'           -- Allow the mouse to be used in neovim
vim.opt.pumheight      = 10            -- Pop up menu height
vim.opt.showmode       = false         -- We don't need to see things like -- INSERT -- Anymore
vim.opt.showtabline    = 1             -- Show tabs
vim.opt.smartcase      = true          -- Smart case
vim.opt.smartindent    = true          -- Make indenting smarter again
vim.opt.splitbelow     = true          -- Force all horizontal splits to go below current window
vim.opt.splitright     = true          -- Force all vertical splits to go to the right of current window
vim.opt.swapfile       = false         -- Creates a swapfile
vim.opt.timeoutlen     = 400           -- Time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime     = 300           -- Faster completion (4000ms default)
vim.opt.writebackup    = false         -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.numberwidth    = 2             -- Set number column width to 2 {default 4}
vim.opt.signcolumn     = 'yes'         -- Always show the sign column, otherwise it would shift the text each time
vim.opt.wrap           = false         -- Display lines as one long line
vim.opt.scrolloff      = 8             -- Do not wait cursor at bottom to scroll
vim.opt.sidescrolloff  = 8             -- Same as previous but horizontaly
vim.opt.guifont        = font          -- The font used in graphical neovim applications

-- Automatically strip trailing spaces on save
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*',
  command = [[:%s/\s\+$//e]]
})

-- Tmux colors fix
vim.cmd('let &t_8f = "\\<Esc>[38:2:%lu:%lu:%lum"')
vim.cmd('let &t_8b = "\\<Esc>[48:2:%lu:%lu:%lum"')
