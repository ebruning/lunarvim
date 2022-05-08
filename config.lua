--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = 'gruvbox-material'

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["zf"] = ":Telekasten find_notes<cr>"
lvim.keys.normal_mode["zd"] = ":Telekasten find_daily_notes<cr>"
lvim.keys.normal_mode["zg"] = ":Telekasten search_notes<cr>"
lvim.keys.normal_mode["zz"] = ":Telekasten follow_link<cr>"
lvim.keys.normal_mode["z"] = ":Telekasten panel<cr>"

vim.opt.cursorline = false

lvim.line_wrap_cursor_movement = false
lvim.lsp.diagnostics.virtual_text = true

-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
  -- for input mode
  i = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
    ["<C-n>"] = actions.cycle_history_next,
    ["<C-p>"] = actions.cycle_history_prev,
  },
  -- for normal mode
  n = {
    ["<C-j>"] = actions.move_selection_next,
    ["<C-k>"] = actions.move_selection_previous,
  },
}

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
  name = "+Trouble",
  r = { "<cmd>Trouble lsp_references<cr>", "References" },
  f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
  d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
  q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
  l = { "<cmd>Trouble loclist<cr>", "LocationList" },
  w = { "<cmd>Trouble workspace_diagnostics<cr>", "Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
-- lvim.builtin.dashboard.active = true
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- Lualine
lvim.builtin.lualine.style = "default"
-- local components = require("lvim.core.lualine.components")
-- lvim.builtin.lualine.sections.lualine_a = { "mode" }
-- lvim.builtin.lualine.sections.lualine_y = {
-- components.spaces,
-- components.location
-- }

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheRest` to take effect.
-- See the full default list `:lua print(vim.inspect(lvim.lsp.override))`
-- vim.list_extend(lvim.lsp.override, { "pyright" })

-- ---@usage setup a server -- see: https://www.lunarvim.org/languages/#overriding-the-default-configuration
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pylsp", opts)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "black", filetypes = { "python" } },
  -- { command = "isort", filetypes = { "python" } },
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--print-with", "100" },
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "typescript", "typescriptreact" },
  },
}

-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "flake8", filetypes = { "python" } },
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
    extra_args = { "--severity", "warning" },
  },
  {
    command = "codespell",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    filetypes = { "javascript", "python" },
  },
}

-- Additional Plugins
lvim.plugins = {
  { "sainnhe/gruvbox-material" },
  { "renerocksai/calendar-vim" },
  { "nvim-telescope/telescope-media-files.nvim" },
  { "renerocksai/telekasten.nvim" },
  { "folke/trouble.nvim" },
  { "LunarVim/onedarker" },
}

-- require('telescope').load_extension('media_files')

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

-- local home = vim.fn.expand("~/zettelkasten")
-- require('telekasten').setup({
--    home         = home,

--    -- if true, telekasten will be enabled when opening a note within the configured home
--    take_over_my_home = true,

--    -- auto-set telekasten filetype: if false, the telekasten filetype will not be used
--    --                               and thus the telekasten syntax will not be loaded either
--    auto_set_filetype = true,

--    -- dir names for special notes (absolute path or subdir name)
--    dailies      = home .. '/' .. 'daily',
--    weeklies     = home .. '/' .. 'weekly',
--    templates    = home .. '/' .. 'templates',

--    -- image (sub)dir for pasting
--    -- dir name (absolute path or subdir name)
--    -- or nil if pasted images shouldn't go into a special subdir
--    image_subdir = "img",

--    -- markdown file extension
--    extension    = ".md",

--    -- following a link to a non-existing note will create it
--    follow_creates_nonexisting = true,
--    dailies_create_nonexisting = true,
--    weeklies_create_nonexisting = true,

--    -- template for new notes (new_note, follow_link)
--    -- set to `nil` or do not specify if you do not want a template
--    template_new_note = home .. '/' .. 'templates/new_note.md',

--    -- template for newly created daily notes (goto_today)
--    -- set to `nil` or do not specify if you do not want a template
--    template_new_daily = home .. '/' .. 'templates/daily.md',

--    -- template for newly created weekly notes (goto_thisweek)
--    -- set to `nil` or do not specify if you do not want a template
--    template_new_weekly= home .. '/' .. 'templates/weekly.md',

--    -- image link style
--    -- wiki:     ![[image name]]
--    -- markdown: ![](image_subdir/xxxxx.png)
--    image_link_style = "markdown",

--    -- integrate with calendar-vim
--    plug_into_calendar = true,
--    calendar_opts = {
--        -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
--        weeknm = 4,
--        -- use monday as first day of week: 1 .. true, 0 .. false
--        calendar_monday = 1,
--        -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
--        calendar_mark = 'left-fit',
--    },

--    -- telescope actions behavior
--    close_after_yanking = false,
--    insert_after_inserting = true,

--    -- tag notation: '#tag', ':tag:', 'yaml-bare'
--    tag_notation = "#tag",

--    -- command palette theme: dropdown (window) or ivy (bottom panel)
--    command_palette_theme = "ivy",

--    -- tag list theme:
--    -- get_cursor: small tag list at cursor; ivy and dropdown like above
--    show_tags_theme = "ivy",

--    -- when linking to a note in subdir/, create a [[subdir/title]] link
--    -- instead of a [[title only]] link
--    subdirs_in_links = true,

--    -- template_handling
--    -- What to do when creating a new note via `new_note()` or `follow_link()`
--    -- to a non-existing note
--    -- - prefer_new_note: use `new_note` template
--    -- - smart: if day or week is detected in title, use daily / weekly templates (default)
--    -- - always_ask: always ask before creating a note
--    template_handling = "smart",

--    -- path handling:
--    --   this applies to:
--    --     - new_note()
--    --     - new_templated_note()
--    --     - follow_link() to non-existing note
--    --
--    --   it does NOT apply to:
--    --     - goto_today()
--    --     - goto_thisweek()
--    --
--    --   Valid options:
--    --     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
--    --              all other ones in home, except for notes/with/subdirs/in/title.
--    --              (default)
--    --
--    --     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
--    --                    except for notes with subdirs/in/title.
--    --
--    --     - same_as_current: put all new notes in the dir of the current note if
--    --                        present or else in home
--    --                        except for notes/with/subdirs/in/title.
--    new_note_location = "smart",

--    -- should all links be updated when a file is renamed
--    rename_update_links = true,
-- })

-- Vim config {{{1
-- vim.cmd('source ~/.config/lvim/user.vim')
vim.cmd('source ~/.config/lvim/lua/user/lualine.lua')
-- }}}1
