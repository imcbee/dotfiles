return {
  {
    "okuuva/auto-save.nvim", -- The updated, community-maintained fork
    event = { "InsertLeave", "TextChanged" },
    opts = {
      enabled = true,
      -- Note: okuuva completely removed the noisy console notifications by default,
      -- so you don't even need to write a function to silence it anymore!
    },
    keys = {
      { "<leader>uv", "<cmd>ASToggle<CR>", desc = "Toggle Auto-Save" },
    },
  },
}
