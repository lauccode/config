"---- vim-plug setup  ----
let vimplug_exists=expand('C:\Users\carpent7\AppData\Local\nvim\autoload\plug.vim')
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

silent! call plug#begin('C:\Users\carpent7\AppData\Local\nvim\plugged')

" Sensible default 
Plug 'tpope/vim-sensible'

" Color schemes
Plug 'sainnhe/edge'

" Telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'marko-cerovac/material.nvim'

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-orgmode/orgmode'
Plug 'dhruvasagar/vim-table-mode'

call plug#end()

set mouse=a
"
" Automatically install missing plugins on startup
" autocmd VimEnter *
"   \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
"   \|   PlugInstall --sync | q
"   \| endif

if has('termguicolors')
  set termguicolors
endif

let g:edge_style = 'aura'
let g:edge_enable_italic = 1
let g:edge_disable_italic_comment = 1


colorscheme edge
" colorscheme material
" colorscheme default
" colorscheme edge
" colorscheme slate

" colorscheme onedarker
" colorscheme gruvbox
" colorscheme gruvbox-baby
" colorscheme gruvbox-material
" colorscheme tokyonight
" colorscheme tokyonight-night
" colorscheme nightfox
" colorscheme melange
" colorscheme sonokai
" colorscheme everforest
" colorscheme dracula
" colorscheme neovim-molokai



"
"darker/lighter/oceanic/palenight/deep ocean
" let g:material_style = 'darker'

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

:let mapleader = " "

" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
nnoremap <leader>fl <cmd>Telescope git_files<cr>

" if filereadable($HOME.'/vimfiles/bundle/nerdtree/plugin/NERD_tree.vim')
    noremap <F2> :edit C:\Users\carpent7\AppData\Local\nvim\init.vim<CR> 
" else
"    noremap <F2> :edit ~/.vimrc<CR> 
" endif

nnoremap <leader>r :source $MYVIMRC<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

imap ;; <Esc>



" START NORMAL COPY AND PASTE SETTINGS 
if has("gui_running") || has("nvim")

" " Cut to clipboard
noremap  <leader>x  "+x
nnoremap  <leader>X  "+xg_
nnoremap  <leader>x  "+x
noremap  <leader>xx  "+xx

" " Copy to clipbard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

    " NORMAL COPY AND PASTE SETTINGS 

    " Here is an excert from the mswin.vim file:-

    " CTRL-X and SHIFT-Del are Cut
" vnoremap <C-X> "+x
" vnoremap  <leader>x "+y
    " vnoremap <S-Del> "+x

    " CTRL-C and CTRL-Insert are Copy
" vnoremap <C-C> "+y
" vnoremap  <leader>y "+y
    " vnoremap <C-Insert> "+y

    " CTRL-V and SHIFT-Insert are Paste
" map <C-V>       "+gP
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

