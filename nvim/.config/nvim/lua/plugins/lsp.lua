return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- 1. Disable Marksman to prevent double diagnostics and overlapping completions
        marksman = { enabled = false },

        -- 2. Configure Markdown-Oxide
        markdown_oxide = {
          capabilities = {
            workspace = {
              didChangeWatchedFiles = {
                -- CRITICAL: This allows markdown-oxide to look at your vault
                -- and update unresolved links/backlinks in real-time.
                dynamicRegistration = true,
              },
            },
          },
          -- Tells the LSP where your vault/project root is
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(".git", ".obsidian", ".moxide.toml")(fname)
          end,
        },
      },
    },
  },
}
