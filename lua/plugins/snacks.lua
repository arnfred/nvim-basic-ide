local M = {
  "folke/snacks.nvim",
  priority = 1000,
  tag = 'v2.18.0',
  lazy = false,
  ---@type snacks.Config
  opts = {
    indent = {
      -- your indent configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  }
}

return M
