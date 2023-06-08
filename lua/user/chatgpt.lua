local M = {
    "jackMort/ChatGPT.nvim",
    dependencies = {
        { "MunifTanjim/nui.nvim" }
    },
}

M.opts = {
    keymaps = {
        submit = "<C-s>",
        close = "<C-q>"
    },
    openai_edit_params = {
        model = "gpt-3.5-turbo"
    }
}

return M
