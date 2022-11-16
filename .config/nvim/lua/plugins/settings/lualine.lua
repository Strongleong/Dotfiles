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
		icons_enabled = true,
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { kb_layout, "branch", "diff" },
		lualine_c = {
			{
				"buffers",
				symbols = {
					modified = ' ●',
					alternate_file = '',
					directory = '',
				},
			},

		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location", "diagnostics" },
	},
	tabline = {},
	extensions = {
		"nvim-tree",
		minimap_exstension,
	},
})
