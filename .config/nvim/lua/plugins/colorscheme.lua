return {
    "Mofiqul/vscode.nvim",
    name = "vscode",
    opts = {
      style = "dark",
      transparent = true,
      italic_comments = true,
      underline_links = true,
    },
    config = function()
        vim.cmd("colorscheme vscode")

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
}
