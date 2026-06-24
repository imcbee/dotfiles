-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- vim.api.nvim_create_autocmd("BufWritePre", {
--   callback = function()
--     if vim.bo.ft == "java" then
--       vim.lsp.buf.code_action({
--         context = { only = { "source.organizeImports" } },
--         apply = true,
--       })
--     end
--   end,
-- })

-- Autoformat setting
local set_autoformat = function(pattern, bool_val)
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = pattern,
    callback = function()
      vim.b.autoformat = bool_val
    end,
  })
end

set_autoformat({ "typescript", "html", "java", "python", "markdown", "yaml", "bash", "dockerfile" }, false)

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "markdown",
  callback = function()
    local buf_name = vim.api.nvim_buf_get_name(0)
    -- Expand your exact vault path to its absolute system path
    local vault_path = vim.fn.expand("~/Documents/Obsidian")

    -- Check if the current file is inside your Obsidian directory
    if buf_name:find(vault_path, 1, true) then
      vim.b.autoformat = true -- Enable formatting for vault files
    else
      vim.b.autoformat = false -- Disable formatting for all other markdown files
    end
  end,
})

vim.api.nvim_create_autocmd("CmdlineChanged", {
  callback = function()
    local cmdline = vim.fn.getcmdline()
    if vim.fn.getcmdtype() ~= ":" then
      return
    end
    if not cmdline:match("^Obsidian[A-Za-z0-9]*$") then
      return
    end
    vim.fn.wildtrigger()
  end,
})

-- Makes current line number cyan
vim.cmd("highlight CursorLineNr guifg=#00FFFF")
