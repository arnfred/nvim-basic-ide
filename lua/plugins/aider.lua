local M = {
    "GeorgesAlkhouri/nvim-aider",
    cmd = {
        "AiderTerminalToggle", "AiderHealth",
    },
    keys = {
        { "\\", "<cmd>AiderTerminalToggle<cr>", desc = "Open Aider", mode = { "n", "v" } },
        { "<localleader>as", "<cmd>AiderTerminalSend<cr>", desc = "Send to Aider", mode = { "n", "v" } },
        { "<localleader>\\", "<cmd>AiderQuickSendCommand<cr>", desc = "Send Command To Aider" },
        { "<localleader>ab", "<cmd>AiderQuickSendBuffer<cr>", desc = "Send Buffer To Aider" },
        { "<localleader>=", "<cmd>AiderQuickAddFile<cr>", desc = "Add File to Aider" },
        { "<localleader>-", "<cmd>AiderQuickDropFile<cr>", desc = "Drop File from Aider" },
        { "<localleader>ar", "<cmd>AiderQuickReadOnlyFile<cr>", desc = "Add File as Read-Only" },
        { "\\", "<C-\\><C-n><cmd>AiderTerminalToggle<cr>", mode = "t" },
    },
    dependencies = {
        "folke/snacks.nvim",
        "nvim-telescope/telescope.nvim",
        --- The below dependencies are optional
        "catppuccin/nvim",
        "nvim-tree/nvim-tree.lua",
    },
    config = true,
}

function M.config()
    require("nvim_aider").setup({
        win = {
            position = "right"
        },
        config = {
            keys = {
                term_normal = {
                    "<esc>",
                    function(self)
                        self.esc_timer = self.esc_timer or (vim.uv or vim.loop).new_timer()
                        vim.cmd("stopinsert")
                    end,
                    mode = "t",
                    expr = true,
                    desc = "Double escape to normal mode",
                },
            },
        },
    })
end

return M
