--return {
--  "Mofiqul/vscode.nvim",
--  name = "vscode",
--  lazy = false,
--  priority = 1000,
--  opts = {
--    style = "dark",
--    transparent = true,
--    italic_comments = true,
--    underline_links = true,
--    terminal_colors = true,
--  },
--  config = function()
--    vim.cmd("colorscheme vscode")
--
--    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
--  end,
--}

return {
  "gmr458/vscode_modern_theme.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("vscode_modern").setup({
      cursorline = true,
      transparent_background = true,
      nvim_tree_darker = true,
    })
    vim.cmd.colorscheme("vscode_modern")
  end,
}
