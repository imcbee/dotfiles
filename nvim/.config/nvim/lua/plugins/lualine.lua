return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    -- This preserves all of LazyVim's default components
    -- and simply swaps the theme out under the hood.
    opts.options = opts.options or {}
    opts.options.theme = "auto"
  end,
}
