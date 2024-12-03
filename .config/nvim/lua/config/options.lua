-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options hereafter

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2 -- set width of line number column

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- number of spaces inserted for each indentation level
vim.opt.breakindent = true -- enable line breaking indentation

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50
