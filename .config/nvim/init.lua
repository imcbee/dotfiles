--  bootstrap lazy.nvim, LazyVim and your plugins
if vim.g.vscode then
  -- VSCode extension
  require("user.vscode_keymaps")
else
  -- ordinary Neovim
  require("config.lazy")
end
