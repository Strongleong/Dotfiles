local status_ok, nightfox = pcall(require, "nightfox")
if not status_ok then
  vim.notify('Error. Nightfox colorscheme is not instaled')
  return
end

local cache_dir = vim.fn.stdpath("cache") .. "/nightfox"

-- Default options
nightfox.setup({
  options = {
    compile_path = cache_dir,          -- Compiled file's destination location
    compile_file_suffix = "_compiled", -- Compiled file suffix
    transparent = not vim.g.neovide,   -- Disable setting background
    -- transparent = true,
    terminal_colors = true,            -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
    dim_inactive = false,              -- Non focused panes set to alternative background
    styles = {                         -- Style to be applied to different syntax groups
      comments = "italic",               -- Value is any valid attr-list value `:help attr-list`
      conditionals = "NONE",
      constants = "bold",
      functions = "NONE",
      keywords = "bold",
      numbers = "NONE",
      operators = "NONE",
      strings = "NONE",
      types = "italic,bold",
      variables = "NONE",
    },
    inverse = {             -- Inverse highlight for different types
      match_paren = false,
      visual = false,
      search = false,
    },
    modules = {             -- List of various plugins and additional options
      -- ...
    },
  },
  palettes = {},
  specs = {},
  groups = {},
})

-- setup must be called before loading
vim.cmd("colorscheme nightfox")
