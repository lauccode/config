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

  Plug 'https://github.com/vim-scripts/grep.vim'
  Plug 'kevinhwang91/rnvimr'  " for ranger
  Plug 'https://github.com/scrooloose/nerdtree'
  Plug 'https://github.com/scrooloose/nerdcommenter'
  
  Plug 'ldelossa/litee.nvim'
  Plug 'ldelossa/litee-calltree.nvim'
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

colorscheme edge
" colorscheme material
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
" without plugin
" to find words
nnoremap <silent> <leader>g :Rgrep
"nnoremap <leader>g :grep -R <cword> . --include=*.{cpp,h}
" to see the quick list after grep or find ...
nnoremap <leader>l :copen<CR>
" to find files
set path+=**
if filereadable($HOME.'/.config/nvim/plugged/ctrlp.vim')
        let g:ctrlp_map = '<c-p>'
        let g:ctrlp_cmd = 'CtrlP'
else
        nnoremap <c-p> :find 
endif
" Multi-cursor without plugin with copy buffer 'a'
" <C-c> to copy
" <C-n> to change first occurence (only 'n' to pass)
nnoremap <C-n> *<S-n>cgn<C-r>a<ESC>n
nnoremap <silent> <M-o> :ClangdSwitchSourceHeader<cr>


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

" ranger
tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
nnoremap <silent> <M-o> :RnvimrToggle<CR>
tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>

" Map Rnvimr action
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }

nnoremap <silent> <F9> :NERDTreeToggle<CR>

" To map <Esc> to exit terminal-mode:
  :tnoremap <Esc> <C-\><C-n>
" To simulate |i_CTRL-R| in terminal-mode:
  :tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
" To use `ALT+{h,j,k,l}` to navigate windows from any mode:
  :tnoremap <A-h> <C-\><C-N><C-w>h
  :tnoremap <A-j> <C-\><C-N><C-w>j
  :tnoremap <A-k> <C-\><C-N><C-w>k
  :tnoremap <A-l> <C-\><C-N><C-w>l
  :inoremap <A-h> <C-\><C-N><C-w>h
  :inoremap <A-j> <C-\><C-N><C-w>j
  :inoremap <A-k> <C-\><C-N><C-w>k
  :inoremap <A-l> <C-\><C-N><C-w>l
  :nnoremap <A-h> <C-w>h
  :nnoremap <A-j> <C-w>j
  :nnoremap <A-k> <C-w>k
  :nnoremap <A-l> <C-w>l

" Move between buffers
nnoremap <C-J> :bprev<CR>
nnoremap <C-K> :bnext<CR>

" yank (y) command to the clipboard buffer.
" set clipboard+=unnamedplus
" and close the init.vim. Then you have to install:
" xsel if you have installed Neovim in your local machine.
" lemonade if you have installed Neovim in a remote host (ssh).

" set guifont=FiraCode\ NF:h17

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


let Grep_Default_Filelist = '*.cpp *.h'



" NERD COMMENTER
" Set a language to use its alternate delimiters by default
"let g:NERDAltDelims_c = 1
"Pas avoir les [> <] quand on commente une zone avec déjà des comments:w
let g:NERDLPlace= "/*"
let g:NERDRPlace= "*/"
" let g:NERDUsePlaceHolders = 0
" let g:NERDDefaultNesting = 1
" filtre NERDTree
"i:let NERDTreeIgnore += ['\(\.txt\)\@<!$[[file]]']
"let NERDTreeIgnore=['\.json$','\.inc$','\.ac$','\.md$','\.sh$','.txt$', '\.msi$','\.ini$','\.tmp$','\.ini$','\.am$']
"
" To don't have the bug of NERDTree because of the CLOUD !!!!!
let g:NERDTreeDirArrows=0
" To avoid bug of NERDTREE that doesn't open Directory with new HD to work (so new cygwin ...)
set encoding=utf-8
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1


" START NORMAL COPY AND PASTE SETTINGS 
if has("gui_running") || has("nvim")
    " NORMAL COPY AND PASTE SETTINGS 

    " Here is an excert from the mswin.vim file:-

    " CTRL-X and SHIFT-Del are Cut
    vnoremap <C-X> "+x
    " vnoremap <S-Del> "+x

    " CTRL-C and CTRL-Insert are Copy
    vnoremap <C-C> "+y
    " to have it in copy buffer 'a' for multicursor in .vimrc
    vnoremap <C-C> "ay
    " vnoremap <C-Insert> "+y

    " CTRL-V and SHIFT-Insert are Paste
    map <C-V>       "+gP
    " map <S-In" Paste from clipboard when in insert mode.
    " imap <C-V> <ESC>"+gpa
    " Paste from clipboard when in visual mode. (Replace whatever is selected in visual mode.)
    " vmap <C-V> "+gP
    " " Use CTRL-Q to do what CTRL-V used to do
    noremap <C-Q>       <C-V>
endif


cmap <C-V>      <C-R>+
" cmap <S-Insert>     <C-R>+

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.
" Uses the paste.vim autoload script.

exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

imap <S-Insert>     <C-V>
vmap <S-Insert>     <C-V>

" and the paste.vim script which is required for block mode cut/paste:-

" Vim support file to help with paste mappings and menus
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last Change:  2006 Jun 23

" Define the string to use for items that are present both in Edit, Popup and
" Toolbar menu.  Also used in mswin.vim and macmap.vim.

" Pasting blockwise and linewise selections is not possible in Insert and
" Visual mode without the +virtualedit feature.  They are pasted as if they
" were characterwise instead.  Add to that some tricks to leave the cursor in
" the right position, also for "gi".
if has("virtualedit")
    let paste#paste_cmd = {'n': ":call paste#Paste()<CR>"}
    let paste#paste_cmd['v'] = '"-c<Esc>' . paste#paste_cmd['n']
    let paste#paste_cmd['i'] = 'x<BS><Esc>' . paste#paste_cmd['n'] . 'gi'

    func! paste#Paste()
        let ove = &ve
        set ve=all
        normal! `^
        if @+ != ''
            normal! "+gP
        endif
        let c = col(".")
        normal! i
        if col(".") < c " compensate for i<ESC> moving the cursor left
            normal! l
        endif
        let &ve = ove
    endfunc
else
    let paste#paste_cmd = {'n': "\"=@+.'xy'<CR>gPFx\"_2x"}
    let paste#paste_cmd['v'] = '"-c<Esc>gix<Esc>' . paste#paste_cmd['n'] . '"_x'
    let paste#paste_cmd['i'] = 'x<Esc>' . paste#paste_cmd['n'] . '"_s'
endif

" This is just minimal, assuming most things are default settings**:

" :behave mswin
" :set clipboard=unnamedplus
" :smap <Del> <C-g>"_d
" :smap <C-c> <C-g>y
" :smap <C-x> <C-g>x
" :imap <C-v> <Esc>pi
" :smap <C-v> <C-g>p
" :smap <Tab> <C-g>1> 
" :smap <S-Tab> <C-g>1<
" line 1: makes the shift+arrows select text (and does more*)
" line 2: makes "+ (and "*) the default register (gui/term clipboard)
" lines 3,4,5,6: makes Ctrl-x/c/v Cut/Copy and Paste
" line 7,8: makes TAB/SHIFT+TAB indent/outdent selections

" END NORMAL COPY AND PASTE SETTINGS 

lua << EOF

-- FOR LITEE (call-tree) (TBT)
-- configure the litee.nvim library 
require('litee.lib').setup({})
-- configure litee-calltree.nvim
require('litee.calltree').setup({})


local nvim_lsp = require('lspconfig')


require'lspconfig'.clangd.setup{
-- cmd = {'/SCM/NFS/expanded/vxWorks7-Vendor/21.03_1/7/compilers/llvm-11.0.1.1/LINUX64/bin/clangd', "--background-index", "--query-driver=/usr/bin/c++", "--header-insertion=iwyu"};
-- cmd = {'/usr/bin/clangd', "--background-index", "--query-driver=/usr/bin/c++", "--header-insertion=iwyu"};
-- cmd = {'/snap/bin/clangd', "--background-index"};
}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
 
   -- See `:help vim.lsp.*` for documentation on any of the below functions
   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>D', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>d', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>t', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>i', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>o', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)

   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
   -- vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>r', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>[', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
   vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Space>]', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
   -- <C-o> go backwards
   -- <C-i> go forwards

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'clangd' }
for _, lsp in ipairs(servers) do
    require('lspconfig')[lsp].setup {
    cmd = {'clangd', "--background-index"};
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

-- vimscript command !!!
vim.cmd 'packadd termdebug'
vim.cmd 'noremap <F9> :Break<cr>'
vim.cmd 'noremap <F8> :Clear<cr>'
vim.cmd 'noremap <F10> :Over<cr>'
vim.cmd 'noremap <F12> :Step<cr>'
vim.cmd 'noremap <F5> :Continue<cr>'
vim.cmd 'noremap <F6> :Run<cr>'
-- <S-k> :Evaluate

EOF
