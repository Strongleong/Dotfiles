local status_ok, comment, commentstring

status_ok, comment = pcall(require, "Comment")
if not status_ok then
	vim.notify('Error. Comment is not installed')
	return
end

status_ok, commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
if not status_ok then
	vim.notify('Error. commentstring is not installed')
	return
end

comment.setup(
	{
		padding = true,     -- Add a space b/w comment and the line
		sticky = true,      -- Whether the cursor should stay at its position
		ignore = nil,       -- Lines to be ignored while (un)comment
		toggler = {         -- LHS of toggle mappings in NORMAL mode
			line = 'gcc',     -- Line-comment toggle keymap
			block = 'gbc',    -- Block-comment toggle keymap
		},
		opleader = {        -- LHS of operator-pending mappings in NORMAL and VISUAL mode
			line = 'gc',      -- Line-comment keymap
			block = 'gb',     -- Block-comment keymap
		},
		extra = {           -- LHS of extra mappings
			above = 'gcO',    -- Add comment on the line above
			below = 'gco',    -- Add comment on the line below
			eol = 'gcA',      -- Add comment at the end of line
		},
		mappings = {        -- Enable keybindings. NOTE: If given `false` then the plugin won't create any mappings
			basic = true,     -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
			extra = true,     -- Extra mapping; `gco`, `gcO`, `gcA`
			extended = false, -- Extended mapping; `g>` `g<` `g>[count]{motion}` `g<[count]{motion}`
		},
		pre_hook = commentstring.create_pre_hook(),
		post_hook = nil,    -- Function to call after (un)comment
	}
)
