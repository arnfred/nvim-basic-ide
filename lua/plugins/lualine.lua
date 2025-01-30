return {
    {
        'nvim-lualine/lualine.nvim',
        event = 'VeryLazy',
        config = function()

            -- Disable this since the mode will be displayed by lualine.
            vim.o.showmode = false

            -- Update the statusline with the latest LSP message.
            vim.api.nvim_create_autocmd('LspProgress', {
                pattern = '*',
                command = 'redrawstatus',
            })

            require('lualine').setup {
                options = {
                    theme = 'onedark',
                    component_separators = '|',
                    section_separators = '',
                    globalstatus = true,
                    disabled_filetypes = { statusline = { 'alpha' } },
                },
                sections = {
                    lualine_b = { 'branch' },
                    lualine_c = {
                        -- Show LSP progress.
                        {
                            function()
                                local lsp_progress = require('noice').api.status.lsp_progress.get_hl()
                                return vim.trim(lsp_progress)
                            end,
                            cond = function()
                                return package.loaded['noice'] and require('noice').api.status.lsp_progress.has()
                            end,
                        },
                        -- Show macro recording messages.
                        {
                            function()
                                return require('noice').api.status.mode.get()
                            end,
                            cond = function()
                                return package.loaded['noice'] and require('noice').api.status.mode.has()
                            end,
                        },
                        {
                            function()
                                return '  ' .. require('dap').status()
                            end,
                            cond = function()
                                return package.loaded['dap'] and require('dap').status() ~= ''
                            end,
                        },
                    },
                    lualine_y = { 'encoding', 'filetype' },
                },
            }
        end,
    },
}
