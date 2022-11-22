local cmp_status_ok, neogit = pcall(require, "neogit")
if not cmp_status_ok then
	vim.notify("Error. Neogit is not installed")
	return
end

neogit.setup({
	disable_signs = false,
	disable_hint = false,
	disable_context_highlighting = false,
	disable_commit_confirmation = false,
	auto_refresh = true,
	disable_builtin_notifications = false,
	use_magit_keybindings = false,
	commit_popup = {
		kind = "split",
	},
	kind = "tab",
	signs = {
		section = { ">", "v" },
		item = { ">", "v" },
		hunk = { ">", "v" },
	},
	integrations = {
		diffview = true,
	},
	sections = {
		untracked = {
			folded = false,
		},
		unstaged = {
			folded = false,
		},
		staged = {
			folded = false,
		},
		stashes = {
			folded = true,
		},
		unpulled = {
			folded = true,
		},
		unmerged = {
			folded = false,
		},
		recent = {
			folded = true,
		},
	},
	mappings = {
		["B"] = "BranchPopup",
	},
})
