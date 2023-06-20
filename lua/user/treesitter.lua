local M = {
    "nvim-treesitter/nvim-treesitter",
    commit = "226c1475a46a2ef6d840af9caa0117a439465500",
    event = "BufReadPost",
    dependencies = {
        {
            "JoosepAlviste/nvim-ts-context-commentstring",
            event = "VeryLazy",
            commit = "729d83ecb990dc2b30272833c213cc6d49ed5214",
        },
        {
            "nvim-tree/nvim-web-devicons",
            event = "VeryLazy",
            commit = "0568104bf8d0c3ab16395433fcc5c1638efc25d4"
        },
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            event = "VeryLazy",
        }
    },
}

function M.config()
    local treesitter = require "nvim-treesitter"
    local configs = require "nvim-treesitter.configs"

    configs.setup {
        ensure_installed = "all",
        ignore_install = { "phpdoc", "php" },
        sync_install = false,                                                          -- install languages synchronously (only applied to `ensure_installed`)

        highlight = {
            enable = true,       -- false will disable the whole extension
            disable = function(_, bufnr) return vim.api.nvim_buf_line_count(bufnr) > 10000 end,
        },
        autopairs = {
            enable = false,
        },
        indent = { enable = true, disable = { "python", "css" } },
        incremental_selection = { enable = true },

        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
        textobjects = {
            select = {
                enable = true,

                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,

                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                    ["ak"] = "@block.outer",
                    ["ik"] = "@block.inner",
                    ["a?"] = "@conditional.outer",
                    ["i?"] = "@conditional.inner",
                    ["al"] = "@loop.outer",
                    ["il"] = "@loop.inner",

                },
                -- You can choose the select mode (default is charwise 'v')
                --
                -- Can also be a function which gets passed a table with the keys
                -- * query_string: eg '@function.inner'
                -- * method: eg 'v' or 'o'
                -- and should return the mode ('v', 'V', or '<c-v>') or a table
                -- mapping query_strings to modes.
                selection_modes = {
                    ['@parameter.outer'] = 'v', -- charwise
                    ['@function.outer'] = 'V', -- linewise
                },
                -- If you set this to `true` (default is `false`) then any textobject is
                -- extended to include preceding or succeeding whitespace. Succeeding
                -- whitespace has priority in order to act similarly to eg the built-in
                -- `ap`.
                include_surrounding_whitespace = true,
            },
            lsp_interop = {
                enable = true,
                border = 'none',
                floating_preview_opts = {},
                peek_definition_code = {
                    ["<leader>ld"] = "@function.outer",
                    ["<leader>lD"] = "@class.outer",
                },
            },
            move = {
                enable = true,
                set_jumps = true,
                goto_next_start = {
                    ["]k"] = { query = "@block.outer", desc = "Next block start" },
                    ["]c"] = { query = "@class.outer", desc = "Next class start" },
                    ["]f"] = { query = "@function.outer", desc = "Next function start" },
                    ["]a"] = { query = "@parameter.outer", desc = "Next parameter start" },
                },
                goto_next_end = {
                    ["]K"] = { query = "@block.outer", desc = "Next block end" },
                    ["]C"] = { query = "@class.outer", desc = "Next class end" },
                    ["]F"] = { query = "@function.outer", desc = "Next function end" },
                    ["]A"] = { query = "@parameter.outer", desc = "Next parameter end" },
                },
                goto_previous_start = {
                    ["[k"] = { query = "@block.outer", desc = "Previous block start" },
                    ["[c"] = { query = "@class.outer", desc = "Previous class start" },
                    ["[f"] = { query = "@function.outer", desc = "Previous function start" },
                    ["[a"] = { query = "@parameter.outer", desc = "Previous parameter start" },
                },
                goto_previous_end = {
                    ["[K"] = { query = "@block.outer", desc = "Previous block end" },
                    ["[C"] = { query = "@class.outer", desc = "Previous class end" },
                    ["[F"] = { query = "@function.outer", desc = "Previous function end" },
                    ["[A"] = { query = "@parameter.outer", desc = "Previous parameter end" },
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    [">k"] = { query = "@block.outer", desc = "Swap next block" },
                    [">f"] = { query = "@function.outer", desc = "Swap next function" },
                    [">a"] = { query = "@parameter.inner", desc = "Swap next parameter" },
                },
                swap_previous = {
                    ["<k"] = { query = "@block.outer", desc = "Swap previous block" },
                    ["<f"] = { query = "@function.outer", desc = "Swap previous function" },
                    ["<a"] = { query = "@parameter.inner", desc = "Swap previous parameter" },
                },
            },
        },
    }
end

return M
