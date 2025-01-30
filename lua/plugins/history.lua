local M = {
    "wilfreddenton/history.nvim",
    dependencies = {
        { "nvim-lua/plenary.nvim" }
    },
    lazy = false,
}

M.opts = {
    keybinds = {
        back = "<C-h>",
        forward = "<C-l>"
    }
}

return M
