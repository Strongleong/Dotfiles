local status_ok, tmux = pcall(require, "nvim-tmux-navigation")
if not status_ok then
	vim.notify('Error. nvim-tmux-navigation is not installed')
	return
end

tmux.setup {
	disable_when_zoomed = true -- defaults to false
}
