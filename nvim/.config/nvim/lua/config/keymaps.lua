-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move line of code up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Hide diagnostics and linting errors
vim.keymap.set("n", "<leader>dh", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true })

-- Add a border to lsp.buf.hover
vim.keymap.set("n", "K", function()
  vim.lsp.buf.hover({
    border = "single",
  })
end)

local hardmode = true
if hardmode then
  -- Show an error message if a disabled key is pressed
  local msg = [[<cmd>echohl Error | echo "KEY DISABLED" | echohl None<CR>]]

  -- Disable arrow keys in insert mode with a styled message
  -- vim.api.nvim_set_keymap("i", "<Up>", "<C-o>" .. msg, { noremap = true, silent = false })
  -- vim.api.nvim_set_keymap("i", "<Down>", "<C-o>" .. msg, { noremap = true, silent = false })
  -- vim.api.nvim_set_keymap("i", "<Left>", "<C-o>" .. msg, { noremap = true, silent = false })
  -- vim.api.nvim_set_keymap("i", "<Right>", "<C-o>" .. msg, { noremap = true, silent = false })
  -- vim.api.nvim_set_keymap("i", "<Del>", "<C-o>" .. msg, { noremap = true, silent = false })
  -- vim.api.nvim_set_keymap("i", "<BS>", "<C-o>" .. msg, { noremap = true, silent = false })

  -- Disable arrow keys in normal mode with a styled message
  vim.api.nvim_set_keymap("n", "<Up>", msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("n", "<Down>", msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("n", "<Left>", msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("n", "<Right>", msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("n", "<BS>", msg, { noremap = true, silent = false })
end
