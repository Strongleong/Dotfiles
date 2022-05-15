local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	vim.notify('Error. telescope is not installed')
	return
end

telescope.load_extension('fzf')
telescope.load_extension('media_files')
