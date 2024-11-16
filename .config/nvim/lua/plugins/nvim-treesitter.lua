return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "java",
        "javascript",
        "typescript",
        "angular",
        "bash",
        "dockerfile",
        "css",
        "go",
        "rust",
        "terraform",
        "lua",
        "vim",
        "vimdoc",
        "html",
        "markdown",
        "markdown_inline",
        "sql",
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
