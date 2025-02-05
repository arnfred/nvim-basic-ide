local M = {
    "neovim/nvim-lspconfig",
    tag = "v1.6.0",
    lazy = true,
    dependencies = {
        {
            "hrsh7th/cmp-nvim-lsp",
        },
    },
    event = { 'BufReadPre', 'BufNewFile' },
}

function M.config()

    local function lsp_keymaps(bufnr)
        local opts = { noremap = true, silent = true }
        local keymap = vim.api.nvim_buf_set_keymap

        -- See function references in telescope:
        keymap(bufnr, "n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
        vim.keymap.set('n', '<leader>fu', function() require('telescope.builtin').lsp_references() end)

        -- See diagnositcs in telescope for current buffer
        keymap(bufnr, "n", "<leader>t", "<cmd>lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>", opts)
        vim.keymap.set('n', '<leader>fd', function() require('telescope.builtin').diagnostics({ bufnr = 0 }) end)

        -- See all diagnostics in telescope
        vim.keymap.set('n', '<leader>T', function() require('telescope.builtin').diagnostics() end)

        -- Goto the implementation of the word under the cursor if there's only one, otherwise show all options in Telescope
        keymap(bufnr, "n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
        vim.keymap.set('n', '<leader>fi', function() require('telescope.builtin').lsp_implementations() end)

        -- Goto the definition of the word under the cursor, if there's only one, otherwise show all options in Telescope
        keymap(bufnr, "n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
        vim.keymap.set('n', '<leader>fd', function() require('telescope.builtin').lsp_definitions() end)

        -- Goto the definition of the type of the word under the cursor, if there's only one, otherwise show all options in Telescope
        keymap(bufnr, "n", "gt", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>", opts)
        vim.keymap.set('n', '<leader>fd', function() require('telescope.builtin').lsp_type_definitions() end)

        -- Lists LSP incoming calls for word under the cursor
        keymap(bufnr, "n", "gc", "<cmd>lua require('telescope.builtin').lsp_incoming_calls()<CR>", opts)
        vim.keymap.set('n', '<leader>fc', function() require('telescope.builtin').lsp_outgoing_calls() end)

        -- Lists LSP outgoing calls for word under the cursor
        keymap(bufnr, "n", "gC", "<cmd>lua require('telescope.builtin').lsp_incoming_calls()<CR>", opts)
        vim.keymap.set('n', '<leader>fC', function() require('telescope.builtin').lsp_outgoing_calls() end)

        -- Lists LSP document symbols in the current buffer
        keymap(bufnr, "n", "gs", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts)
        vim.keymap.set('n', '<leader>fs', function() require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
        }) end)

        -- Goto top level abstract declaration of function/method
        keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)

        -- Show tooltip with types
        keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

        -- Global rename symbol
        keymap(bufnr, "n", "R", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)

    end

    local lspconfig = require("lspconfig")


    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

    local on_attach = function(client, bufnr)
        lsp_keymaps(bufnr)
        require("illuminate").on_attach(client)
    end

    local opts = {
        on_attach = on_attach,
        capabilities = capabilities,
    }
    local lua_opts = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = {'vim'},
                },
            }
        },
    }

    lspconfig.lua_ls.setup(lua_opts)
    lspconfig.cssls.setup(opts)
    lspconfig.html.setup(opts)
    lspconfig.ts_ls.setup(opts)
    lspconfig.pyright.setup(opts)
    lspconfig.bashls.setup(opts)
    lspconfig.gopls.setup(opts)
    lspconfig.jsonls.setup(opts)
    lspconfig.yamlls.setup(opts)
    lspconfig.terraformls.setup(opts)
    lspconfig.clojure_lsp.setup(opts)

    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn", text = "" },
        { name = "DiagnosticSignHint", text = "" },
        { name = "DiagnosticSignInfo", text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        signs = {
            active = signs,
        },
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
            suffix = "",
        },
    }

    vim.diagnostic.config(config)
end

return M
