return {
  "snapwich/obsidian-tasks.nvim",
  enabled = false, -- TODO need to figure out why tasks duplicate
  config = function()
    require("obsidian-tasks").setup({})
  end,
}
