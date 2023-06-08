local M = {
 "folke/trouble.nvim",
 dependencies = { "nvim-tree/nvim-web-devicons" },
 opts = {
     mode = "document_diagnostics",
 },
}

--vim.api.nvim_buf_set_keymap("n", "<leader>t", "<cmd>TroubleToggle<cr>", { noremap = true })

return M
