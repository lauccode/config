" BASIC

set bg=dark  " dark/light

" set cursorline                                    " afficher la ligne courante
" hi CursorLine guibg=#4d4d4d                       " couleur de fond pour la ligne courante

call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim',
Plug 'easymotion/vim-easymotion'
Plug 'mg979/vim-visual-multi'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'inkarkat/vim-mark'
Plug 'inkarkat/vim-ingo-library'
call plug#end()
:let mapleader = " "

" no search forward with '*'
nnoremap * :keepjumps normal! mi*`i<CR>

" NERD COMMENTER
" To don't have the bug of NERDTree because of the CLOUD !!!!!
let g:NERDTreeDirArrows=0
" To avoid bug of NERDTREE that doesn't open Directory with new HD to work (so new cygwin ...)
set encoding=utf-8
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Set a language to use its alternate delimiters by default
"let g:NERDAltDelims_c = 1
"Pas avoir les [> <] quand on commente une zone avec déjà des comments:w
let g:NERDLPlace= "/*"
let g:NERDRPlace= "*/"
" let g:NERDUsePlaceHolders = 0
" let g:NERDDefaultNesting = 1
" [count]<leader>cc |NERDCommenterComment|
" Comment out the current line or text selected in visual mode.
" [count]<leader>cn |NERDCommenterNested|
" Same as cc but forces nesting.
" [count]<leader>c<space> |NERDCommenterToggle|
" Toggles the comment state of the selected line(s). If the topmost selected line is commented, all selected lines are uncommented and vice versa.
" [count]<leader>cm |NERDCommenterMinimal|
" Comments the given lines using only one set of multipart delimiters.
" [count]<leader>ci |NERDCommenterInvert|
" Toggles the comment state of the selected line(s) individually.
" [count]<leader>cs |NERDCommenterSexy|
" Comments out the selected lines with a pretty block formatted layout.
" [count]<leader>cy |NERDCommenterYank|
" Same as cc except that the commented line(s) are yanked first.
" <leader>c$ |NERDCommenterToEOL|
" Comments the current line from the cursor to the end of line.
" <leader>cA |NERDCommenterAppend|
" Adds comment delimiters to the end of line and goes into insert mode between them.
" |NERDCommenterInsert|
" Adds comment delimiters at the current cursor position and inserts between. Disabled by default.
" <leader>ca |NERDCommenterAltDelims|
" Switches to the alternative set of delimiters.
" [count]<leader>cl |NERDCommenterAlignLeft [count]<leader>cb |NERDCommenterAlignBoth
" Same as |NERDCommenterComment| except that the delimiters are aligned down the left side (<leader>cl) or both sides (<leader>cb).
" [count]<leader>cu |NERDCommenterUncomment|
" Uncomments the selected line(s).
 

" Basic configuration: For VIM-EASYMOTION, you can add basic key bindings to your .vimrc:
nmap f <Plug>(easymotion-s)

" For vim-visual-multi, you can enable it with:
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'
let g:VM_maps['Add Cursor Down']    = '<C-Down>'
let g:VM_maps['Add Cursor Up']      = '<C-Up>'

" make d to kill character
nnoremap d x
" kakoune line selection (x down/X up)
nnoremap x :<C-u>call SelectCurrentLine()<CR>
xnoremap x :<C-u>call ExtendOrShrinkSelection('extend')<CR>
xnoremap X :<C-u>call ExtendOrShrinkSelection('shrink')<CR>

function! SelectCurrentLine()
    normal! V
    xnoremap x :<C-u>call ExtendOrShrinkSelection('extend')<CR>
    xnoremap X :<C-u>call ExtendOrShrinkSelection('shrink')<CR>
endfunction

function! ExtendOrShrinkSelection(action)
    if a:action ==# 'extend'
        normal! j
        execute "normal! gvj"
    elseif a:action ==# 'shrink'
        normal! k
        execute "normal! gvk"
    endif
    xnoremap x :<C-u>call ExtendOrShrinkSelection('extend')<CR>
    xnoremap X :<C-u>call ExtendOrShrinkSelection('shrink')<CR>
endfunction

" make shift+w word selection and w next word selection
nnoremap W :call SelectOrExtendWord()<CR>
xnoremap W :call ExtendSelectionNextWord()<CR>

function! SelectOrExtendWord()
    normal! viw
    xnoremap W :call ExtendSelectionNextWord()<CR>
endfunction

function! ExtendSelectionNextWord()
    execute "normal! /\\<\\k*\\>\\(\zs\\k*\\)*\\<CR>"
    execute "normal! gv"
    xnoremap W :call ExtendSelectionNextWord()<CR>
endfunction

" LSP
nnoremap gd :LspDefinition<CR>
nnoremap gn :LspNextDiagnostic<CR>
nnoremap gp :LspPreviousDiagnostic<CR>
nnoremap gr :LspRename<CR>

set nocompatible
syntax enable
filetype plugin on
" to select tab with mouse
" also to have buttons for termdebug !
set mouse=a
syntax enable
filetype plugin indent on
set nu nu
set completeopt=menuone,noinsert,noselect "for completion
set shortmess+=c " avoid hit enter prompt
set expandtab    " number of space to indent with <Tab>
set smartindent
set tabstop=4 softtabstop=4
set cmdheight=2
set updatetime=50
set signcolumn=yes
set smartcase  " be sure to find even if bad case
" set list!  " show invisible character
" set lcs=tab:»_,trail:·  " set lcs=tab:j_,trail:·,eol:$
" set cwh=30 " high for the preview of incommand

" SHORTCUTS
" removed because used by mark.vim
autocmd VimEnter * silent! nunmap <leader>r
autocmd VimEnter * nnoremap <leader>r :source $MYVIMRC<CR>
set shortmess+=I

nnoremap <leader>r :source $MYVIMRC<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>c :bd<CR>
noremap <F2> :edit ~/.vimrc<CR>
noremap <F5> :!love .<CR>
noremap <F6> :bp<CR>
noremap <F7> :bn<CR>
nnoremap <silent> <F9> :NERDTreeToggle<CR>
nnoremap <leader>i viw
nnoremap <leader>I viW
set lcs=tab:»_,trail:·,eol:$
nnoremap <leader>h :set list!<CR>
nnoremap <leader>o :LspDocumentSwitchSourceHeader<CR>
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :RG<CR>
command! Lg execute '!lazygit'

" MOVE
"  % key will be your friend. This key will jump between start and end of 
" curly braces quickly.

" COLOR SCHEME
" :colo   (to check colorscheme used)
:colo delek
" :colo industry

" REPEAT LAST COMMAND
" The last command entered with ':' can be repeated with @: and further repeats can be done with @@
" @:,@@
" This is useful for commands like :bnext or :cNext.

" CTAGS
" command! MakeTags !ctags -R .
" ^]        jump to tag under cursor
" g^]     list tags
" ^t        jump back up the tag stack

" FINDING FILES
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
" Display all matching files when we tab
set wildmenu
" hit tab to :find by partial match
" Use * to make it fuzzy
" :b lets you autocomplete any open buffer
" FZF
" to find and open with fzf in terminal
" filepath=$(fzf);vim $filepath
" to put in .bashrc
" alias ff='filepath=$(fzf);vim $filepath'

" FINDING WORDS
" :vimgrep word *.cpp *.h
if executable("rg")  " use :grep <word> with ripgrep
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif 
" Search for the exact word foo (not foobar): :grep -w foo (equivalent to :grep '\bfoo\b').
 " Search for foo in JavaScript files: :grep foo -t js
 " Search for foo in files matching a glob: :grep foo -g '*.js'

" AUTOCOMPLETE
" ^x^n        just for this file
" ^x^f        for filenames(works with path tricks)
" ^x ^]        for tags only
" ^n            complete
" ^p             go back

" FILE BROWSING
" E     explorer all screen
" Ex    explorer split screen
let g:netrw_banner = 0
let g:netrw_browse_split=4
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()
" let g:netrw_list_hide.=",\(^\|\s\s\)\zs\.\S\+'
" :edit a folder to open file browser
" <CR>/v/t to open in an h-split/v-split/tab
" check |netrw-browse-maps| for more mappings

" BUILD
" set makeprg=ninja
" :make to run
" :cl to list errors
" :cc# to jump to error by number
" :cn n :cp to navigate
" :compiler <TAB>  (choose compiler to use)

" SNIPPETS:
" Read an empty HTML template and move cursor to title
nnoremap ,html :-1read $HOME/.vim/.skeleton.html<CR>3jwf>a

" TERMINAL
" exit from terminal : CTRL+\CTRL+n
" :terminal
" :terminal make  (launch make in terminal)
" launch script to build and use :
" :cbuffer (parse terminal buffer to fill quickfixlist) very practice !!!!!
" :cn, cp  (next, previous error of quickfixlist)

" QUICKFIX
" if you want to load the quickfix item into the previously used window.
set switchbuf+=uselast

" DEBUG
"packadd termdebug
" Termdebug bin/exe
" GDB cmd :
" b main  (breakpoint on main)
" r       (run)
" s       (step)
" n       (next)
" S+k     (evaluate variable under cursor)
" :let termdebugger="rust-gdb"
" we navigate to the source code view and type Ctrl+w and L to have it on the right.

" TAB
" :tabedit namefile.txt

" SEARCH AND REPLACE 
" to have preview :
" https://github.com/osyo-manga/vim-over
" Delete all line where "Binary File" is present
" g/Binary File/d
" :%s//bar/g
" Replace each match of the last search pattern with 'bar'.
" 'bar' can be previously copy and recall with <C-r>" 

" FOLDER
" Fold activation and deactivation
" To activate fold use following command: 
" :set foldenable 
" :set foldmethod=indent 
"
" :set foldmethod=syntax 
"
" To deactivate fold use following command: 
" :set nofoldenable
" zm to fold one level
" zR to reopen all

" :help folding les replis !
" :zf       créé repli
" :zo zc zd ouvre ferme supprime
" :zR zM    ouvre/ferme TOUT
" :zm zr    augmente/diminue niveau
" :zE zO    supprime/ouvre tous les replis sous le curseur

" MARKER
" Balises
" :ma       marqueur a
" :'a       va au marqueur a
" :marks    list des marques

" REGISTRES
" :registres    on voit tous les buffers de copier/coller
" "%p       path du fichier en cours

" COMMAND HISTORY
" see your history of commands : 
" ctrl-f.
" Use 
" jk 
" to move down and up the list and press Enter to execute a command again. 
" Or to hop back out of the list, press 
" ctrl-c. 
" You could then press 
" Esc or ctrl-c again
" to exit command mode entirely. 
