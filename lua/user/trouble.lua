local M = {
 "folke/trouble.nvim",
 dependencies = { "nvim-tree/nvim-web-devicons" },
 opts = {
     mode = "document_diagnostics",
     action_keys = {

  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
 },
}

local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_buf_set_keymap
keymap("n", "<leader>t", "<cmd>TroubleToggle<cr>", opts)

return M
