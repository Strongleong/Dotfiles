---@diagnostic disable: unused-local
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    vim.notify('Error. CMP is not found')
    return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    vim.notify('Error. Luasnip is not found')
    return
end

local function leave_snippet()
    if ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
        and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
        and not luasnip.session.jump_active
    then
        luasnip.unlink_current()
    end
end

vim.api.nvim_create_autocmd('ModeChanged', {
    pattern  = '*',
    callback = leave_snippet,
    desc     = 'Stop snippets when you leave to normal mode'
})

local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = ""
}

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    view = {
        entries = { name = 'custom', selection_order = 'near_cursor' }
    },
    window = {
        -- completion    = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered()
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>']     = cmp.mapping.scroll_docs(-4),
        ['<C-f>']     = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>']     = cmp.mapping.abort(),
        ['<CR>']      = cmp.mapping.confirm({ select = true }),
        ["<Tab>"]     = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s", "c" }),
        ["<S-Tab>"]   = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s", "c" }),
    }),
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip  = "[Snippet]",
                buffer   = "[Buffer]",
                emoji    = "[Emoji]",
                nvim_lua = "[NvimLua]",
                cmdline  = "[CmdLine]",
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = cmp.config.sources({
        { name = "path" },
        { name = "nvim_lua" },
        { name = "dap" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "emoji" },
    }),
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    experimental = {
        ghost_text = true,
        native_menu = false,
    },
    confirmation = {
        get_commit_characters = function(commit_characters)
            return {}
        end
    }
})

cmp.setup.cmdline(':', {
    sources = {
        { name = "path" },
        { name = 'cmdline' }
    }
})

cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    },
    -- view = {
    --     entries = {
    --         name = 'wildmenu',
    --         separator = '|'
    --     }
    -- },
})
