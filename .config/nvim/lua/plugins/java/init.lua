return {
  "nvim-java/nvim-java",
  enabled = false,
  config = function()
    require("java").setup({
      -- Extensions
      lombok = {
        enable = true,
        version = "1.18.42",
      },
      -- JDK installation
      jdk = {
        auto_install = false,
      },
    })
    vim.lsp.enable("jdtls", {
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-25",
                path = "/Users/ianmcbee/.sdkman/candidates/java/current/bin/java",
                default = true,
              },
            },
          },
        },
      },
    })
  end,
}
