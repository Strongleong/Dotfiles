local status_ok, hop = pcall(require, "hop")
if not status_ok then
	vim.notify('Error. Hop.nvim is not installed')
	return
end

hop.setup()
