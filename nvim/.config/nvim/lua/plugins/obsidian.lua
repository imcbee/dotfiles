-- Define the helper function outside the return table.
-- This satisfies the LSP scope rules and keeps the type strictly as a string.
local function get_ordinal_alias(format_str)
  local day = tonumber(os.date("%d")) or 1
  local suffix = "th"

  if day < 10 or day > 20 then
    local remainder = day % 10
    if remainder == 1 then
      suffix = "st"
    elseif remainder == 2 then
      suffix = "nd"
    elseif remainder == 3 then
      suffix = "rd"
    end
  end

  -- ✅ Fix: Wrap the gsub in parentheses to discard the substitution count integer
  local clean_format = (format_str:gsub("Do", day .. suffix))

  -- Now os.date() only receives 1 argument and correctly uses the current time
  return tostring(os.date(clean_format))
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  -- ft = "markdown",
  event = {
    "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Obsidian/**/*.md",
    "BufNewFile " .. vim.fn.expand("~") .. "/Documents/Obsidian/**/*.md",
  },
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    -- "hrsh7th/nvim-cmp",
    -- "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- "ibhagwan/fzf-lua",
    "folke/snacks.nvim",
    "Saghen/blink.cmp",
    -- see below for full list of optional dependencies 👇
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "work",
        path = "~/Documents/Obsidian",
      },
    },
    log_level = vim.log.levels.INFO,
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "Daily Notes",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y/%m - %b/%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, default tags to add to each new daily note created.
      default_tags = { "daily-notes" },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = "Templates/Daily Notes",
    },
    ui = { enable = false },
    templates = {
      folder = "Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {
        vod = function()
          -- 1. Sync-fetch the text payload via curl
          local handle = io.popen("curl -s --max-time 3 'https://beta.ourmanna.com/api/v1/get?format=json&order=daily'")
          if not handle then
            return ""
          end
          local result = handle:read("*a")
          handle:close()

          -- 2. Safely parse JSON data using Neovim's native runtime
          local ok, parsed = pcall(vim.json.decode, result)
          if not ok or not parsed or not parsed.verse or not parsed.verse.details then
            return "> [!warning] Verse of the Day\n> *Could not fetch scripture (Offline)*"
          end

          local details = parsed.verse.details
          local text = details.text
          local ref = details.reference

          -- 3. Extract the verse number from the end of the reference string
          -- Handles single verses (":1") and ranges (":1-3")
          local verse_num = ref:match(":([%d%-]+)%s*$") or ""
          local verse_prefix = verse_num ~= "" and ("<sup>**" .. verse_num .. "**</sup> ") or ""

          -- 4. Extract book titles cleanly for your search index tag (e.g. "2 Corinthians" -> "2Corinthians")
          local book_name = ref:match("^([%a%d%s]+)") or ""
          local clean_tag = book_name:gsub("%s+", "")

          -- 5. Reconstruct the layout with your exact superscript styling
          local callout = {
            "> [!bible]+ Verse of the Day ["
              .. ref
              .. "](https://beta.ourmanna.com/api/v1/get?format=json&order=daily)",
            "> " .. verse_prefix .. text,
            "> %% #" .. clean_tag .. " %%",
          }

          return table.concat(callout, "\n")
        end,

        -- Fixed: Coerced to string to satisfy string? annotation
        year = function()
          return tostring(os.date("%Y"))
        end,

        -- Fixed: Wrapped math operation in tostring() to fix integer mismatch
        quarter = function()
          local month = tonumber(os.date("%m")) or 1
          return tostring(math.ceil(month / 3))
        end,

        -- Fixed: Now correctly calls the local scoped helper function
        long_alias = function()
          return get_ordinal_alias("%A Do %B %Y")
        end,

        short_alias = function()
          return get_ordinal_alias("%a Do %b %Y")
        end,

        yesterday = function()
          return tostring(os.date("%Y-%m-%d", os.time() - 86400))
        end,

        -- Replaces: <% tp.date.now("YYYY-MM-DD", 1) %>
        tomorrow = function()
          return tostring(os.date("%Y-%m-%d", os.time() + 86400))
        end,
      },
    },
    -- see below for full list of options 👇
    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = "snacks.picker",
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = "<C-x>",
        -- Insert a tag at the current location.
        insert_tag = "<C-l>",
      },
    },
    -- Optional, by default, `:ObsidianBacklinks` parses the header under
    -- the cursor. Setting to `false` will get the backlinks for the current
    -- note instead. Doesn't affect other link behaviour.
    backlinks = {
      parse_headers = true,
    },

    -- Optional, determines how certain commands open notes. The valid options are:
    -- 1. "current" (the default) - to always open in the current window
    -- 2. "vsplit" - only open in a vertical split if a vsplit does not exist.
    -- 3. "hsplit" - only open in a horizontal split if a hsplit does not exist.
    -- 4. "vsplit_force" - always open a new vertical split if the file is not in the adjacent vsplit.
    -- 5. "hsplit_force" - always open a new horizontal split if the file is not in the adjacent hsplit.
    open_notes_in = "current",

    attachments = {
      folder = "assets",
      confirm_img_paste = false,
    },
    footer = {
      enabled = true,
      format = "{{backlinks}} backlinks  {{properties}} properties  {{words}} words  {{chars}} chars",
      hl_group = "Comment",
      separator = string.rep("-", 80),
    },
    checkbox = {
      order = { " ", "~", "!", ">", "x" },
    },
  },
}
