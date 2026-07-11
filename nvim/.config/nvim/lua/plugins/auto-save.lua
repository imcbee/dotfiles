return {
  "okuuva/auto-save.nvim",
  version = "^1.0.0", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
  cmd = "ASToggle", -- optional for lazy loading on command
  event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
  opts = {
    -- your config goes here
    -- or just leave it empty :)
    trigger_events = {
      immediate_save = { "BufLeave", "FocusLost" }, -- save immediately when leaving buffer
      defer_save = { "InsertLeave" }, -- REMOVE "TextChanged" from here
      cancel_deferred_save = { "InsertEnter" },
    },
  },
  keys = {
    { "<leader>uv", "<cmd>ASToggle<CR>", desc = "Toggle Auto-Save" },
  },
}
