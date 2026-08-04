return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = { "java", "graphql", "sql", "css", "scss", "dockerfile", "tsx", "python", "zsh", "bash" },
    indent = { enable = true, disable = { "html" } },
  },
}
