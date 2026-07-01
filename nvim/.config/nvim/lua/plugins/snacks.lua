return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true,
        sources = {
          explorer = {
            layout = {
              layout = {
                position = "right",
              },
            },
          },
          files = {
            hidden = true, -- Show hidden/dotfiles
            ignored = false, -- Show gitignored files
          },
        },
      },
    },
  },
}
