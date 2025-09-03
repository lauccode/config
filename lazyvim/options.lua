-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- SET COLORSCHEME in ~/.config/nvim/lua/plugins/colorscheme.lua
-- vim.cmd("set bg=light")

vim.g.autoformat = false
-- Add this to your init.lua or appropriate configuration file :so %

vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert 2 spaces for a tab
vim.opt.wrap = true
vim.opt.linebreak = true -- gj,gk to move up dans down in the wrap line
-- vim.opt.scrolloff = 999  -- always center cursor line vertically / 8 default
vim.opt.scrolloff = 5 -- always center cursor line vertically / 8 default

vim.cmd("nnoremap * :keepjumps normal! mi*`i<CR>") -- no search forward with '*'

vim.cmd("packadd cfilter") -- allow filter on quickfix list (:Cfilter cpp, colder to go back)
-- vim.cmd("set list!") -- show invisible character  -- allow filter on quickfix list (:Cfilter cpp, colder to go back)
vim.cmd("set lcs=tab:»_,trail:·,eol:$")
vim.cmd("set norelativenumber") -- set rnu; set nrnu; set rnu!(toggle)
vim.cmd("set inccommand=split") -- preview for substitute commande
vim.cmd("set cwh=30") -- high for the preview of incommand
vim.cmd("set makeprg=ninja")
-- can use ":make" to build
-- build example
-- vim.api.nvim_create_user_command("But", function()
--   vim.cmd(":make -C modem/UbtApplication/Test/ U2TestsLinux")
-- end, { nargs = "*" })
-- build example
-- vim.api.nvim_create_user_command("Bd", function()
--   vim.cmd("!cd modem/build/linux_zinc && ./build.sh all")
-- end, { nargs = "*" })

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
vim.cmd("let g:termdebug_wide = 1") -- =163 for inversed layout
-- lvim.termdebug_wild = 1

-- autocmd colorscheme * :hi debugPC term=reverse ctermbg=darkblue guibg=red
vim.api.nvim_command([[
    augroup ChangeBackgroudColour
    autocmd colorscheme * :hi debugPC guibg=green
    augroup END
]])

-- -- To map <Esc> to exit terminal-mode:
vim.cmd("tnoremap <Esc> <C-\\><C-n>")
-- -- To simulate |i_CTRL-R| in terminal-mode:
-- -- vim.cmd 'tnoremap <expr> <C-R> '<C-\\><C-N>"'.nr2char(getchar()).'pi''
-- -- To use `ALT+{h,j,k,l}` to navigate windows from any mode:
-- vim.cmd("tnorema <A-h> <C-\\><C-N><C-w>h")
-- vim.cmd("tnoremap <A-j> <C-\\><C-N><C-w>j")
-- vim.cmd("tnoremap <A-k> <C-\\><C-N><C-w>k")
-- vim.cmd("tnoremap <A-l> <C-\\><C-N><C-w>l")
-- vim.cmd("inoremap <A-h> <C-\\><C-N><C-w>h")
-- vim.cmd("inoremap <A-j> <C-\\><C-N><C-w>j")
-- vim.cmd("inoremap <A-k> <C-\\><C-N><C-w>k")
-- vim.cmd("inoremap <A-l> <C-\\><C-N><C-w>l")
-- vim.cmd("nnoremap <A-h> <C-w>h")
-- vim.cmd("nnoremap <A-j> <C-w>j")
-- vim.cmd("nnoremap <A-k> <C-w>k")
-- vim.cmd("nnoremap <A-l> <C-w>l")

-- vim.cmd("nnoremap <C-w>m <C-w>\\| <C-w>_") --maximize window

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldenable = false  -- Disable folding at startup
-- vim.opt.foldlevel = 0

-- "z" to have fold menu
-- vim.opt.foldmethod = "syntax"
-- vim.cmd 'set nofoldenable'
-- vim.opt.foldexpr = "}"

-- local clangd_flags = {
--   -- "--header-insertion=iwyu",
--   "--query-driver=/usr/bin/c++,/usr/bin/gcc",
--   -- "--clang-tidy-checks=-*,llvm-*,clang-analyzer-*,modernize-*,-modernize-use-trailing-return-type",
--   -- "--fallback-style=Google",
--   -- "--header-insertion=never",
--   -- "--query-driver=<list-of-white-listed-complers>"
-- }
-- local clangd_bin = "/usr/bin/clangd"

-- require("dapui").setup()
-- vim.keymap.set("n", "<F5>", function() require("dap").continue() end)
-- vim.keymap.set("n", "<F10>", function() require("dap").step_over() end)
-- vim.keymap.set("n", "<F11>", function() require("dap").step_into() end)
-- vim.keymap.set("n", "<F12>", function() require("dap").step_out() end)
-- vim.keymap.set("n", "<F9>", function() require("dap").toggle_breakpoint() end)
-- vim.keymap.set("n", "<F6>", function() require("dap").run_last() end)
-- vim.keymap.set("n", "<F7>", function() require("dap").close() end) -- :DapTerminate
-- vim.keymap.set("n", "<F8>", function() require("dapui").toggle() end)
-- -- vim.keymap.set('n', '<space>di', function() require('dap').repl.open() end)
-- vim.keymap.set({ "v", "n" }, "<C-k>", function() require("dapui").eval() end)
-- vnoremap <M-k> <Cmd>lua require("dapui").eval()<CR>

-- format with .clang-format
-- use shortcut <gq> :
-- https://neovim.io/doc/user/lsp.html
-- 'formatexpr' is set to vim.lsp.formatexpr() if both 'formatprg' and 'formatexpr' are empty. This allows to format lines via gq if the language server supports it.

-- FOR NEOVIDE
vim.o.guifont = "FiraCode Nerd Font Mono:h24" -- text below applies for VimScript
-- vim.o.guifont = "Source Code Pro:h14" -- text below applies for VimScript
-- vim.o.guifont = "SourceCodeVF:h24" -- text below applies for VimScript
-- Helper function for transparency formatting
local alpha = function()
  return string.format("%x", math.floor(255 * vim.g.transparency))
end
-- g:neovide_opacity should be 0 if you want to unify transparency of content and title bar.
vim.g.neovide_opacity = 0.95
vim.g.transparency = 0.9
vim.g.neovide_background_color = "#0f1117" .. alpha()

-- ▗▖ ▗▖▗▄▄▄▖▗▖  ▗▖▗▖  ▗▖ ▗▄▖ ▗▄▄▖  ▗▄▄▖
-- ▐▌▗▞▘▐▌    ▝▚▞▘ ▐▛▚▞▜▌▐▌ ▐▌▐▌ ▐▌▐▌
-- ▐▛▚▖ ▐▛▀▀▘  ▐▌  ▐▌  ▐▌▐▛▀▜▌▐▛▀▘  ▝▀▚▖
-- ▐▌ ▐▌▐▙▄▄▖  ▐▌  ▐▌  ▐▌▐▌ ▐▌▐▌   ▗▄▄▞▘

vim.api.nvim_set_keymap(
  "n",
  "<leader>O",
  ":e ~/.config/nvim/lua/config/options.lua<CR>",
  { noremap = true, silent = true, desc = "config Options" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>o",
  ":ClangdSwitchSourceHeader<CR>",
  { noremap = true, silent = true, desc = "Header file" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>h",
  ":set list!<CR>",
  { noremap = true, silent = true, desc = "Show invisible" }
)
vim.api.nvim_set_keymap(
  "n",
  "<F5>",
  ":!love .<CR>",
  { noremap = true, silent = true, desc = "Launch love project" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>i",
  "viw",
  { noremap = true, silent = true, desc = "Inner word" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>I",
  "viW",
  { noremap = true, silent = true, desc = "Inner WORD" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>R",
  ":source ~/.config/nvim/init.lua<CR>",
  { noremap = true, silent = true, desc = "Reload lazyvim" }
)

vim.keymap.set("x", "p", [["_dP]], { desc = "Paste without overwriting register" })
vim.keymap.set("x", "d", [["_d]], { desc = "Delete without overwriting register" })
-- Normal mode: delete line without overwriting register
vim.keymap.set("n", "dd", [["_dd]], { desc = "Delete line without overwriting register" })
-- Normal mode: delete character without overwriting register
vim.keymap.set("n", "x", [["_x]], { desc = "Delete char without overwriting register" })
-- Normal mode: delete word without overwriting register
vim.keymap.set("n", "dw", [["_dw]], { desc = "Delete word without overwriting register" })
