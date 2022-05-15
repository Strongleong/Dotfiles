local status_ok, icons = pcall(require, "nvim-web-devicons")
if not status_ok then
	vim.notify("Error. nvim-web-devicons is not installed")
	return
end

icons.setup {
	default = true;
}
