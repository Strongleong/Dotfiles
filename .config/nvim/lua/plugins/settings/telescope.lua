local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	vim.notify('Error. telescope is not installed')
	return
end

vim.api.nvim_set_hl(0, "TelescopeNormal",        {bg="none", fg="#C8D0E0"})
vim.api.nvim_set_hl(0, "TelescopePreviewNormal", {bg="none", fg="#C8D0E0"})
vim.api.nvim_set_hl(0, "TelescopePromptNormal",  {bg="none", fg="#C8D0E0"})
vim.api.nvim_set_hl(0, "TelescopeResultsNormal", {bg="none", fg="#C8D0E0"})

vim.api.nvim_set_hl(0, "TelescopeBorder",        {bg="none", fg="#81A1C1"})
vim.api.nvim_set_hl(0, "TelescopePromptBorder",  {bg="none", fg="#81A1C1"})
vim.api.nvim_set_hl(0, "TelescopeResultsBorder", {bg="none", fg="#81A1C1"})
vim.api.nvim_set_hl(0, "TelescopePreviewBorder", {bg="none", fg="#81A1C1"})

telescope.setup {
	defaults = {
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
	}
}

telescope.load_extension('fzf')
telescope.load_extension('media_files')
telescope.load_extension('dap')

