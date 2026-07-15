return {
  {
    "nvim-java/nvim-java",
    config = false, -- Let lspconfig manage the initialization lifecycle sequence
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        opts = {
          servers = {
            jdtls = {
              -- Strips formatting control away from JDTLS to keep Spotless safe
              on_attach = function(client, bufnr)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
              end,
              settings = {
                java = {
                  configuration = {
                    runtimes = {
                      {
                        name = "JavaSE-25",
                        path = "/Users/ianmcbee/.sdkman/candidates/java/current",
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
              -- This MUST run right here. It injects the required vscode-java-debug
              -- bundles into lspconfig a millisecond before the server initializes.
              require("java").setup({
                lombok = {
                  enable = true,
                  version = "1.18.46",
                },
                jdk = {
                  auto_install = false,
                },
              })

              -- =====================================================================
              -- DYNAMIC ENV INJECTION FOR JUNIT TESTS & SINGLE RUNNERS
              -- =====================================================================
              local dap_ok, dap = pcall(require, "dap")
              if dap_ok then
                local original_run = dap.run
                dap.run = function(config, opts)
                  if config and config.type == "java" then
                    config.env = config.env or {}

                    -- Find your project's root directory dynamically
                    local project_root = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" })
                      or vim.fn.getcwd()

                    -- Define your local build environment files in order of application
                    local env_files = {
                      project_root .. "/local.build.env",
                      project_root .. "/.env",
                    }

                    for _, file_path in ipairs(env_files) do
                      local file = io.open(file_path, "r")
                      if file then
                        for line in file:lines() do
                          -- Ignore comments and empty lines
                          if not line:match("^%s*#") and not line:match("^%s*$") then
                            local key, val = line:match("^%s*([^=]+)%s*=%s*(.*)%s*$")
                            if key and val then
                              -- Clean whitespace and outer quotes
                              val = val:gsub("^[\"'](.*)[\"']$", "%1")
                              config.env[key] = val
                            end
                          end
                        end
                        file:close()
                      end
                    end
                  end

                  -- Let DAP execute the run command with our newly injected variables
                  original_run(config, opts)
                end
              end
              -- =====================================================================

              -- CRITICAL: Do NOT return true here. Letting LazyVim fall through ensures
              -- it handles the final server ignition with our newly injected hooks intact.
            end,
          },
        },
      },
    },
  },

  -- Lightweight, conflict-free file generator
  {
    "alessio-vivaldelli/java-creator-nvim",
    ft = "java",
    opts = {
      keymaps = {
        java_new = "<leader>Jn",
        java_class = "<leader>Jc",
        java_interface = "<leader>Ji",
        java_enum = "<leader>Je",
        java_record = "<leader>Jcx", -- Changed from <leader>Jr to avoid collision with Run Project
      },
      options = {
        auto_open = true, -- Open file after creation
        java_version = 17, -- Minimum Java version
        use_notify = true,
      },
    },
  },

  -- Custom Runners, Testing Keymaps & Multi-EnvFile Compound Automation
  {
    "neovim/nvim-lspconfig",
    -- Using 'init' ensures we declare keymaps safely without completely wiping out 'opts'
    init = function()
      -- SINGLE-SERVICE RUNNERS (built into nvim-java)
      vim.keymap.set("n", "<leader>Jr", "<cmd>JavaRunnerRunMain<cr>", { desc = "Spring Boot [R]un Project" })
      vim.keymap.set("n", "<leader>Js", "<cmd>JavaRunnerStopMain<cr>", { desc = "Spring Boot [S]top Project" })
      vim.keymap.set("n", "<leader>Jl", "<cmd>JavaRunnerToggleLogs<cr>", { desc = "Spring Boot Toggle [L]ogs" })

      -- JUNIT TESTING KEYMAPS (Added to fix your issue)
      vim.keymap.set("n", "<leader>Jtc", "<cmd>JavaTestRunCurrentClass<cr>", { desc = "Java Test Current [C]lass" })
      vim.keymap.set("n", "<leader>Jtm", "<cmd>JavaTestRunCurrentMethod<cr>", { desc = "Java Test Current [M]ethod" })
      vim.keymap.set("n", "<leader>Jta", "<cmd>JavaTestRunAllTests<cr>", { desc = "Java Run [A]ll Tests" })
      vim.keymap.set(
        "n",
        "<leader>Jtd",
        "<cmd>JavaTestDebugCurrentMethod<cr>",
        { desc = "Java [D]ebug Current Method" }
      )
      vim.keymap.set("n", "<leader>Jtr", "<cmd>JavaTestViewLastReport<cr>", { desc = "Java Test View Last [R]eport" })

      -- COMPOUND RUNNER: Parses multiple .env files sequentially and runs microservices safely
      vim.keymap.set("n", "<leader>Jm", function()
        local dap = require("dap")
        local configs = require("dap.ext.vscode").getconfigs() or {}

        -- Your targeted microservice cluster
        local services_to_run = {
          "atoms-aor",
          "atoms-api",
          "atoms-email",
          "atoms-eoid-discovery",
          "atoms-ess-indexer",
          "atoms-event-stream",
          "atoms-guide",
          "atoms-init",
          "atoms-node-change",
          "atoms-scheduled-tasks",
          "atoms-wfs-node",
        }

        -- Internal parser to extract variables from a single .env file path
        local function parse_env_file(env_file_path)
          local env_vars = {}
          if not env_file_path then
            return env_vars
          end

          local absolute_path = env_file_path:gsub("${workspaceFolder}", vim.fn.getcwd())
          local file = io.open(absolute_path, "r")
          if not file then
            vim.notify("EnvFile not found at: " .. absolute_path, vim.log.levels.WARN)
            return env_vars
          end

          for line in file:lines() do
            if not line:match("^%s*#") and not line:match("^%s*$") then
              local key, val = line:match("^%s*([^=]+)%s*=%s*(.*)%s*$")
              if key and val then
                val = val:gsub("^[\"'](.*)[\"']$", "%1") -- Strip quotes if present
                env_vars[key] = val
              end
            end
          end
          file:close()
          return env_vars
        end

        for _, service_name in ipairs(services_to_run) do
          local found = false
          for _, config in ipairs(configs) do
            if config.name == service_name then
              local running_config = vim.deepcopy(config)

              if running_config.envFile then
                running_config.env = running_config.env or {}

                -- Normalize envFile into an array table
                local env_files = type(running_config.envFile) == "table" and running_config.envFile
                  or { running_config.envFile }

                -- Sequentially parse and merge variables
                for _, file_path in ipairs(env_files) do
                  local file_envs = parse_env_file(file_path)
                  for k, v in pairs(file_envs) do
                    running_config.env[k] = v
                  end
                end

                -- Clears payload type to prevent JDTLS deserialization errors
                running_config.envFile = nil
              end

              dap.run(running_config)
              found = true
              break
            end
          end
          if not found then
            vim.notify("Compound Runner: Could not find config for '" .. service_name .. "'", vim.log.levels.WARN)
          end
        end
      end, { desc = "Spring Boot Run [M]ulti-Services (Compound)" })
    end,
  },
}
