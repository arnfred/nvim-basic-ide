M = {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    opts = {
        auto_install = true,
        highlight = { enable = true }

    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        {
            'nvim-treesitter/nvim-treesitter-context',
            opts = {
                -- Avoid the sticky context from growing a lot.
                    max_lines = 3,
                -- Match the context lines to the source code.
                    multiline_threshold = 1,
            },
            keys = {
                {
                    '[c',
                    function()
                        require('treesitter-context').go_to_context()
                        end,
                    desc = 'Jump to upper context',
                },
            },
        },
    },
    event = { 'BufReadPost', 'BufNewFile' },
    build = ':TSUpdate',
}

function M.config()
    require("nvim-treesitter.configs").setup({
        highlight = {
                enable = true,
                disable = function(lang, buf)
                    -- Looking at you checker.ts
                    return vim.api.nvim_buf_line_count(buf) > 10000
                end,
            },
        })
end

return M
