-- :TSinstall vim ,if there is treesitter errors (with vim.cmd)

-- general
lvim.log.level = "warn"
lvim.format_on_save = false
-- lvim.colorscheme = "onedarker"
-- lvim.colorscheme = "gruvbox"
lvim.colorscheme = "habamax"
-- lvim.colorscheme = "ayu"
-- lvim.colorscheme = "gruvbox-baby"
-- lvim.colorscheme = "gruvbox-material"
-- lvim.colorscheme = "tokyonight"
-- lvim.colorscheme = "tokyonight-night"
-- lvim.colorscheme = "darkblue"
-- lvim.colorscheme = "nightfox"
-- lvim.colorscheme = "melange"
-- lvim.colorscheme = "sonokai"
-- lvim.colorscheme = "everforest"
-- lvim.colorscheme = "dracula"
-- lvim.colorscheme = "neovim-molokai"

vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard

vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert 2 spaces for a tab

vim.opt.wrap = true
vim.opt.linebreak = true -- gj,gk to move up dans down in the wrap line

-- vim.opt.scrolloff = 999  -- always center cursor line vertically / 8 default
vim.opt.scrolloff = 5 -- always center cursor line vertically / 8 default

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
-- lvim.keys.normal_mode["<c-s>"] = ":w<cr>"
-- Toggle current line (linewise) using C-/
-- Toggle current line or with count
vim.keymap.set('n', 'cc', function()
    return vim.v.count == 0
        and '<Plug>(comment_toggle_linewise_current)'
        or '<Plug>(comment_toggle_linewise_count)'
end, { expr = true })
-- Toggle in VISUAL mode
vim.keymap.set('x', 'cc', '<Plug>(comment_toggle_linewise_visual)')

lvim.keys.insert_mode[",,"] = "<Esc>"
lvim.keys.insert_mode["ù"] = "<Esc>"
lvim.keys.insert_mode["ùù"] = "<Esc>"
lvim.keys.visual_mode["ù"] = "<Esc>"
lvim.keys.visual_mode["ùù"] = "<Esc>"

lvim.keys.normal_mode["<F2>"] = "<cmd>edit " .. get_config_dir() .. "/config.lua<cr>"

vim.cmd 'nnoremap * :keepjumps normal! mi*`i<CR>' -- no search forward with '*'
lvim.keys.normal_mode["<S-w>"] = "viw\"0p" -- paste word of buffer 0

-- yiw  yank inside word
-- * on word to change
-- <S-w> to paste new word
-- n to do it on next word

lvim.builtin.which_key.setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = true, -- adds help for operators like d, y, ...
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
        spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
    }
}

lvim.builtin.which_key.mappings["i"] = {
    name = "+call",
    i = { "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", "incoming calls" },
    o = { "<cmd>lua vim.lsp.buf.outgoing_calls()<CR>", "outgoing_calls" },
    O = { "<cmd>LTPopOutCalltree<CR>", "open call-tree" },
}

lvim.builtin.which_key.mappings["m"] = { "<cmd>Telescope marks<cr>", "marks" }
lvim.builtin.which_key.mappings["*"] = { "<cmd>Telescope grep_string<cr>", "grep string under cursor" }
lvim.builtin.which_key.mappings["F"] = { "<cmd>SymbolsOutline<cr>", "Function list on the right" }
lvim.builtin.which_key.mappings["sF"] = { "<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "Find File Everywhere" }
lvim.builtin.which_key.mappings["sT"] = {
  function()
    require("telescope.builtin").live_grep {
     additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
    }
  end,
  "Text Everywhere",
}

vim.cmd 'packadd cfilter' -- allow filter on quickfix list (:Cfilter cpp, colder to go back)
vim.cmd 'set list!' -- show invisible character  -- allow filter on quickfix list (:Cfilter cpp, colder to go back)
vim.cmd 'set lcs=tab:»_,trail:·,eol:$'
vim.cmd 'set relativenumber'
vim.cmd 'set inccommand=split' -- preview for substitute commande
vim.cmd 'set cwh=30' -- high for the preview of incommand
vim.cmd 'set makeprg=ninja'
vim.api.nvim_create_user_command('But', function()
    vim.cmd ':Make -C modem/UbtApplication/Test/ U2TestsLinux'
end, { nargs = '*' })
-- build DRAGON
vim.api.nvim_create_user_command('Bd', function()
    vim.cmd '!cd modem/build/linux_zynqmp && ./build.sh all'
end, { nargs = '*' })

-- to use if no dap active
-- vimscript command !!!
-- vim.cmd 'packadd termdebug'
-- vim.cmd 'noremap <F9> :Break<cr>'
-- vim.cmd 'noremap <F8> :Clear<cr>'
-- vim.cmd 'noremap <F10> :Over<cr>'
-- vim.cmd 'noremap <F11> :Step<cr>'
-- vim.cmd 'noremap <F5> :Continue<cr>'
-- vim.cmd 'noremap <F6> :Run<cr>'
-- vim.cmd 'noremap <F4> :Evaluate<cr>'

-- vim.cmd 'let g:termdebug_popup = 0'
vim.cmd 'let g:termdebug_wide = 1' -- =163 for inversed layout
-- lvim.termdebug_wild = 1

-- autocmd colorscheme * :hi debugPC term=reverse ctermbg=darkblue guibg=red
vim.api.nvim_command([[
    augroup ChangeBackgroudColour
    autocmd colorscheme * :hi debugPC guibg=green
    augroup END
]])

-- -- To map <Esc> to exit terminal-mode:
vim.cmd 'tnoremap <Esc> <C-\\><C-n>'
-- -- To simulate |i_CTRL-R| in terminal-mode:
-- -- vim.cmd 'tnoremap <expr> <C-R> '<C-\\><C-N>"'.nr2char(getchar()).'pi''
-- -- To use `ALT+{h,j,k,l}` to navigate windows from any mode:
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

vim.cmd 'nnoremap <C-w>m <C-w>\\| <C-w>_' --maximize window

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
-- lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true

-- lvim.builtin.nvimtree.show_icons.git = 0
lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.notify.active = true
-- lvim.builtin.nvimtree.setup.view.width = 50
lvim.builtin.nvimtree.setup.view.adaptive_size = true
-- lvim.builtin.nvimtree.setup.view.auto_resize = true
-- lvim.builtin.nvimtree.setup.view.resize_window = true
lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = false
lvim.builtin.project.manual_mode = true
lvim.builtin.project.silent_chdir = false
lvim.builtin.project.show_hidden = false

-- lvim.builtin.lualine.options.theme = "gruvbox"
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.sections = {
lualine_a = {'mode'},
lualine_b = {'branch', 'diff', 'diagnostics'},
lualine_c = {{'filename', path = 3}},
lualine_x = {'encoding', 'fileformat', 'filetype'},
lualine_y = {'progress'},
lualine_z = {'location'}}


lvim.builtin.dap.active = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "cpp",
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
lvim.builtin.telescope.defaults = {
    -- :h telescope.defaults.path_display
    path_display = { "absolute" },
    wrap_results = true,
    layout_strategy = "vertical",
    -- file_ignore_patterns = {
    --       "common/sgpa/MIB/.*",
    --       ".git/.*",
    --       -- ".txt",
    --       ".bin",
    --       ".json",
    --       ".ninja",
    --       ".obj",
    --       ".vim",
    --       "modem/build/vxworksDiabLinux/symTbl.c"
    --  },
      vimgrep_arguments = {
          'rg',
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
          '--smart-case',
    --       '-u' -- thats the new thing
            },
    dynamic_preview_title = true,

    -- -- find_files={find_command = find_all_files_cmd}

    }
    lvim.builtin.telescope.pickers = { find_files = { hidden = false, no_ignore = false } 
}

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
-- vim.opt.foldlevel = 0

-- "z" to have fold menu
-- vim.opt.foldmethod = "syntax"
-- vim.cmd 'set nofoldenable'
-- vim.opt.foldexpr = "}"

-- Additional Plugins
lvim.plugins = {
    --     {"folke/tokyonight.nvim"},
    --     {
    --       "folke/trouble.nvim",
    --       cmd = "TroubleToggle",
    --     },
    { "ldelossa/litee.nvim",
    config = function()
        -- configure the litee.nvim library·
        require('litee.lib').setup({})
    end,
    },
    { "ldelossa/litee-calltree.nvim" ,
    config = function()
        -- configure litee-calltree.nvim
        require('litee.calltree').setup({})
    end,
    },

    { "sakhnik/nvim-gdb" },
    {
        "nvim-telescope/telescope-project.nvim",
        event = "BufWinEnter",
        setup = function()
            vim.cmd [[packadd telescope.nvim]]
        end,
    },
    { "ellisonleao/gruvbox.nvim" },
    { "luisiacc/gruvbox-baby" },
    { "sainnhe/gruvbox-material" },
    { "folke/tokyonight.nvim" },
    { "EdenEast/nightfox.nvim" },
    { "savq/melange" },
    { "sainnhe/sonokai" },
    { "sainnhe/everforest" },
    { "Mofiqul/dracula.nvim" },
    { "catppuccin/nvim" },
    { "rebelot/kanagawa.nvim" },
    { "tamelion/neovim-molokai" },
    { "liuchengxu/vista.vim" },
    { 'uloco/bluloco.nvim'},
    { 'rktjmp/lush.nvim' }, -- used by bluloco
    -- FOR LITEE (call-tree) (TBT)
    -- configure the litee.nvim library
    -- config = function()
    -- configure litee-calltree.nvim
    -- end,
    { "mg979/vim-visual-multi" },
    {
        "folke/persistence.nvim",
        event = "BufReadPre", -- this will only start session saving when an actual file was opened
        module = "persistence",
        config = function()
            require("persistence").setup {
                dir = vim.fn.expand(vim.fn.stdpath("config") .. "/session/"),
                options = { "buffers", "curdir", "tabpages", "winsize" },
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
    { -- color for non lsp colorscheme
        "folke/lsp-colors.nvim",
        event = "BufRead",
    },
    -- { -- smooth scrolling
    --   "karb94/neoscroll.nvim",
    --   event = "WinScrolled",
    --   config = function()
    --     require('neoscroll').setup({
    --       -- All these keys will be mapped to their corresponding default scrolling animation
    --       mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>',
    --         '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
    --       hide_cursor = true, -- Hide cursor while scrolling
    --       stop_eof = true, -- Stop at <EOF> when scrolling downwards
    --       use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
    --       respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
    --       cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
    --       easing_function = nil, -- Default easing function
    --       pre_hook = nil, -- Function to run before the scrolling animation starts
    --       post_hook = nil, -- Function to run after the scrolling animation ends
    --     })
    --   end
    -- },
    {
        "simrat39/symbols-outline.nvim",
        config = function()
            require('symbols-outline').setup()
        end
    },
    -- {"nvim-treesitter/nvim-treesitter"},
    { "nvim-orgmode/orgmode" },
    { "dhruvasagar/vim-table-mode" }, -- leader + t
    {
        "windwp/nvim-spectre",
        event = "BufRead",
        config = function()
            require('spectre').setup({
            })
        end,
    },
    -- { "osyo-manga/vim-over" }, -- KO : substitute with better preview
    { 'gen740/SmoothCursor.nvim',
        config = function()
            require('smoothcursor').setup(
                {
                    default = {
                        fancy = {
                            enable = false
                        }
                    }
                }

            )
        end
    },
    {"tpope/vim-surround"},
    { "tpope/vim-dispatch" }, -- :Make  (make asynchronoulsy !)
    -- /!\ NOT WORK WITH PackerUpdate/PackerSync 
    -- {--TBT  navigate and highlight matching words
    --    "andymass/vim-matchup",
    --    event = "CursorMoved",
    --    config = function()
    --        vim.g.matchup_matchparen_offscreen = { method = "popup" }
    --    end,
    -- },
    {--TBT better quickfix list
        "kevinhwang91/nvim-bqf",
        event = { "BufRead", "BufNew" },
        config = function()
            require("bqf").setup({
                auto_enable = true,
                preview = {
                    win_height = 12,
                    win_vheight = 12,
                    delay_syntax = 80,
                    border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
                },
                func_map = {
                    vsplit = "",
                    ptogglemode = "z,",
                    stoggleup = "",
                },
                filter = {
                    fzf = {
                        action_for = { ["ctrl-s"] = "split" },
                        extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
                    },
                },
            })
        end,
    },
    { "Luxed/ayu-vim" },
    { "terryma/vim-expand-region" },
    { "kkvh/vim-docker-tools" },
    {
        "folke/todo-comments.nvim",
        event = "BufRead",
        config = function()
             require("todo-comments").setup()
        end,
    },
}

lvim.builtin.which_key.mappings["S"] = {
    name = "Session",
    c = { "<cmd>lua require('persistence').load()<cr>", "Restore last session for current dir" },
    l = { "<cmd>lua require('persistence').load({ last = true })<cr>", "Restore last session" },
    Q = { "<cmd>lua require('persistence').stop()<cr>", "Quit without saving session" },
}

-- check the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.set_keymappings))`
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "clangd" })

local clangd_flags = {
    -- "--header-insertion=iwyu",
    "--query-driver=/usr/bin/c++,/usr/bin/gcc",
    -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
    -- "--fallback-style=Google",
    -- "--header-insertion=never",
    -- "--query-driver=<list-of-white-listed-complers>"
}
local clangd_bin = "/usr/bin/clangd"

local custom_on_attach = function(client, bufnr)
    require("lvim.lsp").common_on_attach(client, bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>lh", "<Cmd>ClangdSwitchSourceHeader<CR>", opts)
end

local opts = {
    cmd = { clangd_bin, unpack(clangd_flags) },
    on_attach = custom_on_attach,
}

require("lvim.lsp.manager").setup("clangd", opts)
-- require("litee.lib").setup({})
-- require("litee.calltree").setup({})

local colors = {
    color2 = "#0f1419",
    -- color3 = "#ffee99",
    color3 = "green",
    color4 = "#e6e1cf",
    color5 = "#14191f",
    -- color13 = "#b8cc52",
    color13 = "red",
    color14 = "orange",
    color15 = "chartreuse",
    color10 = "#36a3d9",
    color8 = "#f07178",
    color9 = "black",
}

lvim.builtin.lualine.options.theme = {
    normal = {
        c = { fg = colors.color4, bg = colors.color2 },
        a = { fg = colors.color2, bg = colors.color10, gui = "bold" },
        b = { fg = colors.color4, bg = colors.color5 },
    },
    insert = {
        a = { fg = colors.color4, bg = colors.color13, gui = "bold" },
        b = { fg = colors.color4, bg = colors.color5 },
        c = { fg = colors.color9, bg = colors.color14 },
    },
    visual = {
        a = { fg = colors.color4, bg = colors.color3, gui = "bold" },
        b = { fg = colors.color4, bg = colors.color5 },
        c = { fg = colors.color9, bg = colors.color15 },
    },
    replace = {
        a = { fg = colors.color2, bg = colors.color8, gui = "bold" },
        b = { fg = colors.color4, bg = colors.color5 },
        c = { fg = colors.color9, bg = colors.color13 },
    },
    inactive = {
        c = { fg = colors.color4, bg = colors.color2 },
        a = { fg = colors.color4, bg = colors.color5, gui = "bold" },
        b = { fg = colors.color4, bg = colors.color5 },
    },
}


-- to alias of shell in vim command with :!
-- vim.cmd 'set shellcmdflag=-ic'

-- ORG MODE
require('orgmode').setup_ts_grammar()
-- Tree-sitter configuration
require 'nvim-treesitter.configs'.setup {
    -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'org' }, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
    },
    ensure_installed = { 'org' }, -- Or run :TSUpdate org
}
require('orgmode').setup({
    org_agenda_files = { '~/Dropbox/org/*', '~/my-orgs/**/*' },
    org_default_notes_file = '~/Dropbox/org/refile.org',
})

lvim.builtin.which_key.mappings["r"] = {
    name = "Spectre",
    R = { "<cmd>lua require('spectre').open()<CR>", "run command :Spectre" },
    w = { "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", "search current word" },
    c = { "<esc>:lua require('spectre').open_visual()<CR>", "search copy word" },
    f = { "viw:lua require('spectre').open_file_search()<cr>", "search in current file" },
}

local retrieveServerAddress = {}
function retrieveServerAddress.input()
    ServerAddress=44203
    vim.ui.input({
        prompt = "Enter a value: ",
        default = ":",
        completion = "file",
        highlight = function(input)
            if string.len(input) > 8 then
                return { { 0, 8, "InputHighlight" } }
            else
                return {}
            end
        end,
    }, function(input)
            if input then
                print("You entered " .. input)
                ServerAddress=input
                -- source again config.lua to update miDebuggerServerAddress
                vim.cmd ':LvimReload'
            else
                print "You cancelled"
            end
        end)
end

vim.api.nvim_create_user_command('Rsa', function()
    retrieveServerAddress.input()
    -- ServerAddress = retrieveServerAddress
end, { nargs = '*' })

lvim.builtin.which_key.mappings["da"] = { ":Rsa<CR>" , "Give server address" }

-- DAP for cpp as in vscode
-- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(gdb-via--vscode-cpptools)
-- https://github.com/memsharded/hello
-- cmake . -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=1

local dap = require('dap')
dap.adapters.cppdbg = {
    id = 'cppdbg',
    type = 'executable',
    command = '/home/login/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7',
}

-- dap = require('dap')
dap.configurations.cpp = {
    {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopAtEntry = false,
        setupCommands = {
            {
                text = '-enable-pretty-printing',
                description =  'enable pretty printing',
                ignoreFailures = true
            },
        },
    },
    {
        name= "Debug UT debian",
        type= "cppdbg",
        request= "launch",
        program= "${workspaceFolder}/path/to/bin",
        args={"SviPerformanceMonitorCodecsTestSuite"},
        stopAtEntry= false,
        cwd= "${workspaceFolder}",
        externalConsole= false,
        MIMode= "gdb",
        setupCommands= {
            {
                text = '-enable-pretty-printing',
                description =  'enable pretty printing',
                ignoreFailures = true
            }
        }
    },
    {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
    },
    {
        name= "Debug SIMU in Docker",
        type= "cppdbg",
        -- type= "cpptools",
        request= "launch",
        program= "${workspaceFolder}/path/to/bin",
        -- miDebuggerServerAddress= dap.input,
        miDebuggerServerAddress = ServerAddress,
        -- miDebuggerServerAddress = ":44249",
        stopAtEntry= false,
        cwd= "${workspaceFolder}",
        -- environment= "[]",
        externalConsole= false,
        MIMode= "gdb",
        setupCommands={
            {
                description= "Enable pretty-printing for gdb",
                text= "-enable-pretty-printing",
                ignoreFailures= true
            },
            {
                description= "Do not stop on SIGPIPE error",
                text= "handle SIGPIPE nostop noprint pass",
                ignoreFailures= true
            }
        }
    }
}

require("dapui").setup()

vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<F9>', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<F6>', function() require('dap').run_last() end)
vim.keymap.set('n', '<F7>', function() require('dap').close() end) -- :DapTerminate
vim.keymap.set('n', '<F8>', function() require('dapui').toggle() end)
-- vim.keymap.set('n', '<space>di', function() require('dap').repl.open() end)
vim.keymap.set({ 'v', 'n' }, '<C-k>', function() require('dapui').eval() end)
-- vnoremap <M-k> <Cmd>lua require("dapui").eval()<CR>

-- format with .clang-format
-- use shortcut <gq> :
-- https://neovim.io/doc/user/lsp.html
-- 'formatexpr' is set to vim.lsp.formatexpr() if both 'formatprg' and 'formatexpr' are empty. This allows to format lines via gq if the language server supports it.
