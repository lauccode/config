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
lvim.format_on_save = false
lvim.colorscheme = "onedarker"

vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert 2 spaces for a tab

vim.opt.wrap = true
vim.opt.linebreak = true
-- gj,gk to move up dans down in the wrap line

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
-- lvim.keys.insert_mode = {
-- lvim.keys.normal_mode = {
-- lvim.keys.term_mode = {
-- lvim.keys.visual_mode = {
-- lvim.keys.visual_block_mode = {

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-k>"] = "dd"

vim.keys.normal_mode["jj"] = "<Esc>"

-- lvim.keys.normal_mode["<C-c>"] = "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>"
-- lvim.keys.visual_mode["<C-c>"] = "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>"
-- lvim.keys.normal_mode["<C-c>"] = "<cmd>lua require('Comment.api').toggle.linewise()<CR>"           
-- lvim.keys.visual_mode["<C-c>"] = "<ESC><CMD>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>"
lvim.keys.normal_mode["cc"] = "<cmd>lua require('Comment.api').toggle.linewise()<CR>"           
lvim.keys.visual_mode["cc"] = "<ESC><CMD>lua require('Comment.api').toggle.blockwise(vim.fn.visualmode())<CR>"
lvim.keys.normal_mode["<F2>"] = "<cmd>edit " .. get_config_dir() .. "/config.lua<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
lvim.keys.normal_mode["<C-q>"] = ":bd<cr>"

vim.cmd 'nnoremap * :keepjumps normal! mi*`i<CR>'  -- no search forward with '*'
lvim.keys.normal_mode["<S-w>"] = "viw\"0p"  -- paste word of buffer 0 on word you are on it.(* before and n after for other word)
-- yiw  yank inside word
-- * on word to change
-- <S-w> to paste new word
-- n to do it on next word

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

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
-- }

lvim.builtin.which_key.mappings["i"] = {
  name = "+call",
  i = { "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", "incoming calls" },
  o = { "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>", "outgoing_calls" },
  O = { "<cmd>LTPopOutCalltree<CR>", "open call-tree" },
}
lvim.builtin.which_key.mappings["*"] = { "<cmd>Telescope grep_string<cr>", "grep string under cursor" }
lvim.builtin.which_key.mappings["F"] = { "<cmd>SymbolsOutline<cr>", "Function list on the right" }

vim.cmd 'packadd cfilter'  -- allow filter on quickfix list (:Cfilter cpp, colder to go back)

vim.cmd 'set list!'  -- show invisible character
vim.cmd 'set lcs=tab:»_,trail:·'  -- set lcs=tab:»_,trail:·,eol:$
vim.cmd 'set relativenumber'

-- vimscript command !!!
vim.cmd 'packadd termdebug'
vim.cmd 'noremap <F9> :Break<cr>'
vim.cmd 'noremap <F8> :Clear<cr>'
vim.cmd 'noremap <F10> :Over<cr>'
vim.cmd 'noremap <F12> :Step<cr>'
vim.cmd 'noremap <F5> :Continue<cr>'
vim.cmd 'noremap <F6> :Run<cr>'
vim.cmd 'noremap <F4> :Evaluate<cr>'

vim.cmd 'let g:termdebug_wide = 1'  -- =163 for inversed layout

-- autocmd colorscheme * :hi debugPC term=reverse ctermbg=darkblue guibg=red
vim.api.nvim_command([[
    augroup ChangeBackgroudColour
        autocmd colorscheme * :hi debugPC guibg=green
    augroup END
]])


-- To map <Esc> to exit terminal-mode:
vim.cmd 'tnoremap <Esc> <C-\\><C-n>'
-- To simulate |i_CTRL-R| in terminal-mode:
-- vim.cmd 'tnoremap <expr> <C-R> '<C-\\><C-N>"'.nr2char(getchar()).'pi''
-- To use `ALT+{h,j,k,l}` to navigate windows from any mode:
vim.cmd 'tnoremap <A-h> <C-\\><C-N><C-w>h'
vim.cmd 'tnoremap <A-j> <C-\\><C-N><C-w>j'
vim.cmd 'tnoremap <A-k> <C-\\><C-N><C-w>k'
vim.cmd 'tnoremap <A-l> <C-\\><C-N><C-w>l'
vim.cmd 'inoremap <A-h> <C-\\><C-N><C-w>h'
vim.cmd 'inoremap <A-j> <C-\\><C-N><C-w>j'
vim.cmd 'inoremap <A-k> <C-\\><C-N><C-w>k'
vim.cmd 'inoremap <A-l> <C-\\><C-N><C-w>l'
vim.cmd 'nnoremap <A-h> <C-w>h'
vim.cmd 'nnoremap <A-j> <C-w>j'
vim.cmd 'nnoremap <A-k> <C-w>k'
vim.cmd 'nnoremap <A-l> <C-w>l'

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.nvimtree.setup.view.side = "left"                                                                                                         
lvim.builtin.nvimtree.setup.view.adaptive_size = true                                                                                                  
lvim.builtin.nvimtree.setup.view.auto_resize= true                                                                                                     
lvim.builtin.nvimtree.setup.view.resize_window= true                                                                                                   
lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = false                                                                                     
lvim.builtin.project.manual_mode = true  -- ok with nvimtree                                                                                           
lvim.builtin.project.silent_chdir = false                                                                                      
lvim.builtin.project.show_hidden = false

-- lvim.builtin.lualine.style = "default"
lvim.builtin.dap.active = true
lvim.builtin.dapinstall.active = true


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

-- lvim.builtin.telescope.defaults.path_display = {"absolute", "smart"}
lvim.builtin.telescope.defaults={
	find_command = { "fd", "-t=f", "-a" },
	path_display = { "absolute" },
  wrap_results = true
}

-- "z" to have fold menu
vim.opt.foldmethod = "indent"  -- indent, syntax, marker, expr
-- vim.opt.foldexpr = "}"

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---@usage Select which servers should be configured manually. Requires `:LvimCacheReset` to take effect.
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
lvim.plugins = {
  --     {"folke/tokyonight.nvim"},
  --     {
  --       "folke/trouble.nvim",
  --       cmd = "TroubleToggle",
  --     },
  {"ldelossa/litee.nvim"},
  {"ldelossa/litee-calltree.nvim"},
	
  {"sakhnik/nvim-gdb"},
  {
  "nvim-telescope/telescope-project.nvim",
  event = "BufWinEnter",
  display_type = 'full',
  setup = function()
    vim.cmd [[packadd telescope.nvim]]
  end,
  },
  {"ellisonleao/gruvbox.nvim"},
  {"luisiacc/gruvbox-baby"},
  {"sainnhe/gruvbox-material"},
  {"folke/tokyonight.nvim"},
  {"EdenEast/nightfox.nvim"},
  {"savq/melange"},
  {"sainnhe/sonokai"},
  {"sainnhe/everforest"},
  {"Mofiqul/dracula.nvim"},
  {"tamelion/neovim-molokai"},
  {"liuchengxu/vista.vim"}, -- method list with ctags

    -- FOR LITEE (call-tree) (TBT)
    -- configure the litee.nvim library
    -- config = function()
      -- configure litee-calltree.nvim
    -- end,
  {"mg979/vim-visual-multi"}, -- multi cursor
  {
      "folke/persistence.nvim",
      event = "BufReadPre", -- this will only start session saving when an actual file was opened
      module = "persistence",
      config = function()
          require("persistence").setup {
          }
      end,
  },
  {
      "phaazon/hop.nvim",
      event = "BufRead",
      config = function()
          require("hop").setup()
          -- vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
          vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
      end,
  },
     {
         "f-person/git-blame.nvim",
         event = "BufRead",
         config = function()
             vim.cmd "highlight default link gitblame SpecialComment"
             vim.g.gitblame_enabled = 1
         end,
     },
     {  -- color for non lsp colorscheme
         "folke/lsp-colors.nvim",
         event = "BufRead",
     },
     {  -- smooth scrolling
         "karb94/neoscroll.nvim",
         event = "WinScrolled",
         config = function()
             require('neoscroll').setup({
                 -- All these keys will be mapped to their corresponding default scrolling animation
                 mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>',
                     '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
                 hide_cursor = true,          -- Hide cursor while scrolling
                 stop_eof = true,             -- Stop at <EOF> when scrolling downwards
                 use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
                 respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
                 cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
                 easing_function = nil,        -- Default easing function
                 pre_hook = nil,              -- Function to run before the scrolling animation starts
                 post_hook = nil,              -- Function to run after the scrolling animation ends
             })
         end
     },
     {"simrat39/symbols-outline.nvim"},  -- symbol list on the right !
     {"nvim-treesitter/nvim-treesitter"},  -- better syntaxic color
     {"nvim-orgmode/orgmode"},
     {"dhruvasagar/vim-table-mode"},  -- leader + t, table auto for markdown and org
     {"windwp/nvim-spectre"}, -- find and replace all files
     {"osyo-manga/vim-over"} -- substitute with better preview
}
	
  lvim.builtin.which_key.mappings["S"]= {
    name = "Session",
    c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
    l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
    Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
  }
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }

  require("litee.lib").setup({})
  require("litee.calltree").setup({})

-- debug python (pudb)
-- pip install pudb
-- pip install pygame
-- python -m pudb your_script.py
	
-- COLOR FOR LUALINE
-- local colors = {
--   color2 = "#0f1419",
--   -- color3 = "#ffee99",
--   color3 = "green",
--   color4 = "#e6e1cf",
--   color5 = "#14191f",
--   -- color13 = "#b8cc52",
--   color13 = "red",
--   color10 = "#36a3d9",
--   color8 = "#f07178",
--   color9 = "#3e4b59",
-- }
-- lvim.builtin.line.options.theme = {
--   normal = {
--     c = { fg = colors.color9, bg = colors.color2 },
--     a = { fg = colors.color2, bg = colors.color10, gui = "bold" },
--     b = { fg = colors.color4, bg = colors.color5 },
--   },
--   insert = {
--     a = { fg = colors.color2, bg = colors.color13, gui = "bold" },
--     b = { fg = colors.color4, bg = colors.color5 },
--   },
--   visual = {
--     a = { fg = colors.color2, bg = colors.color3, gui = "bold" },
--     b = { fg = colors.color4, bg = colors.color5 },
--   },
--   replace = {
--     a = { fg = colors.color2, bg = colors.color8, gui = "bold" },
--     b = { fg = colors.color4, bg = colors.color5 },
--   },
--   inactive = {
--     c = { fg = colors.color4, bg = colors.color2 },
--     a = { fg = colors.color4, bg = colors.color5, gui = "bold" },
--     b = { fg = colors.color4, bg = colors.color5 },
--   },
-- }

-- ORG MODE
-- init.lua
-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()
-- Tree-sitter configuration
require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}
require('orgmode').setup({
  org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/Dropbox/org/refile.org',
})

lvim.builtin.which_key.mappings["r"]= {                                                                                          
      name = "Spectre",                                                                                                            
      R = { "<cmd>lua require('spectre').open()<CR>", "run command :Spectre" },                                                    
      w = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "search current word" },                            
      c = { "<esc>:lua require('spectre').open_visual()<CR>", "search copy word" },                                                
      f = { "viw:lua require('spectre').open_file_search()<cr>", "search in current file" },                                       
}         
