return {
  "hisbaan/dataview.nvim",
  -- only load dataview.nvim for files in your obsidian vault
  event = {
    "BufEnter " .. vim.fn.expand("~") .. "~/Documents/Obsidian/**",
  },
  -- configuration here, see below for full configuration options
  opts = {
    vault_dir = "path/to/vault",
    buffer_type = "float", -- float | split | vsplit | tab
  },
}
