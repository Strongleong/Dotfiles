-- Bootstrap packer if its not exists
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

vim.api.nvim_create_augroup('PackerUserConfig', { clear = false })
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'install.lua',
  desc    = 'Reload neovim on plugins.lua save',
  command = 'source <afile> | PackerSync',
  group   = 'PackerUserConfig'
})

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  vim.notify('Installing Packer')
end

return packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'nvim-lua/plenary.nvim'
  use 'nvim-lua/popup.nvim'

  use 'RRethy/nvim-align'
  use 'famiu/bufdelete.nvim'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'alexghergh/nvim-tmux-navigation'
  use 'lyokha/vim-xkbswitch'
  use 'goolord/alpha-nvim'
  use 'BlakeJC94/alpha-nvim-fortune'
  use { 'phaazon/hop.nvim', branch = 'v1' }

  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-telescope/telescope-media-files.nvim'

  use 'nvim-lualine/lualine.nvim'

  use 'kyazdani42/nvim-tree.lua'
  use 'kyazdani42/nvim-web-devicons'

  use 'vifm/vifm.vim'

  use 'preservim/tagbar'
  use 'fedepujol/move.nvim'

  use 'norcalli/nvim-colorizer.lua'
  use 'ten3roberts/qf.nvim'

  -- Colorchemes
  use 'rmehri01/onenord.nvim'

  -- CMP plugins
  use 'hrsh7th/nvim-cmp'          -- The completion plugin
  use 'hrsh7th/cmp-nvim-lsp'      -- Lsp completions
  use 'hrsh7th/cmp-buffer'        -- Buffer completions
  use 'hrsh7th/cmp-path'          -- Path completions
  use 'hrsh7th/cmp-cmdline'       -- Cmdline completions
  use 'hrsh7th/cmp-nvim-lua'      -- Lua nvim api completions
  use 'hrsh7th/cmp-emoji'         -- Markdown emoji completions
  use 'saadparwaiz1/cmp_luasnip'  -- Snippet completions

  -- LSP
  use 'williamboman/nvim-lsp-installer'
  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim' -- For formatters and linters

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

  -- Snippets
  use 'L3MON4D3/LuaSnip'
  use 'mattn/emmet-vim'
  use 'rafamadriz/friendly-snippets'

  use 'TimUntersberger/neogit'
  use 'tpope/vim-fugitive'
  use 'sindrets/diffview.nvim'
  use 'lewis6991/gitsigns.nvim'

  -- Testing
  use 'janko-m/vim-test'

  -- Debuging
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'rcarriga/cmp-dap'
  use 'ibhagwan/fzf-lua'
  use 'nvim-telescope/telescope-dap.nvim'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'Pocco81/dap-buddy.nvim'


  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

