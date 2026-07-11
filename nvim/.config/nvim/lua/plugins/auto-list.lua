return {
  "gaoDean/autolist.nvim",
  ft = { "markdown", "text" },
  config = function()
    require("autolist").setup()

    -- Standard Enter: Continues the list/task syntax
    vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
    vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
    vim.keymap.set("n", "O", "O<cmd>AutolistNewBullet<cr>")

    -- ✅ Shift + Enter: Bypasses ALL list logic and creates a clean new line
    vim.keymap.set("i", "<S-CR>", function()
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      local line = vim.api.nvim_get_current_line()

      -- Split the line exactly where the cursor is
      local current_part = string.sub(line, 1, col)
      local next_part = string.sub(line, col + 1)

      -- Set the current line to everything before the cursor
      vim.api.nvim_set_current_line(current_part)
      -- Force append the rest onto a fresh line below with zero formatting
      vim.api.nvim_buf_set_lines(0, row, row, false, { next_part })
      -- Move your cursor to the beginning of that clean new line
      vim.api.nvim_win_set_cursor(0, { row + 1, 0 })
    end, { desc = "Escape list formatting and enter clean newline" })

    -- Smart indenting/dedenting inside lists
    vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
    vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
    vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr>")
  end,
}
