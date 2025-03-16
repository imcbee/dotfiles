return {
  "nvim-java/nvim-java",
  config = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          -- Your JDTLS configuration goes here
          jdtls = {
            settings = {
              java = {
                configuration = {
                  runtimes = {
                    {
                      name = "openjdk 21.0.2 2024-01-16",
                      path = "/Users/ianmcbee/.asdf/shims/java",
                      default = true,
                    },
                  },
                },
              },
            },
          },
        },
        setup = {
          jdtls = function()
            -- Your nvim-java configuration goes here
            require("java").setup({
              jdk = {
                auto_install = false,
              },
              root_markers = {
                "settings.gradle",
                "settings.gradle.kts",
                "pom.xml",
                "build.gradle",
                "mvnw",
                "gradlew",
                "build.gradle",
                "build.gradle.kts",
              },
              notifications = {
                -- enable 'Configuring DAP' & 'DAP configured' messages on start up
                dap = true,
              },
              java_test = {
                enable = true,
                version = "0.43.0",
              },
              spring_boot_tools = {
                enable = true,
                version = "1.59.0",
              },
            })
          end,
        },
      },
    },
  },
}
