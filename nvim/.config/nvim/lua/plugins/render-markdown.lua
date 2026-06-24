return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    -- ─── STEP 1: TURN LATEX BACK ON ──────────────────────────────────
    latex = {
      enabled = true,
      position = "center", -- Renders the equation centered in the block
    },

    -- Keeps your clean heading and code block styles from the docs
    heading = {
      width = "block",
      left_pad = 1,
      right_pad = 2,
      icons = { " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 " },
    },
    code = {
      width = "block",
      left_pad = 1,
      right_pad = 4,
    },

    -- Obsidian callouts ([!NOTE], [!WARNING], etc.) are enabled by default!
    -- No extra configuration is needed here unless you want to change default icons.
    callout = {},

    checkbox = {
      custom = {
        todo = { raw = "[-]", rendered = "󰥔 ", hl = "RenderMarkdownTodo" },
      },
    },
  },
}
