local M = {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.8',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            branch = 'main',
            build = 'make',
            config = function()
                require('telescope').load_extension 'fzf'
            end,
        },
    },
}

M.keys = {
    { "<leader>fr", ":Telescope resume<CR>", desc = 'Previous Search' },
    { "<leader>ff", ":Telescope find_files<CR>", desc = 'File Serach' },
    { "<leader>FF", ":Telescope find_files no_ignore=true hidden=true<CR>", desc = "Hidden File Search" },
    { "<leader>fg", ":Telescope live_grep<CR>", desc = "String Search" },
    { 
        "<leader>fb",
        function()
            require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end,
        desc = "Current Buffer Search"
    },
    { "<leader>fw", ":Telescope grep_string<CR>", desc = "Word under cursor Search" },
}

function M.config()
    local actions = require("telescope.actions")

    -- Create a named function here instead of an anonymous function in the setup
    -- so that the name appears in Telescope's which-key.
    local function open_with_trouble(...)
        return require('trouble.providers.telescope').open_with_trouble(...)
    end

    require('telescope').setup {
        defaults = {
            mappings = {
                i = {
                    ["<esc>"] = actions.close,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                },
            },
        }
    }
end

return M
