return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { "java", "graphql", "sql", "css", "scss", "dockerfile", "tsx", "python" },
    indent = { enable = true, disable = { "html" } },
  },
}
