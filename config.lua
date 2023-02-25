-- Initial Setup Instructions For Clean Install Of LunarVim
--[[
    - Install LunarVim using instructions from:
        https://www.lunarvim.org/docs/installation
    - If not already set, in the powershell profile, add:
        'Set-Alias lvim 'C:\Users\USERNAME\.local\bin\lvim.ps1' to the profile
    - Configuration file for LunarVim (to put your settings) can be found at:
        'C:\Users\USERNAME\AppData\Local\lvim\config.lua'
    - Possibly run ':PackerSync' if needed
    - If you receive an error saying '... is not a valid Win32 application':
        Follow the troubleshooting steps from:
            https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support#Troubleshooting
        May have to run ':TSInstall lua' a few times, idk
    - If C++'s bits\stdc++.h cannot be found, put a copy of it into:
        'C:\Program Files\LLVM\lib\clang\15.0.7\include\bits\'
    - To add a LunarVim logo to the dashboard, add the ASCII art to:
        'C:\Users\USERNAME\AppData\Roaming\lunarvim\lvim\lua\lvim\core\alpha\dashboard.lua'
	"██╗      ██╗   ██╗ ███╗   ██╗  █████╗  ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
	"██║      ██║   ██║ ████╗  ██║ ██╔══██╗ ██╔══██╗ ██║   ██║ ██║ ████╗ ████║",
	"██║      ██║   ██║ ██╔██╗ ██║ ███████║ ██████╔╝ ██║   ██║ ██║ ██╔████╔██║",
	"██║      ██║   ██║ ██║╚██╗██║ ██╔══██║ ██╔══██╗ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
	"███████╗ ╚██████╔╝ ██║ ╚████║ ██║  ██║ ██║  ██║  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
	"╚══════╝  ╚═════╝  ╚═╝  ╚═══╝ ╚═╝  ╚═╝ ╚═╝  ╚═╝   ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
	"                                                                  ",
]]



-- Enable powershell as your default shell
vim.opt.shell = "pwsh.exe -NoLogo"
vim.opt.shellcmdflag =
  "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;"
vim.cmd [[
		let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
		set shellquote= shellxquote=
  ]]

-- Set a compatible clipboard manager
vim.g.clipboard = {
  copy = {
    ["+"] = "win32yank.exe -i --crlf",
    ["*"] = "win32yank.exe -i --crlf",
  },
  paste = {
    ["+"] = "win32yank.exe -o --lf",
    ["*"] = "win32yank.exe -o --lf",
  },
}

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = false
-- lvim.colorscheme = "lunar"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = false
-- lvim.builtin.terminal.shell = "pwsh.exe -NoLogo"

-- nvim-tree has some performance issues on windows, see kyazdani42/nvim-tree.lua#549
lvim.builtin.nvimtree.setup.diagnostics.enable = nil
lvim.builtin.nvimtree.setup.filters.custom = nil
lvim.builtin.nvimtree.setup.git.enable = nil
lvim.builtin.nvimtree.setup.update_cwd = nil
lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = nil
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.highlight_git = nil
lvim.builtin.nvimtree.setup.renderer.icons.show.git = nil

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "c",
  "lua",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
-- lvim.lsp.installer.setup.ensure_installed = {
--     "sumneko_lua",
--     "jsonls",
-- }
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

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
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--   { command = "black", filetypes = { "python" } },
--   { command = "isort", filetypes = { "python" } },
--   {
--     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "prettier",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--print-with", "100" },
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "typescript", "typescriptreact" },
--   },
-- }

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
-- lvim.plugins = {
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })





-- begin custom settings
lvim.colorscheme = "vscode"

-- basic setup commands
    local comm = vim.api.nvim_command
    comm('set relativenumber number')
    -- comm('set whichwrap+=<,>,[,]')
    comm('set whichwrap-=h,l')
    comm('set shiftwidth=4')
    comm('set tabstop=4')
    comm('set expandtab')
    comm('set softtabstop=4')
    comm('set autoindent')
    comm('set smartindent')
    comm('set noerrorbells')
    comm('set nowrap')
    -- C++ auto compile keymap
    comm("autocmd filetype cpp nnoremap <F5> :w <bar> !g++ -std=c++17 -O2 -Wall % -o %:r<CR>")

-- basic keybindings
    local map = vim.api.nvim_set_keymap
    local defaults = { noremap = true, silent = true }
    map("i", "jk", "<Esc>l", defaults)
    map("i", "kj", "<Esc>l", defaults)
    map("n", "H", "^", defaults)
    map("n", "L", "$", defaults)



-- Additional Plugins
    lvim.plugins = {
        {
            -- VSCode theme
            'Mofiqul/vscode.nvim',
        },
        {
            -- Easier movement using 'f'
            'unblevable/quick-scope',
            -- Highlights unique characters so you can 'f' to a word rather than spamming 'w'
        },
        {
            -- Automatically generates annotations for classes, functions, etc.
            'danymat/neogen',
            config = function()
                require('neogen').setup({})
            end,
            requires = 'nvim-treesitter/nvim-treesitter',
            -- Generate annoations for the function/class the cursor is at with ':Neogen'
        },
        {
            -- Improves nvim-treesitter
            'nvim-treesitter/nvim-treesitter-textobjects',
            after = 'nvim-treesitter',
            requires = 'nvim-treesitter/nvim-treesitter',
        },
        {
            -- Colorizes hexadecimal values for CSS
            'norcalli/nvim-colorizer.lua',
            config = function()
                require('colorizer').setup()
            end,
        },
        {
            -- Highlights comments for TODO, HACK, BUG, etc. 
            'folke/todo-comments.nvim',
            requires = 'nvim-lua/plenary.nvim',
            config = function()
                require('todo-comments').setup({})
            end,
            -- Must put the ':' after TODO, HACK, BUG, etc.
        },
        {
            -- Allows '.' repeating for non-native keymaps
            'tpope/vim-repeat',
        },
        {
            -- Visually peek lines of code when using ':<line number>'
            'nacro90/numb.nvim',
            config = function()
                require('numb').setup()
            end,
        },
        {
            -- Discord presence for Neovim
            'andweeb/presence.nvim',
        },
        {
            -- Better virtual text displaying
            'Hrle97/nvim.diagnostic_virtual_text_config',
            config = function()
                require('nvim.diagnostic_virtual_text_config').setup({})
            end,
        },
        {
            -- Git commands within Neovim
            'tpope/vim-fugitive',
        },
        {
            -- TODO: Not working
            -- Easier window jumping
            'kylechiu3201/nvim-window',
            -- Use <C-W> then whatever letter that corresponds to the desired window
        },
        {
            -- TODO: Not working
            -- HTML automatic tag closing
            'windwp/nvim-ts-autotag',
            config = function()
                require('nvim-ts-autotag').setup()
            end,
        },
        {
            -- TODO: Check what it should look like
            -- Better diagnostic and quickfix menu
            'folke/trouble.nvim',
            requires = 'nvim-tree/nvim-web-devicons',
            config = function()
                require('trouble').setup({})
            end,
        },
        {
            -- Creates a comment frame for commenting
            's1n7ax/nvim-comment-frame',
            requires = { 'nvim-treesitter' },
            config = function()
                require('nvim-comment-frame').setup()
            end,
            -- TODO: cf and cm are unavailable as keymaps
            -- Use '<leader>cf' for a single line comment frame
            -- Use '<leader>cm' for a multi-line comment frame
        },
        {
            -- TODO: might have issue with '~' folder stuff
            -- Auto session management
            'rmagatti/auto-session',
            config = function()
                require('auto-session').setup({
                    log_level = 'error',
                    auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
                })
            end,
        },
        {
            -- TODO: Sometimes works, sometimes doesn't
            -- Underlines occurrences of current word under cursor
            'yamatsum/nvim-cursorline',
            config = function()
                require('nvim-cursorline').setup({})
            end,
        },
        {
            -- TODO: Not working rn
            -- Dims inactive windows
            'sunjon/shade.nvim',
            config = function()
                require('shade').setup({})
            end,
        },
        {
            -- TODO: Not sure if currently working or not
            -- Automatically formats code
            'sbdchd/neoformat',
            -- Use with ':Neoformat' to format current buffer or ':Neoformat xxx' to use xxx as formatter
        },
        {
            -- TODO: Not working rn, don't know why
            -- Dim unused variables, functions, etc.
            'narutoxy/dim.lua',
            requires = { 'nvim-treesitter/nvim-treesitter', 'neovim/nvim-lspconfig' },
            config = function()
                require('dim').setup({})
            end,
        },
        -- TODO: currently not working, causing errors
        -- {
        --     -- Needed for 'range-highlight.nvim'
        --     'winston0410/cmd-parser.nvim',
        -- },
        -- {
        --     -- Highlights the line ranges typed into ':'
        --     'winston0410/range-highlight.nvim',
        --     config = function()
        --         require('range-highlight').setup({})
        --     end,
        -- },
        -- TODO: NOT DONE YET
        -- need to add promise-async and also possible configs, but kinda complex rn
        -- {
            -- Nicer folding
            -- 'kevinhwang91/nvim-ufo',
            -- requires = 'kevinhwang91/promise-async',
        -- },
        -- TODO: might have issues?
        -- TODO: add how to use
        -- {
            -- Fast movements
            -- 'ggandor/leap.nvim',
            -- config = function()
            --     require('leap').add_default_mappings()
            -- end,
            -- Use 's' to search forward, 'S' for backwards
            -- 
        -- },
        -- TODO: minimal configuration?
        -- {
            -- 'gelguy/wilder.nvim',
            -- config = function()
                -- 
            -- end
        -- },
    }



-- Plugin Settings
    -- TreeSitter
        -- fixes treesitter/lsp bug ('... is not a valid Win32 application')
        require 'nvim-treesitter.install'.compilers = { "clang" }

    -- Which-Key Keybindings
        local wk = require('which-key')
        -- e.g. mapping 'gy' to ':%y+<CR>'
        wk.register(
            {
                f = { 'gf', 'Opens file path in a new buffer' },
                y = { '<cmd>%y+<CR>', 'Copy entire file into clipboard' },
            },
            {
                prefix = 'g'
            }
        )
