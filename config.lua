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

vim.opt.wrap = true

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
lvim.keys.normal_mode["<C-c>"] = "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>"
lvim.keys.visual_mode["<C-c>"] = "<ESC><CMD>lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>"
lvim.keys.normal_mode["<F2>"] = "<cmd>edit " .. get_config_dir() .. "/config.lua<cr>"
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymapping
lvim.keys.normal_mode["<C-q>"] = ":q<cr>"

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
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0
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
  {"ldelossa/litee.nvim",
    require('litee.lib').setup({})},
  {"ldelossa/litee-calltree.nvim",
    require('litee.calltree').setup({})},
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
  {"mg979/vim-visual-multi"} -- multi cursor
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
-- debug python (pudb)
-- python -m pudb your_script.py
