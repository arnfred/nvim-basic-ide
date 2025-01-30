local M = {
    'hrsh7th/nvim-cmp',
    dependencies = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-nvim-lsp',
    },
    event = 'InsertEnter',
}

local symbol_kinds = {
    Class = '',
    Color = '',
    Constant = '',
    Constructor = '',
    Enum = '',
    EnumMember = '',
    Event = '',
    Field = '',
    File = '',
    Folder = '',
    Function = '',
    Interface = '',
    Keyword = '',
    Method = '',
    Module = '',
    Operator = '',
    Property = '',
    Reference = '',
    Snippet = '',
    Struct = '',
    Text = '',
    TypeParameter = '',
    Unit = '',
    Value = '',
    Variable = '',
}

function M.config()
    local cmp = require("cmp")

    ---@diagnostic disable: missing-fields
    cmp.setup {

        -- Disable autocomplete. Invoke with <C-Space> instead.
        completion = { autocomplete = false },

        -- Disable preselect. On enter, the first thing will be used if nothing
        -- is selected.
        preselect = cmp.PreselectMode.None,

        -- Add icons to the completion menu.
        formatting = {
            format = function(_, vim_item)
                vim_item.kind = (symbol_kinds[vim_item.kind] or '') .. '  ' .. vim_item.kind
                return vim_item
            end,
        },
        window = {
            -- Make the completion menu bordered.
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        view = {
            -- Explicitly request documentation.
            docs = { auto_open = true },
        },
        mapping = cmp.mapping.preset.insert {
            ['<C-j>'] = cmp.mapping.scroll_docs(-4),
            ['<C-k>'] = cmp.mapping.scroll_docs(4),
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            -- Explicitly request completions.
            ['<C-Space>'] = cmp.mapping.complete(),
            ['/'] = cmp.mapping.close(),
            -- Overload tab to accept Copilot suggestions.
            ['<Tab>'] = cmp.mapping(function(fallback)
                local copilot = require 'copilot.suggestion'

                if copilot.is_visible() then
                    copilot.accept()
                elseif cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<C-d>'] = function()
                if cmp.visible_docs() then
                    cmp.close_docs()
                else
                    cmp.open_docs()
                end
            end,
        },
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'crates' },
        }, {
            { name = 'buffer' },
        }),
    }
    ---@diagnostic enable: missing-fields
end

return M
