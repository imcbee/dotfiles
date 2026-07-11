return {
  "hamidi-dev/org-list.nvim",
  dependencies = {
    "tpope/vim-repeat", -- for repeatable actions with '.'
  },
  config = function()
    require("org-list").setup({
      -- your config here (optional)
    })
  end,
}
