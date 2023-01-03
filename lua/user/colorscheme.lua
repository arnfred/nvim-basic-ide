local M = {
  "navarasu/onedark.nvim"
  commit = "8ef51924724d506e515f2d3ac9f959a9eaf38f3d",
  lazy = false,    -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
}

function M.config()
  local status_ok, _ = pcall(vim.cmd.colorscheme, M.name)
  if not status_ok then
    return
  end
end

return M
