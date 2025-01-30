local M = {
  "navarasu/onedark.nvim",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
  local colorscheme = "onedark"
  local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
  vim.o.background = "dark" -- or "light" for light mode
  if not ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
  end
end

return M
