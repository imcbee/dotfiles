return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/playground",
	"nvim-treesitter/nvim-treesitter-textobjects",
	"nvim-treesitter/nvim-treesitter-refactor",
    },
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "lua", "vim", "vimdoc", "javascript", "html", "css", "angular", "typescript", "rust", "go", "zig", "bash", "json", "toml", "luadoc", "jsonc", "markdown", "python", "angular", "java", "luadoc", "scss", "dockerfile", "diff", "sql", "yaml", "gitcommit", "gitignore"},
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
	  auto_install = true
        })
    end
}
