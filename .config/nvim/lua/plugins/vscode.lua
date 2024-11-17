return {
  {
    "Mofiqul/vscode.nvim",
    opts = {
      style = "dark",
      transparent = true,
      italic_comments = true,
      underline_links = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        require("vscode").load()
      end,
    },
  },
}
