-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Move line of code up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Hide diagnostics and linting errors
vim.keymap.set("n", "<leader>dh", function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { silent = true, noremap = true })

-- Add a border to lsp.buf.hover
vim.keymap.set("n", "K", function()
  vim.lsp.buf.hover({
    border = "single",
  })
end)

-- Hard Mode
local hardmode = true
if hardmode then
  -- Show an error message if a disabled key is pressed
  local msg = [[<cmd>echohl Error | echo "KEY DISABLED" | echohl None<CR>]]

  -- Disable arrow keys in insert mode with a styled message
  -- vim.api.nvim_set_keymap("i", "<Up>", "<C-o>" .. msg, { noremap = true, silent = false })
  -- vim.api.nvim_set_keymap("i", "<Down>", "<C-o>" .. msg, { noremap = true, silent = false })
  -- vim.api.nvim_set_keymap("i", "<Left>", "<C-o>" .. msg, { noremap = true, silent = false })
  -- vim.api.nvim_set_keymap("i", "<Right>", "<C-o>" .. msg, { noremap = true, silent = false })
  -- vim.api.nvim_set_keymap("i", "<Del>", "<C-o>" .. msg, { noremap = true, silent = false })
  -- vim.api.nvim_set_keymap("i", "<BS>", "<C-o>" .. msg, { noremap = true, silent = false })

  -- Disable arrow keys in normal mode with a styled message
  vim.api.nvim_set_keymap("n", "<Up>", msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("n", "<Down>", msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("n", "<Left>", msg, { noremap = true, silent = false })
  vim.api.nvim_set_keymap("n", "<Right>", msg, { noremap = true, silent = false })
  --vim.api.nvim_set_keymap("n", "<BS>", msg, { noremap = true, silent = false })
end

-- ReadItLater for Obsidian
local function local_readitlater(insert_at_cursor)
  local url = vim.fn.getreg("+"):gsub("%s+", "")
  if not url:match("^https?://") then
    vim.notify("Clipboard does not contain a valid URL!", vim.log.levels.ERROR)
    return
  end

  vim.notify("Extracting via Trafilatura...", vim.log.levels.INFO)

  local python_script = string.format(
    [[
import sys
import trafilatura

try:
    # Fetch content with built-in spoofed user-agent
    downloaded = trafilatura.fetch_url('%s')
    if downloaded is None:
        print("ERROR: Website rejected the direct connection payload.", file=sys.stderr)
        sys.exit(1)
        
    # Extract structural layout into clean markdown flow
    result = trafilatura.extract(
        downloaded, 
        output_format="markdown",
        include_links=True,
        include_images=False
    )
    
    if result:
        print(result)
    else:
        print("ERROR: Trafilatura could not isolate the main text body.", file=sys.stderr)
except Exception as e:
    print(f"ERROR: {str(e)}", file=sys.stderr)
  ]],
    url
  )

  vim.fn.jobstart({ "python3", "-c", python_script }, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if not data or #data == 0 or (#data == 1 and data[1] == "") then
        return
      end
      if data[1]:match("^ERROR:") then
        return
      end -- Handled by stderr mapping

      if insert_at_cursor then
        local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
        vim.api.nvim_buf_set_lines(0, row, row, false, data)
      else
        local filename = "ReadItLater_" .. os.date("%Y%m%d%H%M%S") .. ".md"
        vim.cmd("edit " .. filename)
        vim.api.nvim_buf_set_lines(0, 0, -1, false, data)
      end
      vim.notify("Article imported successfully!", vim.log.levels.INFO)
    end,
    on_stderr = function(_, data)
      if data and #data > 0 and data[1] ~= "" then
        vim.notify(table.concat(data, "\n"), vim.log.levels.ERROR)
      end
    end,
  })
end

-- Keybind registrations
vim.keymap.set("n", "<leader>orn", function()
  local_readitlater(false)
end, { desc = "Clip to New Note" })
vim.keymap.set("n", "<leader>ori", function()
  local_readitlater(true)
end, { desc = "Clip and Insert at Cursor" })

-- 2. Core Native Obsidian Mappings (Fixed space-separated subcommands)
vim.keymap.set("n", "<leader>oo", "<cmd>Obsidian open<cr>", { desc = "Open in Desktop App" })
vim.keymap.set("n", "<leader>on", "<cmd>Obsidian new<cr>", { desc = "New Note" })
vim.keymap.set("n", "<leader>ow", "<cmd>Obsidian quick_switch<cr>", { desc = "Quick Switcher (Vault)" })
vim.keymap.set("n", "<leader>os", "<cmd>Obsidian search<cr>", { desc = "Search Text in Vault" })
vim.keymap.set("n", "<leader>of", "<cmd>Obsidian follow_link<cr>", { desc = "Follow Link Under Cursor" })
vim.keymap.set("n", "<leader>ob", "<cmd>Obsidian backlinks<cr>", { desc = "Show Backlinks" })
vim.keymap.set("n", "<leader>ot", "<cmd>Obsidian tags<cr>", { desc = "Search/List Tags" })
vim.keymap.set("n", "<leader>oT", "<cmd>Obsidian template<cr>", { desc = "Insert Template" })

-- Daily Note Management
vim.keymap.set("n", "<leader>od", "<cmd>Obsidian today<cr>", { desc = "Daily Note (Today)" })
vim.keymap.set("n", "<leader>oy", "<cmd>Obsidian yesterday<cr>", { desc = "Daily Note (Yesterday)" })
vim.keymap.set("n", "<leader>om", "<cmd>Obsidian tomorrow<cr>", { desc = "Daily Note (Tomorrow)" })
vim.keymap.set("n", "<leader>op", "<cmd>MarkdownPreview<cr>", { desc = "Mark Down Preview" })

-- Visual Mode Mappings (For linking text blocks/refactoring)
vim.keymap.set("v", "<leader>ol", "<cmd>Obsidian link<cr>", { desc = "Link Text to Existing Note" })
vim.keymap.set("v", "<leader>oc", "<cmd>Obsidian link_new<cr>", { desc = "Create Note from Selection" })
vim.keymap.set("v", "<leader>ox", "<cmd>Obsidian extract_note<cr>", { desc = "Extract Selection to Note" })
