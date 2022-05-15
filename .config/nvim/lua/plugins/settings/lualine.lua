local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  vim.notify('Error. Lualine is not installed')
	return
end

local function minimap()
	return "Minimap"
end

local minimap_exstension = {
	sections = { lualine_a = { minimap } },
	filetypes = { "minimap" },
}

local function kb_layout()
  return vim.api.nvim_eval("libcall(g:XkbSwitchLib, 'Xkb_Switch_getXkbLayout', '')")
end

lualine.setup({
	options = {
		theme = "onenord",
		icons_enabled = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {},
		always_divide_middle = true,
		globalstatus = false,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { kb_layout, "branch", "diff" },
		lualine_c = { "buffers" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location", "diagnostics" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {
		"nvim-tree",
		minimap_exstension,
	},
})
