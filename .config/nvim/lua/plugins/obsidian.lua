return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  cmd = {
    "ObsidianOpen",
    "ObsidianQuickSwitch",
    "ObsidianNew",
    "ObsidianSearch",
    "ObsidianTemplate",
    "ObsidianToday",
    "ObsidianTomorrow",
    "ObsidianYesterday",
  },
  ft = "markdown",
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
    "hrsh7th/nvim-cmp",
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
    -- legacy_commands = false,
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
    completion = {
      -- Enables completion using nvim_cmp
      nvim_cmp = false,
      -- Enables completion using blink.cmp
      blink = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
      -- Set to false to disable new note creation in the picker
      create_new = true,
    },
    templates = {
      folder = "Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },

    ---@class obsidian.config.OpenOpts
    ---
    ---Opens the file with current line number
    ---@field use_advanced_uri? boolean
    ---
    ---Function to do the opening, default to vim.ui.open
    ---@field func? fun(uri: string)
    open = {
      use_advanced_uri = false,
      func = vim.ui.open,
    },
    -- see below for full list of options 👇
    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = "snacks.pick",
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

    ---@class obsidian.config.AttachmentsOpts
    ---
    ---Default folder to save images to, relative to the vault root.
    ---@field img_folder? string
    ---
    ---Default name for pasted images
    ---@field img_name_func? fun(): string
    ---
    ---Default text to insert for pasted images, for customizing, see: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Images
    ---@field img_text_func? fun(path: obsidian.Path): string
    ---
    ---Whether to confirm the paste or not. Defaults to true.
    ---@field confirm_img_paste? boolean
    attachments = {
      folder = "assets/imgs",
      img_name = function()
        return string.format("Pasted image %s", os.date("%Y%m%d%H%M%S"))
      end,
      confirm_img_paste = true,
    },

    -- ---@deprecated in favor of the footer option below
    -- statusline = {
    --   enabled = true,
    --   format = "{{properties}} properties {{backlinks}} backlinks {{words}} words {{chars}} chars",
    -- },

    ---@class obsidian.config.FooterOpts
    ---
    ---@field enabled? boolean
    ---@field format? string
    ---@field hl_group? string
    ---@field separator? string|false Set false to disable separator; set an empty string to insert a blank line separator.
    footer = {
      enabled = true,
      format = "{{backlinks}} backlinks  {{properties}} properties  {{words}} words  {{chars}} chars",
      hl_group = "Comment",
      separator = string.rep("-", 80),
    },
    ---@class obsidian.config.CheckboxOpts
    ---
    ---Order of checkbox state chars, e.g. { " ", "x" }
    ---@field order? string[]
    checkbox = {
      order = { " ", "~", "!", ">", "x" },
    },
  },
}
