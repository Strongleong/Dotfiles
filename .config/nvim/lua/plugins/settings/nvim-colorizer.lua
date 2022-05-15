local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
	vim.notify('Error. Colorizer is not installed')
	return
end

colorizer.setup()
