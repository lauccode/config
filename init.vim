"---- vim-plug setup  ----
let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif
"-------- end vim-plug setup ----

set nocompatible

call plug#begin('~/.config/nvim/plugged')

  " Sensible default 
  Plug 'tpope/vim-sensible'
  " Color schemes
  Plug 'sainnhe/edge'
  " Telescope
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'
  "
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-lua/completion-nvim'
  " Vim Script
  Plug 'folke/which-key.nvim'
  Plug 'marko-cerovac/material.nvim'

  Plug 'kien/ctrlp.vim'

call plug#end()

set mouse=a

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

if has('termguicolors')
  set termguicolors
endif

let g:edge_style = 'aura'
let g:edge_enable_italic = 1
let g:edge_disable_italic_comment = 1

" colorscheme edge
colorscheme material
"darker/lighter/oceanic/palenight/deep ocean
let g:material_style = 'darker'

syntax enable
filetype plugin indent on

set nu rnu
set completeopt=menuone,noinsert,noselect
set shortmess+=c
set expandtab
set smartindent
set tabstop=4 softtabstop=4
set cmdheight=2
set updatetime=50
set signcolumn=yes

augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

:let mapleader = ";"

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fl <cmd>Telescope git_files<cr>

nnoremap <Leader>pp :lua require'telescope.builtin'.planets{}


" if filereadable($HOME.'/vimfiles/bundle/nerdtree/plugin/NERD_tree.vim')
    noremap <F2> :edit ~/.config/nvim/init.vim<CR> 
" else
"    noremap <F2> :edit ~/.vimrc<CR> 
" endif

nnoremap <leader>r :source $MYVIMRC<CR>

imap ;; <Esc>




" CTRLP settings
" results:  can affect the result to find several time the same name of file 
:let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:40,results:200'
"scan for dot file and dir
:let g:ctrlp_show_hidden = 1
"Set this to 1 to set searching by filename (as opposed to full path) as the default: >
"Can be toggled on/off by pressing <c-d> inside the prompt.
:let g:ctrlp_by_filename = 1
:let g:ctrlp_mruf_relative = 1
"To be sure to have rescan files
" :nnoremap <c-p> :CtrlPClearCache<bar>CtrlP<cr>
" To try to have default open directory with vim
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" You need to <C-f> by selecting mru files to find all ... TBC
" let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_user_command = 'find %s -type f'       " MacOSX/Linux
" let g:ctrlp_user_command = 'find %s -name f'       " MacOSX/Linux


lua << EOF
local nvim_lsp = require('lspconfig')

require'lspconfig'.clangd.setup{
cmd = {'/SCM/NFS/expanded/vxWorks7-Vendor/21.03_1/7/compilers/llvm-11.0.1.1/LINUX64/bin/clangd', "--background-index"};
}


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
  local on_attach = function(client, bufnr)
   local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
   local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
 
   -- Enable completion triggered by <c-x><c-o>
   buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
 
   -- Mappings.
   local opts = { noremap=true, silent=true }
 
   -- See `:help vim.lsp.*` for documentation on any of the below functions
   buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
   buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
   buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
   buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
   buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
   buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
   buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
   buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
   buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
   buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
   buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
   buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
   buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
   buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
   buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
   buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
   -- <C-o> go backwards
   -- <C-i> go forwards
   buf_set_keymap('n', '<space>i', '<cmd>lua vim.lsp.buf.incomingCalls()<CR>', opts)
   buf_set_keymap('n', '<space>o', '<cmd>lua vim.lsp.buf.outgoingCalls()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    cmd = {'/SCM/NFS/expanded/vxWorks7-Vendor/21.03_1/7/compilers/llvm-11.0.1.1/LINUX64/bin/clangd', "--background-index"};
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}
-- to install color for cpp
-- :TSInstall cpp

require("which-key").setup {
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}

require('telescope').setup{ 
defaults = { file_ignore_patterns = {"node_modules"} } 
}

vim.lsp.set_log_level("debug")
EOF
