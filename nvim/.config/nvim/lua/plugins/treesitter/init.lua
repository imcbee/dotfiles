return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { "java", "graphql", "sql", "css", "scss", "dockerfile", "tsx", "python", "zsh" },
    indent = { enable = true, disable = { "html" } },
  },
}
