-- Pretty list for diagnostics, references, etc.
return {
    {
        'folke/trouble.nvim',
        cmd = { 'Trouble', 'TroubleToggle' },
        dependencies = 'nvim-tree/nvim-web-devicons',
        opts = {
            auto_close = true,
            win_config = { border = 'rounded' },
        },
        keys = {
            {
                '<leader>t',
                ':Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Document diagnostics',
            },
        },
    },
}
