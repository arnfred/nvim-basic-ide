local M = {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
}

function M.config()
    local cmp = require 'cmp'
    local copilot = require 'copilot.suggestion'

    require("copilot").setup {
        {
            -- I don't find the panel useful.
            panel = { enabled = false },
            suggestion = {
                enabled = true,
                auto_trigger = true,
                -- Use alt to interact with Copilot.
                keymap = {
                    -- Disable the built-in mapping, we'll configure it in nvim-cmp.
                    accept = false,
                    accept_word = '<c-n>',
                    accept_line = "<c-l>",
                    next = "<c-j>",
                    prev = "<c-k>",
                    dismiss = "<c-h>",
                    -- Enable Copilot suggestion? 
                    
                    

                },
            },
            filetypes = {
                markdown = true,
                help = false,
                gitcommit = false,
                gitrebase = false,
                hgcommit = false,
                svn = false,
                cvs = false,
                ["."] = false,
            },
        },
    }

    local function set_trigger(trigger)
        vim.b.copilot_suggestion_auto_trigger = trigger
        vim.b.copilot_suggestion_hidden = not trigger
    end

    -- Hide suggestions when the completion menu is open.
    cmp.event:on('menu_opened', function()
        if copilot.is_visible() then
            copilot.dismiss()
        end
        set_trigger(false)
    end)
end

return M
