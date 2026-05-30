return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-mini/mini.nvim",
  },

  opts = {
    latex = {
      enabled = false,
    },
  },

  config = function(_, opts)
    require("render-markdown").setup(opts)
  end,
}
