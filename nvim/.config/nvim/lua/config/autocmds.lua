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

-- Obsidian Git Sync
-- 1. Bind the timer globally so the Lua Garbage Collector never kills it
_G.obsidian_git_timer = _G.obsidian_git_timer or (vim.uv or vim.loop).new_timer()

local vault_path = vim.fn.expand("~/Documents/Obsidian/") -- ⚠️ Double-check this absolute path

local function git_sync()
  -- Updated Sequence:
  -- 1. Stage everything FIRST so your active workspace is clean
  -- 2. If there are changes, commit them -> pull updates -> push everything
  -- 3. If there are NO changes, just run a clean pull to stay updated
  local cmd = "git add . && "
    .. "if ! git diff-index --quiet HEAD --; then "
    .. "  git commit -m 'Vault sync: "
    .. os.date("%Y-%m-%d %H:%M:%S")
    .. "' && "
    .. "  git pull --rebase && "
    .. "  git push && echo 'SYNC_PUSHED'; "
    .. "else "
    .. "  git pull --rebase && echo 'SYNC_IDLE'; "
    .. "fi"

  local stdout_lines = {}

  vim.fn.jobstart(cmd, {
    cwd = vault_path,
    on_stdout = function(_, data)
      for _, line in ipairs(data) do
        if line ~= "" then
          table.insert(stdout_lines, line)
        end
      end
    end,
    on_stderr = function(_, data)
      for _, line in ipairs(data) do
        if line ~= "" then
          table.insert(stdout_lines, line)
        end
      end
    end,
    on_exit = function(_, exit_code)
      vim.schedule(function()
        -- Notify on failure
        if exit_code ~= 0 then
          if vim.fn.isdirectory(vault_path) ~= 1 then
            vim.notify(
              "Git Sync Error! Output:\n" .. table.concat(stdout_lines, "\n"),
              vim.log.levels.ERROR,
              { title = "Obsidian Git Fail" }
            )
          end
        else
          -- Success notifications
          local output_text = table.concat(stdout_lines, "\n")
          if output_text:match("SYNC_PUSHED") then
            vim.notify("Vault backed up securely!", vim.log.levels.INFO, { title = "Obsidian Git" })
          end
        end
      end)
    end,
  })
end

-- Stop any ghost instances of this timer if you source/reload your config
_G.obsidian_git_timer:stop()

-- Start the loop: wait 5 seconds on startup, then execute every 120,000ms (2 minutes)
_G.obsidian_git_timer:start(
  5000,
  120000,
  vim.schedule_wrap(function()
    if vim.fn.isdirectory(vault_path) == 1 then
      git_sync()
    end
  end)
)
