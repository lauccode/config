" An example for a vimrc file.
"
" Maintainer:   Bram Moolenaar <Bram@vim.org>
" Last change:  2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"             for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"           for OpenVMS:  sys$login:.vimrc


""""""""""""""""""""""""""""""""""""""""""""""""""
"Diverses options
""""""""""""""""""""""""""""""""""""""""""""""""""
"set nocompatible                                  " désactivation de la compatibilité avec vi
"set background=dark                               " fond sombre
"colorscheme desert                                " couleur
"syntax enable                                     " activation de la coloration syntaxique
"set number                                        " numérotation des lignes
"set autoindent                                    " indentation automatique avancée
"set smartindent                                   " indentation plus intelligente
"set laststatus=2                                  " ajoute une barre de status
"set backspace=indent,eol,start                    " autorisation du retour arrière
"set history=50                                    " historique de 50 commandes
"set ruler                                         " affiche la position courante au sein du fichier
"set showcmd                                       " affiche la commande en cours
"set shiftwidth=4                                  " nombre de tabulation pour l'indentation
"set tabstop=8                                    " nombre d'espace pour une tabulation
"set showmatch                                     " vérification présence ([ ou { à la frappe de )] ou }
"filetype plugin indent on                         " détection automatique du type de fichier
"autocmd FileType text setlocal textwidth=72       " les fichiers de type .txt sont limites à 72 caractères par ligne
"set fileformats=unix,mac,dos                      " gestion des retours chariot en fonction du type de fichier
"set viewdir=/home/ngressier/.vim/saveview/        " répertoire pour sauvegarder les vues, utiles pour les replis manuels
"set cursorline                                    " afficher la ligne courante
"hi CursorLine guibg=#4d4d4d                       " couleur de fond pour la ligne courante
"set foldcolumn=2                                  " repère visuel pour les folds
"let Tlist_Ctags_Cmd = '/usr/bin/ctags'           " implémentation de ctags, nécessaire pour le plugin 'taglist'
"set guioptions-=T                                 " supprime la barre d'outils
"set incsearch                                     " recherche incrémentale
"set hlsearch                                      " surligne les résultats de la recherche
"set ignorecase                                    " ne pas prendre en compte la casse lors des recherches
"set guifont=Courier\ New\ 10                      " police de caractère
"set nolist                                       " on n'affiche pas les caractères non imprimables
"set listchars=eol:¶,tab:..,trail:~               " paramétrage des caractères non imprimables au cas où l'on souhaiterait les afficher
"set nowrap                                       "annule le retour à la ligne automatique

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" VIM-PLUG
" WINDOWS
if filereadable($HOME.'/vimfiles/bundle/nerdtree/plugin/NERD_tree.vim')
    silent! call plug#begin('~/vimfiles/bundle')
    " MY PLUGINS
    Plug 'https://github.com/hari-rangarajan/CCTree.git'
    Plug 'https://github.com/kien/ctrlp.vim'
    Plug 'https://github.com/scrooloose/nerdcommenter'
    Plug 'https://github.com/scrooloose/nerdtree'
    Plug 'https://github.com/mfukar/robotframework-vim'
    " Plug 'https://github.com/scrooloose/syntastic'
    Plug 'https://github.com/majutsushi/tagbar'
    Plug 'https://github.com/bling/vim-airline'
    Plug 'https://github.com/chiel92/vim-autoformat'
    Plug 'https://github.com/altercation/vim-colors-solarized'
    Plug 'https://github.com/easymotion/vim-easymotion'
    Plug 'https://github.com/w0ng/vim-hybrid'
    Plug 'https://github.com/terryma/vim-multiple-cursors'
    Plug 'https://github.com/chriskempson/vim-tomorrow-theme'
    Plug 'https://github.com/nathanaelkane/vim-indent-guides'
    Plug 'https://github.com/nanotech/jellybeans.vim'
    Plug 'https://github.com/morhetz/gruvbox'
    Plug 'https://github.com/vim-airline/vim-airline-themes.git'
    Plug 'https://github.com/vim-scripts/grep.vim'

    Plug 'https://github.com/tomasr/molokai'
    Plug 'https://github.com/Raimondi/delimitMate.git'
    " Plug 'https://github.com/townk/vim-autoclose'
    Plug 'https://github.com/hecal3/vim-leader-guide.git'
    Plug 'https://github.com/liuchengxu/space-vim-dark.git'
    Plug 'https://github.com/colepeters/spacemacs-theme.vim.git'
    Plug 'https://github.com/jlanzarotta/bufexplorer.git'
    Plug 'https://github.com/joshdick/onedark.vim.git'
    Plug 'https://github.com/vim-scripts/peaksea.git'
    call plug#end()
    :set makeprg=mingw32-make
    set gfn=Consolas:h9:cANSI
    let Grep_Path = 'C:\tool\grep.exe'
    let Fgrep_Path = 'C:\tool\fgrep.exe'
    let Egrep_Path = 'C:\tool\egrep.exe'
    let Grep_Find_Path = 'C:\tool\find.exe'
    let Grep_Xargs_Path = 'C:\tool\xargs.exe' 
    let Grep_Locate_Path = 'C:\tool\locate.exe' 
else
    " LINUX
    let g:plug_threads=16
    call plug#begin('~/.vim/bundle')
    " MY PLUGINS
    " CCTree seems only work with vim and gvim, NOT WITH NEOVIM
    Plug 'https://github.com/lyuts/vim-rtags.git'
    " The best is to use cscope or Denite-gtags ...
    Plug 'https://github.com/chazy/cscope_maps'
    Plug 'https://github.com/hari-rangarajan/CCTree.git'
    Plug 'https://github.com/vim-scripts/Conque-GDB'
    " Plug 'https://github.com/kien/ctrlp.vim'
    Plug 'https://github.com/junegunn/fzf.git'
    Plug 'https://github.com/pbogut/fzf-mru.vim.git'
    Plug 'https://github.com/gregsexton/gitv'
    Plug 'https://github.com/vim-scripts/grep.vim'
    Plug 'https://github.com/scrooloose/nerdcommenter'
    Plug 'https://github.com/scrooloose/nerdtree'
    Plug 'https://github.com/mfukar/robotframework-vim'
    " Plug 'https://github.com/scrooloose/syntastic'
    Plug 'https://github.com/majutsushi/tagbar'
    Plug 'https://github.com/bling/vim-airline'
    Plug 'https://github.com/chiel92/vim-autoformat'
    Plug 'https://github.com/altercation/vim-colors-solarized'
    Plug 'https://github.com/easymotion/vim-easymotion'
    Plug 'https://github.com/tpope/vim-fugitive'
    Plug 'https://github.com/w0ng/vim-hybrid'
    Plug 'https://github.com/terryma/vim-multiple-cursors'
    Plug 'https://github.com/chriskempson/vim-tomorrow-theme'
    Plug 'https://github.com/nathanaelkane/vim-indent-guides'
    Plug 'https://github.com/nanotech/jellybeans.vim'
    Plug 'https://github.com/morhetz/gruvbox'
    " GIT GUTTER NOT WORKING WITH NEOVIM STARTING 20 OCT 2017
    Plug 'https://github.com/airblade/vim-gitgutter'
    Plug 'https://github.com/crusoexia/vim-monokai.git'
    Plug 'https://github.com/Erichain/vim-monokai-pro.git'
    " Plug 'https://github.com/tomasr/molokai'
    " Plug 'https://github.com/while1eq1/vim-monokai-black.git'
    " Plug 'https://github.com/sickill/vim-monokai.git'
    " Plug 'https://github.com/tomasr/molokai.git'
    " Plug 'https://github.com/townk/vim-autoclose'
    Plug 'https://github.com/Raimondi/delimitMate.git'
    " Plug 'https://github.com/suan/vim-instant-markdown'
    " Plug 'https://github.com/euclio/vim-markdown-composer.git'
    Plug 'https://github.com/vim-airline/vim-airline-themes.git'
    Plug 'https://github.com/hecal3/vim-leader-guide.git'
    Plug 'https://github.com/neomake/neomake.git'
    Plug 'https://github.com/liuchengxu/space-vim-dark.git'
    Plug 'https://github.com/colepeters/spacemacs-theme.vim.git'
    Plug 'https://github.com/jlanzarotta/bufexplorer.git'
    Plug 'https://github.com/critiqjo/lldb.nvim.git'
    " Plug 'https://github.com/Valloric/YouCompleteMe.git'
    " Plug 'https://github.com/vim-scripts/AutoComplPop'
    Plug 'https://github.com/joshdick/onedark.vim.git'
    Plug 'https://github.com/vim-scripts/peaksea.git'
    " FULLY NEEDED FOR VIM SNIPPETS AND SNIPMATE
    Plug 'https://github.com/marcweber/vim-addon-mw-utils'
    Plug 'https://github.com/tomtom/tlib_vim'
    Plug 'https://github.com/garbas/vim-snipmate'
    Plug 'https://github.com/honza/vim-snippets'
    " For easy tag
    " Plug 'https://github.com/xolox/vim-easytags.git'
    Plug 'https://github.com/xolox/vim-misc.git'
    " To replace easy tag
    " Plug 'https://github.com/c0r73x/neotags.nvim.git'
    "
    " gen_tags.vim is perturbing cscope first generating database !!!!!!!
    " gen_tags can use global gtags with similar shortcuts to cscope
    " check the website to start to use it as well
    " You need to do cmd first to generate GTAGS : GenGTAGS 
    " Plug 'https://github.com/jsfaint/gen_tags.vim.git'
    Plug 'https://github.com/Shougo/denite.nvim.git'
    Plug 'https://github.com/fenetikm/falcon.git'
    Plug 'https://github.com/christoomey/vim-tmux-navigator.git'

    Plug 'https://github.com/tpope/vim-obsession.git'

    if has('nvim')
        Plug 'https://github.com/arakashic/chromatica.nvim.git'
        " The best is to use cscope or Denite-gtags ...
        Plug 'https://github.com/ozelentok/denite-gtags.git'
    else
        " Color coded is not working with old version of vim or gvim
        " But Easy Tag do the job as well
        " Plug 'https://github.com/jeaye/color_coded.git'
    endif

    " If you share a config file between vim versions, you may use the following to check 
    " if you are in Oni or not. This will allow you to enable or disable features in Oni specifically.
    if exists('g:gui_oni')
        " Statements here
    else
    endif

    function! BuildComposer(info)
        if a:info.status != 'unchanged' || a:info.force
            if has('nvim')
                !cargo build --release
            else
                !cargo build --release --no-default-features --features json-rpc
            endif
        endif
    endfunction
    Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

    call plug#end()
    " Plug 'https://github.com/tpope/vim-surround'
    " Plug 'https://github.com/vim-scripts/c.vim'
    " Plug 'https://github.com/vim-scripts/linuxsty.vim'
    "
    " to enable vim air-line
    let g:airline_powerline_fonts = 1
    let g:airline#extensions#tabline#enabled = 1

    " if filereadable($HOME.'/.vim/bundle/nerdtree/plugin/NERD_tree.vim')
    " set gfn=IBM\ Plex\ Mono\ 9
    "
    " elseif filereadable($HOME.'/.vim/bundle/nerdtree/plugin/NERD_tree.vim')
    " set gfn=Dejavu\ Mono\ for\ Powerline\ 9
    " elseif filereadable($HOME.'/.vim/bundle/nerdtree/plugin/NERD_tree.vim')
    " set gfn=Ubuntu\ Mono\ derivative\ Powerline\ 10
    " elseif filereadable($HOME.'/.vim/bundle/nerdtree/plugin/NERD_tree.vim')
    " set gfn=Liberation\ Mono\ for\ Powerline\ 9
    " else
    " set gfn=DejaVu\ Sans\ Mono\ 10
    " endif

    if filereadable($HOME.'/.local/share/fonts/DejaVu Sans Mono for Powerline.ttf')
        " set gfn=Liberation\ Mono\ for\ Powerline\ 9
        " set gfn=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
        set gfn=Source\ Code\ Pro\ Regular\ 10
        " set gfn=Ubuntu\ Mono\ derivative\ Powerline\ 10
        " set gfn=Ubuntu\ Mono\ derivative\ Powerline\ Regular\ 13
    else
        " set gfn=IBM\ Plex\ Mono\ 9
        set gfn=DejaVu\ Sans\ Mono\ 10
    endif
endif

if has('nvim')
else
    " VIM FULL SCREEN
    :set lines=999 columns=999
endif

" TO HAVE GOOD VIM AIRLINE SETTINGS
" To have only name without path in tabline of vim airline
let g:airline#extensions#tabline#fnamemod = ':t'
" To have the number of buffer in tabline of vim airline
let g:airline#extensions#tabline#buffer_nr_show = 1
"name display to try
" let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
" let g:airline_section_b = '%{getcwd()}'
" To have only name and no path
" let g:airline_section_c = '%t'
" Remove tagbar information in vim airline
let g:airline#extensions#tagbar#enabled = 0
" enable/disable fugitive/lawrencium integration
" remove git branch name
let g:airline#extensions#branch#enabled = 0
" let g:airline#extensions#default#section_truncate_width = {
" \ 'c': 89,
" \ 'x': 60,
" \ 'y': 88,
" \ 'z': 45,
" \ 'warning': 80,
" \ 'error': 80,
" \ }
"vim-airline doesn't appear until I create a new split
set laststatus=2
"here is a pause when leaving insert mode
set ttimeoutlen=10
" END TO HAVE GOOD VIM AIRLINE SETTINGS

" Select all text
nmap <C-a> ggVG

" Initialize plugin system
" END VIM-PLUG

" allow backspacing over everything in insert mode
" p> 
set backspace=indent,eol,start

if has("vms")
    set nobackup            " do not keep a backup file, use versions instead
else
    set backup              " keep a backup file
endif
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " Pour LA BARRE À 80 CARATERES
        " Line length shall be limited to 100, a maximum of 140 is allowed.
        " only for linux
        if filereadable($HOME.'/vimfiles/bundle/nerdtree/plugin/NERD_tree.vim')
        else
            " For all text files set 'textwidth' to 78 characters.
            " To be combinated with 'set cc=100'
            autocmd FileType text setlocal textwidth=100
        endif

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default
        " position when opening a file.
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif
    augroup END
else
    set autoindent          " always set autoindenting on
endif " has("autocmd")

" SYMBOL FOR TABULATION
" Indentation type [tab || space]
let sbv_indentation_type="tab"
" Indentation length
let sbv_indentation_length=8
execute "set tabstop=". sbv_indentation_length
execute "set shiftwidth=". sbv_indentation_length
execute "set softtabstop=". sbv_indentation_length
if sbv_indentation_type == "space"
    set expandtab
endif
" Enabled / Disabled placeholder chars
let sbv_display_placeholder=1
" Charactere placeholder for tabulation [2 char]
let sbv_tab_placeholder='»·'
" Charactere placeholder for space [1 char]
let sbv_space_placeholder='·'
" To be removed to be worked with monokai colorscheme
" if !empty(sbv_display_placeholder)
" if has("patch-7.4.710")
" execute "set list listchars=tab:". sbv_tab_placeholder .",trail:". sbv_space_placeholder .",space:". sbv_space_placeholder
" else
" execute "set list listchars=tab:". sbv_tab_placeholder .",trail:". sbv_space_placeholder
" endif
" endif
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif


" Define LEADER KEY
:let mapleader = ","


" LINUX CODING STYLE !!!  linuxsty.vim
" let g:linuxsty_patterns = [ "/usr/src/", "/linux" ] " permet d'autoriser Linux Coding Style sur un repertoire OR
" nnoremap <silent> <leader>a :LinuxCodingStyle<cr> " disable on demand

" LA BARRE À 80 CARATERES
" Line length shall be limited to 100, a maximum of 140 is allowed.
" only for linux
if filereadable($HOME.'/vimfiles/bundle/nerdtree/plugin/NERD_tree.vim')
else
    set cc=100
endif

" NO BACK UP swap files on the cloud !!!
set nobackup
set nowritebackup
set noswapfile

"personal modifications if SublimeText plugin is not activated
"police + taille
":wset gfn=Monospace:h9

" removed to enable vim-airline
"set gfn=Monospace\ 9

"taille de police????
" FOR SOLARIZED THEME
syntax enable
set background=dark
"set t_Co=16
"set t_Co=256
"option name               default     optional
"------------------------------------------------
"g:solarized_termcolors=   16      |   256
"g:solarized_termtrans =   0       |   1
"g:solarized_degrade   =   0       |   1
"g:solarized_bold      =   1       |   0
"g:solarized_underline =   1       |   0
"g:solarized_italic    =   1       |   0
"g:solarized_contrast  =   "normal"|   "high" or "low"
"g:solarized_visibility=   "normal"|   "high" or "low"
"g:solarized_hitrail   =   0       |   1
"g:solarized_menu      =   1       |   0
"------------------------------------------------
" colorscheme solarized
" colorscheme gruvbox
" let g:solarized_contrast="high"    "default value is normal
" let g:gruvbox_contrast_dark ="hard"
" set termguicolors
if exists('g:gui_oni')
    " Statements here
else
    if filereadable($HOME.'/vimfiles/bundle/nerdtree/plugin/NERD_tree.vim')
        " colorscheme falcon
        colorscheme gruvbox
        set termguicolors
    else
        " Monokai
        " syntax on
        " colorscheme monokai
        colorscheme gruvbox
        " colorscheme falcon
        " If you are using a terminal which support truecolor like iterm2, enable the gui color by adding below setting in ~/.vimrc or ~/.vim/init.vim
        set termguicolors
        " Otherwise, use below setting to activate the 256 color in terminal
        " set t_Co=256  " vim-monokai now only support 256 colours in terminal.

        "if has('gui_running')
        "    set background=light
        "else
        "    set background=dark
        "endif
    endif
endif

"call togglebg#map("<F5>") */
"map <F5> <Esc>:call ToggleColor()<cr>

" START FUNCTION SWITCH COLOR
if v:version < 700 || exists('loaded_switchcolor') || &cp
    finish
endif

let loaded_switchcolor = 1

let paths = split(globpath(&runtimepath, 'colors/*.vim'), "\n")
let s:swcolors = map(paths, 'fnamemodify(v:val, ":t:r")')
let s:swskip = [ '256-jungle', '3dglasses', 'calmar256-light', 'coots-beauty-256', 'grb256' ]
let s:swback = 0    " background variants light/dark was not yet switched
let s:swindex = 0

function! SwitchColor(swinc)

    " if have switched background: dark/light
    if (s:swback == 1)
        let s:swback = 0
        let s:swindex += a:swinc
        let i = s:swindex % len(s:swcolors)

        " in skip list
        if (index(s:swskip, s:swcolors[i]) == -1)
            execute "colorscheme " . s:swcolors[i]
        else
            return SwitchColor(a:swinc)
        endif

    else
        let s:swback = 1
        if (&background == "light")
            execute "set background=dark"
        else
            execute "set background=light"
        endif

        " roll back if background is not supported
        if (!exists('g:colors_name'))
            return SwitchColor(a:swinc)
        endif
    endif

    " show current name on screen. :h :echo-redraw
    redraw
    execute "colorscheme"
endfunction

" STOP FUNCTION SWITCH COLOR

" Afficher numeros de lignes !!!!
:set nu
":set nonu
""ou
":set nu!

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

" CSCOPE : load of database (DB) with F2
function! LoadCscope()
    " cs reset
    :!find . \( -name "*.cpp" -o -name "*.[ch]" \)  -print > cscope.files
    " :!find /build/RT -name "*.[ch]"-print >> cscope.files 
    " :!find /build/COMMON -name "*.[ch]" -print >> cscope.files
    " :!find /build/ENV -name "*.[ch]" -print >> cscope.files
    :!cscope -b -i cscope.files
    sleep 3000m
    if filereadable('cscope.out')
        :cs add cscope.out
        " CCTreeLoadDB cscope.out
    endif
    " CTAG too
    " for C with YCM
    :!ctags -R --fields=+l --langmap=c:.c.h
    " for C++ with YCM
    " :!ctags -R --fields=+l
    " FOR C++ (attention ctags veut le <ctrl> de gauche + <k>
    " :!ctags -R --extra=+q
    "
    " RTags - Pour faire le .json & lancer l'indexation dans le repertoire du projet
    " if filereadable($HOME.'/rtags/Makefile')
    " :!cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
    " :!rc -J
    " endif
endfunc
function! DeleteCscope()
    if filereadable('cscope.out')
        :cs kill 0
        :cs kill 1
        :!rm cscope.out
        :!rm cscope.files
    endif
    if filereadable('GTAGS')
        :!rm GPATH
        :!rm GRTAGS
        :!rm GTAGS
    endif
    if filereadable('tags')
        :!rm tags
    endif
endfunc
" CSCOPE : load of database (DB) with F2 
" function! LoadCscope()
" :!find . \( -name "*.cpp" -o -name "*.[ch]" \)  -print > cscope.files
" :!cscope -b -i cscope.files
" " CTAG too
" :!ctags -R
" if filereadable('cscope.out')
" cs reset
" cs add cscope.out
" :!rm cscope.out
" :!rm cscope.files
" endif
" endfunc

" To use gen_tags plugin you need to do :
" generate the tags of global (useful if you don t have cscope working)
" :GenGtags
" The following mapping is set for GTAGS find function which use cscope interface (if_cscope).
" Ctrl+\ c    Find functions calling this function
" Ctrl+\ d    Find functions called by this function
" Ctrl+\ e    Find this egrep pattern
" Ctrl+\ f    Find this file
" Ctrl+\ g    Find this definition
" Ctrl+\ i    Find files #including this file
" Ctrl+\ s    Find this C symbol
" Ctrl+\ t    Find this text string


" NERD COMMENTER
" Set a language to use its alternate delimiters by default
"let g:NERDAltDelims_c = 1
"Pas avoir les [> <] quand on commente une zone avec déjà des comments:w
let g:NERDLPlace= "/*"
let g:NERDRPlace= "*/"
" let g:NERDUsePlaceHolders = 0
" let g:NERDDefaultNesting = 1

" shortcuts
map <C-k> <C-]>

" " SYNTASTIC (status line is disable if we add statusline of syntastic...) 
" "set statusline+=%#warningmsg#
" "set statusline+=%{SyntasticStatuslineFlag()}
" "set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
" " silent! nmap <F6> :SyntasticToggleMode<CR>
" function! ToggleErrors()
" let old_last_winnr = winnr('$')
" lclose
" if old_last_winnr == winnr('$')
" " Nothing was closed, open syntastic error location panel
" Errors
" endif
" endfunction
" nnoremap <silent> <C-e> :<C-u>call ToggleErrors()<CR>
" "autocmd VimEnter * SyntasticToggleMode " disable syntastic by default

" CONQUE GDB
let g:ConqueTerm_Color = 2         " 1: strip color after 200 lines, 2: always with color
let g:ConqueTerm_CloseOnEnd = 1    " close conque when program ends running
let g:ConqueTerm_StartMessages = 0 " display warning messages if conqueTerm is configured incorrectly


" -- Recherche (vim pour les humains)
set ignorecase " Ignore la casse lors dune recherche
set smartcase " Si une recherche contient une majuscule,
" re-active la sensibilite a la casse
set incsearch " Surligne les resultats de recherche pendant la
" saisie
set hlsearch " Surligne les resultats de recherche

" remplacer ESC par ;;
:imap jj <Esc>
" :map jj <Esc>

" CCTREE : load of database (DB)
function! LoadCCTree()
    if filereadable('cscope.out')
        CCTreeLoadDB cscope.out
    endif
endfunc
autocmd VimEnter * call LoadCCTree()
" CCTREE : Shortcuts
let g:CCTreeKeyTraceForwardTree = '>'
let g:CCTreeKeyTraceReverseTree = '<'
"let g:CCTreeKeyHilightTree = '<C-l>'        " Static highlighting
"let g:CCTreeKeySaveWindow = '<C-\>y'
"let g:CCTreeKeyToggleWindow = '<C-\>w'
"let g:CCTreeKeyCompressTree = 'zs'     " Compress call-tree
let g:CCTreeKeyDepthPlus = '<C-\>='
let g:CCTreeKeyDepthMinus = '<C-\>-'

" pas de retour à la ligne automatique
:set nowrap

" For GVIM remove bar !!!!
"set guioptions-=m  "menu bar
""set guioptions-=T  "toolbar
""set guioptions-=r  "scrollbar
"nmap <F11> :set guioptions-=m<CR>  "menu bar
"nmap <F12> :set guioptions-=T<CR>  "toolbar

function! ToggleGUICruft()
    " Aligner avec le else !!!!
    "if &guioptions=='imrL'
    if &guioptions=='i'
        exec('set guioptions=imTrL')
    else
        " Retire la scrollbar  
        "exec('set guioptions=i') 
        " Ne retire pas la scrollbar 
        "exec('set guioptions=irL') 
        "exec('set guioptions=imrL') 
        exec('set guioptions=i') 
    endif
endfunction


" by default, hide gui menus
set guioptions=i

" bind K to grep word under cursor (marche pas encore, problem de shell)
"nnoremap <silent> <K> :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

"g:CCTreeKeyTraceForwardTree = 'zm'
"g:CCTreeKeyTraceForwardTree = '<C-\>>'
"g:CCTreeKeyTraceReverseTree = '<C-\><'
"g:CCTreeKeyHilightTree = '<C-l>'
"g:CCTreeKeySaveWindow = '<C-\>y'
"g:CCTreeKeyToggleWindow = '<C-\>w
"g:CCTreeKeyCompressTree = 'zs'  
"g:CCTreeKeyDepthPlus = '<C-\>='
"g:CCTreeKeyDepthMinus = '<C-\>-'

" ALL SETTING FOR INDENTATION (be careful to disable Linux coding style plugin
" linuxsty.vim !!!!!

" LINUX CODING STYLE !!!  linuxsty.vim
" it seems we have the good indentation coding style with it :)
" let g:linuxsty_patterns = [ "/usr/src/", "/linux" ] " permet d'autoriser Linux Coding Style sur un repertoire OR
" a debugger !!!!
"nnoremap <silent> <F7> :LinuxCodingStyle<CR>     "just enable !!!!
"nnoremap <silent> <leader>a :LinuxCodingStyle<cr>     " just enable !!!!

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
" filetype plugin indent on

" tabulation
"set expandtab
"set shiftwidth=2
"set softtabstop=2

" autocmd FileType c setlocal expandtab shiftwidth=2 softtabstop=2
" autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

" vim-autoformat
" map <C-K> :pyf /home/lolo/Desktop/clang+llvm-3.9.0-x86_64-linux-gnu-ubuntu-16.04/share/clang/clang-format.py<cr>*/*/*/*/
" imap <C-K> <c-o>:pyf /home/lolo/Desktop/clang+llvm-3.9.0-x86_64-linux-gnu-ubuntu-16.04/share/clang/clang-format.py<cr>
"let g:formattepath = ['/home/lolo/Desktop/clang+llvm-3.9.0-x86_64-linux-gnu-ubuntu-16.04/share/clang/']

" Astyle ( pas utilisé à la place de vim-autoformat) 
" noremap <F3> :!astyle -A8 -s8 %<CR> nnoremap <leader>fs :!astyle -A8 -s8 %<cr>

" EASY MOTION (only one leader to press)
"map <Leader> <Plug>(easymotion-prefix)
map <Leader> <Plug>(easymotion-prefix)

" <Leader>f{char} to move to {char}
"map  <Leader>f <Plug>(easymotion-bd-f)
"nmap <Leader>f <Plug>(easymotion-overwin-f)
map  f <Plug>(easymotion-bd-f)
nmap f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
"nmap s <Plug>(easymotion-overwin-f2)

" Move to line
"map <Leader>L <Plug>(easymotion-bd-jk)
"nmap <Leader>L <Plug>(easymotion-overwin-line)
map L <Plug>(easymotion-bd-jk)
nmap L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" HIGHLIGHT LINE
"METHODE 1
"ATTENTION/WARNING, rend le system plus lent avec j/k !!!!!!!
" set cursorline
" highlight Cursorline cterm=underline
" highlight Cursorline cterm=bold
"METHODE 2
"colorscheme desert
" set cursorline
" hi CursorLine term=bold cterm=bold guibg=Grey40

" pour avoir la recherche en orange avec "*"
hi Search guibg=peru guifg=wheat
"highlight Normal ctermbg=NONE
"highlight nonText ctermbg=NONE

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

" Grep options
:let Grep_Default_Filelist = '*.c *.h *.txt'
" Rgrep -option + <word> 
" => 
" -i (ignore case)
"  -w (exact word matching)

" global variable to treat .txt files as Robot files.
":let g:robot_syntax_for_txt 
"Or to enable the syntax highlighting for just a specific file :
":setf robot

" c.vim
" ATTENTION remplacement du raccourci F9 par F10 dans le plugin c.vim dans le
" repertoire ftplugin et pas plugin
" car F9 est utilisé par NERDTree :)

" Add git log command (Fred. P)



" Gitv plugin
let g:Gitv_OpenHorizontal = 0
" Wrap Lines
" If set to 1 then line wrapping is enabled. This is useful if you have
" occasional very long commit messages.
let g:Gitv_WrapLines = 0
" Truncate Commit Subjects
" If set to 1 then commit subject truncation is enabled. This will truncate
" commit subjects, where necessary, so that the whole line will fit in one
" screen width. If this is set, then automatically switching to a horizontal
" layout will no longer work as commits will be truncated to always fit in a
" vertical split. NOTE: It is possible that this can truncate any refs pointing
" at a commit. In this situation it will not be possible to check out any of
" these refs. This is due to gitv being unable to recognise that they are refs.
let g:Gitv_TruncateCommitSubjects = 1

" To have a Terminal in Gvim (using plugin ConqueTerm)
" in ConqueTerm F8 and F11 has been replaced by symbol ¤ to don't interfer !!!!
" :ConqueTerm bash
" :ConqueTerm Powershell.exe
" :ConqueTermSplit
" :ConqueTermVSplit 
" :ConqueTermTab
" let g:ConqueTerm_SendFunctionKeys = 0


" TO ENABLE MARKDOWN
"If you'd like to force Markdown without installing from this repository, add the following to your vimrc:
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
"If you want to enable fenced code block syntax highlighting in your markdown documents you can enable it in your .vimrc like so:
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
"To disable markdown syntax concealing add the following to your vimrc:
"let g:markdown_syntax_conceal = 0
" TO DON'T HAVE RED UNDERSCORE 
" load :colorscheme spacemacs-theme
" and source again .vimrc
" Other solution
" syn match markdownError "\w\@<=\w\@="

" Gestion des fenêtres
"CTRL+w 10- retreci 10 car haut
"CTRL+w 15> augm 10 car largeur
":nnoremap <F12> <C-w>4+
":nnoremap <F11> <C-w>4>


" REPLACE F9 BY F10 IN C.VIM (USED BY NERDTREE)
"let s:C_Root                                   = '&C\/C\+\+.'           " the name of the root menu of this plugin
"let s:MenuRun         = s:C_Root.'&Run'
"exe "amenu  <silent>  ".s:MenuRun.'.save\ and\ &compile<Tab>\\rc\ \ \<A-F10\>         :call C_Compile()<CR>:call C_HlMessage()<CR>'
"exe "imenu  <silent>  ".s:MenuRun.'.save\ and\ &compile<Tab>\\rc\ \ \<A-F10\>    <C-C>:call C_Compile()<CR>:call C_HlMessage()<CR>'
"exe "amenu  <silent>  ".s:MenuRun.'.&link<Tab>\\rl\ \ \ \ \<F10\>                     :call C_Link()<CR>:call C_HlMessage()<CR>'
"exe "imenu  <silent>  ".s:MenuRun.'.&link<Tab>\\rl\ \ \ \ \<F10\>                <C-C>:call C_Link()<CR>:call C_HlMessage()<CR>'
"exe "amenu  <silent>  ".s:MenuRun.'.&run<Tab>\\rr\ \ \<C-F10\>                        :call C_Run()<CR>'
"exe "imenu  <silent>  ".s:MenuRun.'.&run<Tab>\\rr\ \ \<C-F10\>                   <C-C>:call C_Run()<CR>'
"exe "amenu  <silent>  ".s:MenuRun.'.cmd\.\ line\ &arg\.<Tab>\\ra\ \ \<S-F10\>         :call C_Arguments()<CR>'
"exe "imenu  <silent>  ".s:MenuRun.'.cmd\.\ line\ &arg\.<Tab>\\ra\ \ \<S-F10\>    <C-C>:call C_Arguments()<CR>'


" in ConqueTerm F8 and F11 has been replaced by symbol ¤ to don't interfer !!!!
" Use this key to toggle terminal key mappings. {{{
" Only mapped inside of Conque buffers.
if !exists('g:ConqueTerm_ToggleKey')
    let g:ConqueTerm_ToggleKey = '<¤>'
endif " }}}
" Use this key to execute the current file in a split window. {{{
" THIS IS A GLOBAL KEY MAPPING
if !exists('g:ConqueTerm_ExecFileKey')
    let g:ConqueTerm_ExecFileKey = '<¤>'
endif " }}}

" to define for windows !!!
" function! InstallVimPlug()
" " if filereadable($HOME.'/vimfiles/autoload/plug.vim')
" if filereadable($HOME.'/vimfiles/bundle/nerdtree/plugin/NERD_tree.vim')
" :source ~/_vimrc
" else
" :!mkdir ~/vimfiles/autoload/
" :!mkdir ~/vimfiles/bundle/
" :!git clone https://github.com/junegunn/vim-plug.git ~/vimfiles/autoload/
" :source ~/_vimrc
" :PlugInstall
" :source ~/_vimrc
" :PlugUpdate
" endif
" endfunc

" REDEFINITION SHORTCUTS CSCOPE
"cs Find this C symbol       
"cg Find this definition                     
"cc Find functions calling this function     
"ct Find this text string                    
"ce Find this egrep pattern                  
"cf Find this file                           
"ci Find files #including this file
"cd Find functions called by this function   

" <C-t> POUR REVENIR EN ARRIERE

function! Find_this_C_symbol()       
    :cs find s <cword> 
endfunc
function! Find_this_definition()                     
    :cs find g <cword> 
endfunc
function! Find_functions_calling_this_function()     
    :cs find c <cword>
endfunc
function! Find_this_text_string()                    
    :cs find t <cword>
endfunc
function! Find_this_egrep_pattern()                  
    :cs find e <cword> 
endfunc
function! Find_this_file()                           
    :cs find f <cfile> 
endfunc
function! Find_files_including_this_file()
    :cs find i <cfile>
endfunc
function! Find_functions_called_by_this_function()   
    :cs find d <cword>
endfunc

nmap cs :call Find_this_C_symbol()<CR>
nmap cg :call Find_this_definition()<CR>
nmap cc :call Find_functions_calling_this_function()<CR>
nmap ct :call Find_this_text_string()<CR>
nmap ce :call Find_this_egrep_pattern()<CR>
nmap cf :call Find_this_file()<CR>
nmap ci :call Find_files_including_this_file()<CR>
nmap cd :call Find_functions_called_by_this_function()<CR>

" nmap cs :cs find s <C-R>=expand("<cword>")<CR><CR>|  "Find this C symbol       
" nmap cg :cs find g <C-R>=expand("<cword>")<CR><CR>|  "Find this definition                     
" nmap cc :cs find c <C-R>=expand("<cword>")<CR><CR>|  "Find functions calling this function     
" nmap ct :cs find t <C-R>=expand("<cword>")<CR><CR>|  "Find this text string                    
" nmap ce :cs find e <C-R>=expand("<cword>")<CR><CR>|  "Find this egrep pattern                  
" nmap cf :cs find f <C-R>=expand("<cfile>")<CR><CR>|  "Find this file                           
" nmap ci :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>| "Find files #including this file
" nmap cd :cs find d <C-R>=expand("<cword>")<CR><CR>| "Find functions called by this function   

nmap _s :scs find s <C-R>=expand("<cword>")<CR><CR>     
nmap _g :scs find g <C-R>=expand("<cword>")<CR><CR>     
nmap _c :scs find c <C-R>=expand("<cword>")<CR><CR>     
nmap _t :scs find t <C-R>=expand("<cword>")<CR><CR>     
nmap _e :scs find e <C-R>=expand("<cword>")<CR><CR>     
nmap _f :scs find f <C-R>=expand("<cfile>")<CR><CR>     
nmap _i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>   
nmap _d :scs find d <C-R>=expand("<cword>")<CR><CR>     

nmap !s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
nmap !g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
nmap !c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
nmap !t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
nmap !e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
nmap !f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>        
nmap !i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>      
nmap !d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


if has("gui_running") || has("nvim")
    " NORMAL COPY AND PASTE SETTINGS 

    " Here is an excert from the mswin.vim file:-

    " CTRL-X and SHIFT-Del are Cut
    vnoremap <C-X> "+x
    " vnoremap <S-Del> "+x

    " CTRL-C and CTRL-Insert are Copy
    vnoremap <C-C> "+y
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

" CREATE DIRECTORY TO DO FULL INSTALLATION IF MISSING 
function! InstallVimPlug()
    "if filereadable($HOME.'/.vim/autoload/plug.vim')
    if filereadable($HOME.'/.vim/bundle/nerdtree/plugin/NERD_tree.vim')
        if filereadable($HOME.'/.vimrc')
            :source ~/.vimrc
            highlight Normal guibg=black
        endif
        if filereadable($HOME.'/_vimrc')
            :source ~/_vimrc
            highlight Normal guibg=black
        endif
    else
        :!mkdir ~/.vim/
        :!mkdir ~/.vim/autoload/
        :!git clone https://github.com/junegunn/vim-plug.git ~/.vim/autoload/
        :!mkdir ~/.vim/bundle/
        :PlugInstall
        :source ~/.vimrc
        :PlugUpdate
    endif
endfunc

" Function to switch a txt file on help syntax of vim
" This will help to do some small help file
"
" To generate the tags you need to do vim command
" moreover those tags can be between several files
" :helptags .
let syntaxActivated = 1
function! Syntax()
    if g:syntaxActivated == 1
        echo "syntax NOT activated" 
        let g:syntaxActivated = 0
        :syntax off
    else
        echo "syntax activated" 
        let g:syntaxActivated = 1
        :syntax on
        set syntax=help
        " Full black back ground (on windows, TBC on linux)
        highlight Normal guibg=black
    endif
endfunc

function! GetCmdCompletion(cmd_prefix)
    let [cwh,ls,v] = [&cwh, &ls, @v]
    set cwh=1 ls=0
    execute 'nn <buffer> z&u :' . a:cmd_prefix . '<c-a><c-f>"vyyo<cr>'
    normal z&u
    let res = split(@v)
    let [&cwh,&ls,@v] = [cwh,ls,v]
    return res
endfunction
" command mode completion
set wildmenu
set wildmode=longest,list,full


" ubuntu
if filereadable('/usr/lib/llvm-4.0/lib/libclang.so.1')
    let g:chromatica#libclang_path='/usr/lib/llvm-4.0/lib/libclang.so.1'
endif
" centos
if filereadable('/usr/lib64/llvm/libclang.so')
    let g:chromatica#libclang_path='/usr/lib64/llvm/libclang.so'
endif
let g:chromatica#enable_at_startup = 1

" space_vim_dark
" range:   233 (darkest) ~ 238 (lightest)
" Default: 235
let g:space_vim_dark_background = 233
" color space-vim-dark

" remove pipe in split BARRE
set fillchars=""
" choose character (*)
" set fillchars=vert:\*
if has("gui_running")
    " echo "has gui_running"
    autocmd! VimEnter,ColorScheme * hi VertSplit    guibg=DarkRed guifg=green gui=none
else
    " echo "does not have gui_running"
    autocmd! VimEnter,ColorScheme * hi VertSplit    ctermbg=52 ctermfg=52 cterm=none
endif
" autocmd! VimEnter,ColorScheme * hi VertSplit    ctermbg=5 ctermfg=5 cterm=none
" autocmd! VimEnter,ColorScheme * hi StatusLine    guibg=red guifg=red gui=none
" autocmd! VimEnter,ColorScheme * hi StatusLineNC    guibg=red guifg=red gui=none

" bufexplorer
" let g:bufExplorerDefaultHelp=0
" let g:bufExplorerShowRelativePath=1
" let g:bufExplorerFindActive=1
" let g:bufExplorerSortBy='name'
" map <leader>o :BufExplorer<cr>

function! RtagsInstall()
    " #https://github.com/Andersbakken/rtags
    :cd ~/
    :!git clone --recursive https://github.com/Andersbakken/rtags.git ~/rtags
    :cd ~/rtags
    :!cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
    :!mkdir ~/rtags/build
    :cd ~/rtags/build
    :!cmake ..
    :cd ~/rtags
    :!sudo make install
endfunc

function! YCMinstall()
    :cd ~/
    :!sudo apt-get install build-essential cmake
    :cd ~/.vim/bundle/YouCompleteMe/
    :!sudo apt-get install golang-go
    :!sudo ./install.py --clang-completer --gocode-completer
endfunc

function! LoadGlobal()
    :!gtags
endfunc


" HELP
"  _   _   _____   _       _____  
" | | | | | ____| | |     |  _  \ 
" | |_| | | |__   | |     | |_| | 
" |  _  | |  __|  | |     |  ___/ 
" | | | | | |___  | |___  | |     
" |_| |_| |_____| |_____| |_|     

"""""""""""""""""""""""""""""
" SHORTCUTS
"""""""""""""""""""""""""""""
map <F4>        :call SwitchColor(1)<CR>
imap <F4>   <Esc>:call SwitchColor(1)<CR>
map <F5>      :call SwitchColor(-1)<CR>
imap <F5> <Esc>:call SwitchColor(-1)<CR>
nnoremap <silent> <F9> :NERDTreeToggle<CR>
" nnoremap <silent> <F2> :call LoadCscope5GL1SW()<CR>
nmap ca :call LoadCscope()<CR>
nmap cz :GenGTAGS<CR>
nmap cq :call DeleteCscope()<CR>
" nmap !! :vsp<CR>
" nmap __ :sp<CR>
nmap <Space>w/ :vsp<CR>
nmap <Space>w- :sp<CR>
" nnoremap <silent> <F4> :call LoadCscope()<CR>
nmap <F8> :TagbarToggle<CR>
" nnoremap <silent> <F6> :SyntasticToggleMode<CR>
map <F7> <Esc>:call ToggleGUICruft()<cr>
noremap <F3> :Autoformat<CR> 

if filereadable($HOME.'/vimfiles/bundle/nerdtree/plugin/NERD_tree.vim')
    noremap <F2> :edit ~/_vimrc<CR> 
else
    noremap <F2> :edit ~/.vimrc<CR> 
endif

:nnoremap <S-u> <C-w>4>
:nnoremap <S-i> <C-w>4+
map <S-b> :bp<CR>
map <S-f> :bn<CR>
nnoremap <silent> <Space>t :ConqueTerm bash<CR>
nnoremap <silent> <Space>r :Rgrep
nnoremap <silent> <Space>i :call InstallVimPlug()<CR>
nnoremap <silent> <Space>c :ChromaticaStart<CR>
nnoremap <silent> <Space>g :Gstatus<CR>
nnoremap <silent> <Space>e :CCTreeLoadDB cscope.out<CR>
nnoremap <silent> <Space>d :diffthis<CR>
nnoremap <silent> <Space>p :cd %:p:h<CR>
nnoremap <silent> <Space>s :call Syntax()<CR>
nnoremap <silent> <Space>y :call YCMinstall()<CR>
nnoremap <silent> <Space>m :syn match markdownError "\w\@<=\w\@="<CR>
nnoremap <silent> <Space>n :NERDTreeFind<CR>
nnoremap <silent> <Space>qq :qa<CR>
nnoremap <silent> <Space>fs :w<CR>
" nmap ,n :NERDTreeFind<CR>
" nnoremap <silent> <Space>h :set syntax=help<CR>


nnoremap <silent> bo :BufExplorer<CR>
" nnoremap <silent> bb :BufExplorer<CR>
nnoremap <silent> bh :BufExplorerHorizontalSplit<CR>
nnoremap <silent> bv :BufExplorerVerticalSplit<CR>
" nnoremap <silent> bt :ToggleBufExplorer<CR>

" Move lines with SHIFT + J/K
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" RTAGS
noremap <Leader>ra :!~/rtags/bin/rdm &<CR>
noremap <Leader>rx :call RtagsInstall()<CR>

" " DENITE-GTAGS (que neovim )
nnoremap <leader>ga :DeniteCursorWord -buffer-name=gtags_context gtags_context<cr>
nnoremap <leader>gd :DeniteCursorWord -buffer-name=gtags_def gtags_def<cr>
nnoremap <leader>gr :DeniteCursorWord -buffer-name=gtags_ref gtags_ref<cr>
nnoremap <leader>gg :DeniteCursorWord -buffer-name=gtags_grep gtags_grep<cr>
nnoremap <leader>gt :Denite -buffer-name=gtags_completion gtags_completion<cr>
nnoremap <leader>gf :Denite -buffer-name=gtags_file gtags_file<cr>
nnoremap <leader>gp :Denite -buffer-name=gtags_path gtags_path<cr>
nnoremap <leader>gi :call LoadGlobal()<cr>
" <C-o> POUR REVENIR EN ARRIERE

" other
" nnoremap <S-Up> :m-2<CR>
" nnoremap <S-Down> :m+<CR>
" inoremap <S-Up> <Esc>:m-2<CR>
" inoremap <S-Down> <Esc>:m+<CR>
" LeaderGuide 
nnoremap , :<C-U>LeaderGuide ','<CR>
if filereadable($HOME.'/.vim/bundle/nerdtree/plugin/NERD_tree.vim')
    nnoremap <Space> :<C-U>LeaderGuide '<Space>'<CR>
endif
nnoremap c :<C-U>LeaderGuide 'c'<CR>
" nnoremap g :<C-U>LeaderGuide 'g'<CR>
" nnoremap b :<C-U>LeaderGuide 'b'<CR>

" multi cursor like VS CODE
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-t>'
let g:multi_cursor_quit_key='<Esc>'

" vim-multiple-cursors Setup {{{
if filereadable($HOME.'/vimfiles/bundle/nerdtree/plugin/NERD_tree.vim')
else
    function! Multiple_cursors_before()
        call youcompleteme#DisableCursorMovedAutocommands()
    endfunction

    function! Multiple_cursors_after()
        call youcompleteme#EnableCursorMovedAutocommands()
    endfunction
    " }}}
endif

:nnoremap <c-p> :FZF<cr>
" SET CASE
" :set ic
" To go back to case-sensitive searches use:
" :set noic

"
"
" VIMDIFF
" :nohls	Annuler recherche en surbrillance
" :diffthis	Marque un buffer pour vimdiff
" :diffoff	Retire le marquage
" do		Récupére les changements de l'autre fenêtre (:diffget)
" dp		Envoyer les changements de la fenêtre courante vers l'autre (:diffput)
" ]c		Prochain changement
" [c		Précédent changement
" ctrl+w ctrl+w bascule de fenêtre 
"
" BUFFERS
" :bp :bn	Buffer précédent suivant
" :ls		List buffers
" :b1		Buffer 1
" :bd8		delete buffer 8
" :%bd		delete all buffers
" :1,3bd	delete de 1 à 3
":
" TABULATIONS
" :TabNew	Nouvelle tabulation
" :gt :gT	Avance recule d'une tabulation
"
" :e		Recharge le fichier
" :enew		Créé un fichier vide pas encore enregistré
" :saveas essai.txt	enregistre le nouveau fichier
" :set autoread	Ca recharge tout seul
"
" :set nowrap	Pas de retour à la ligne:w
"
" Balises
" :ma		marqueur a
" :'a		va au marqueur a
" :marks	list des marques
"
" ctrl+g	path du fichier
"
" :help folding	les replis !
" :zf		créé repli
" :zo zc zd	ouvre ferme supprime
" :zR zM	ouvre/ferme TOUT
" :zm zr	augmente/diminue niveau
" :zE zO	supprime/ouvre tous les replis sous le curseur
"
" REGISTRES
" :registres	on voit tous les buffers de copier/coller
" "%p		path du fichier en cours
"
" ctrl+r "	COPY IN COMMAND MODE
" ctrl+r ctrl+o "	(if leteral control characters)
"
" :edit ~/.vimrc	EDIT .VIMRC
"
" :messages	Voir tous les messages d'erreur !!!!
"
" ddp		inverse la ligne courante et celle du dessous
"
" REMPLACER (Regex)
" :%s/char1/char2/gc		c pour avoir demande de confirmation
" :1,10s/char1/char2/gc		c pour avoir demande de confirmation
" %		sur la totalité du doc
" s		Appliquer sur la chaine
" $		represente la fin de la ligne
" ^		represente la début de la ligne
" https://ensiwiki.ensimag.fr/index.php?title=Expressions_r%C3%A9guli%C3%A8res
" ^M		Retour chariot DOS
" \r		Retour chariot UNIX
" .		N'importe quel nombre
" *		N'importe quel caractere
" &		La ligne source
"
" to remove ^M
" :%s/\r//gc
"
" To add 'echo "' under each line with line after
":%s/.*/&^Mecho '&'
"
" To change to the directory of the currently open file (this sets the current directory for all windows in Vim):
" :cd %:p:h

" Remove empty line
":g/^$/d

" will show you a history of your commands.
" :history 
" In normal mode, q: will open your history in a new buffer.
"
" LINUX search
" find . -name foo*
" grep -R foo*
" 

" ATTENTION IL FAUT SE METTRE EN 'SUDO' SI ON DEBUG ATTACHE A UN PROCESS 
" AVEC GDB. QUELQUE SOIT L'IDE !!!!!!
" SINON CA NE MARCHE PAS
" _____ _____  ____  
" / ____|  __ \|  _ \ 
" | |  __| |  | | |_) |
" | | |_ | |  | |  _ < 
" | |__| | |__| | |_) |
" \_____|_____/|____/ 
" CONQUE GDB
"gcc -g flex_const.c -o parse
"sous vim ->
":ConqueGdb parse
"Use :ConqueGdbSplit parse or :ConqueGdbVSplit parse to open GDB in a new horizontal or vertical buffer
"leader r :     run 
"leader c :     continue
"leader s :     step (go in function)
"leader n :     next

" if !exists('gdbActivated')
" let gdbActivated = 1
" endif

" " let gdbActivated = 1
" function! ToggleGdb(gdbActivated)
" if g:gdbActivated == 1
" let g:gdbActivated = 0
" let g:ConqueGdb_Disable = 1
" " let g:ConqueGdb_Next = g:ConqueGdb_Leader . 'n' 
" " let g:ConqueGdb_Run = g:ConqueGdb_Leader . 'r' 
" " let g:ConqueGdb_Continue = g:ConqueGdb_Leader . 'c' 
" " let g:ConqueGdb_Step = g:ConqueGdb_Leader . 's' 
" " let g:ConqueGdb_Print = g:ConqueGdb_Leader . 'p' 
" " let g:ConqueGdb_ToggleBreak = g:ConqueGdb_Leader . 'b' 
" " let g:ConqueGdb_Finish = g:ConqueGdb_Leader . 'f' 
" " let g:ConqueGdb_Backtrace = g:ConqueGdb_Leader . 't' 
" echo "gdb NOT activated" 
" else
" let g:gdbActivated = 1
" let g:ConqueGdb_Disable = 0
" let g:ConqueGdb_Next = 'n' 
" let g:ConqueGdb_Run = 'r' 
" let g:ConqueGdb_Continue = 'c' 
" let g:ConqueGdb_Step = 's' 
" let g:ConqueGdb_Print = 'p' 
" let g:ConqueGdb_ToggleBreak = 'b' 
" let g:ConqueGdb_Finish = 'f' 
" let g:ConqueGdb_Backtrace = 't' 
" echo "gdb activated" 
" endif
" endfunction

" nnoremap <silent> <leader>g :call ToggleGdb(gdbActivated)<CR>

" let g:ConqueGdb_Next = 'n' 
"
"leader p :     print variable under cursor
"leader b :     breakpoint
"leader f  :    finish
"q              pour quitter d
"

"(gdb) run
" Starting program: /home/testuser/hello
" Hello, World
" [Inferior 1 (process 8442) exited normally]
" in expected terminal - tty
" (gdb) tty /dev/pts/11
" (gdb) show inferior-tty
" in expected terminal - echo $TERM (=> name ?)
" (gdb) set env TERM=name
" in expected terminal sleep 1000000
" Terminal for future runs of program being debugged is "/dev/pts/11".
" in expected terminal resize -s 50 80
" (gdb) run
" OR !!!!!!!!!!!!!
" (vim or emacs launch with sudo !!!!!!)
" You can launch exe in other terminal and check processus (top -> PID ?)
" SO, in GDB you can launch and debug with 
" gdb <exe> <PID>
" :)
"  _______     _______ _      ________          ___   _ 
" |  __ \ \   / / ____| |    |  ____\ \        / / \ | |
" | |__) \ \_/ / |    | |    | |__   \ \  /\  / /|  \| |
" |  ___/ \   /| |    | |    |  __|   \ \/  \/ / | . ` |
" | |      | | | |____| |____| |____   \  /\  /  | |\  |
" |_|      |_|  \_____|______|______|   \/  \/   |_| \_|
" "
" NEW GDB DEBUGGER PYCLEWN TO CONFIGURE 
" INSTALLATION
" pip install --user pyclewn
" python -c "import clewn; clewn.get_vimball()"

" See the vimball documentation with the vim command :help vimball.
" vim someplugin.vba
" :so %
" :q

" settings
:let g:pyclewn_terminal = "xterm, -e"
:let g:pyclewn_args="--tty=/dev/pts/0"

" Command list
" Pyclewn  gdb src/cassebrique
" Cmapkeys
" Cexitclewn
" Cfile src/cassebrique
" Csource src/cassebrique

"
" WARNING 
"
" Attention pour debugger avec netbeans il faut etre root !!!!!
" donc lancer avec la commande 
" sudo netbeans
" sinon le mode debug ne fonctionne a cause de gdb qui empeche d ouvrir le terminal
" normalement le probleme devrait etre resolu apres la version 7.1 de gdb
" _      _      _____  ____  
" | |    | |    |  __ \|  _ \ 
" | |    | |    | |  | | |_) |
" | |    | |    | |  | |  _ < 
" | |____| |____| |__| | |_) |
" |______|______|_____/|____/ 

" sous UBUNTU :
" wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
" sudo apt-get install clang-4.0 lldb-4.0

" NEW LLDB DEBUGGER PYCLEWN TO CONFIGURE (surtout NVIM)
" :LLsession new
" :LLmode debug (ne pas lancer la target, effacer 'y')
" process attach --name cassebrique
" :LL step
" :LLmode code (c est comme pour revenir a lenvironement du code)
" :LL process interrupt
" :LL process kill
"
nmap <M-b> <Plug>LLBreakSwitch
" vmap <F2> <Plug>LLStdInSelected
nnoremap <silent> <M-s> :LL step<CR>
nnoremap <silent> <M-n> :LL next<CR>
" nnoremap <F5> :LLmode debug<CR>
" nnoremap <S-F5> :LLmode code<CR>
" nnoremap <F8> :LL continue<CR>
" nnoremap <S-F8> :LL process interrupt<CR>
nnoremap <M-p> :LL print <C-R>=expand('<cword>')<CR>
" vnoremap <F9> :<C-U>LL print <C-R>=lldb#util#get_selection()<CR><CR>
"
"
"
" " TO KEEP and add
" " echo "0 - Installer VIM 8"
" cd ~/
" git clone https://github.com/vim/vim.git
" sudo yum install ncurses-devel
" cd ~/vim/src
" make
" sudo make install /usr/local/
" sudo cp /usr/local/bin/* /usr/bin/

" " echo "6 - Installer NEOVIM"
" sudo yum install neovim.x86_64
" mkdir ~/.config/nvim
" ln -s ~/.vimrc ~/.config/nvim/init.vim
" ln -s ~/.vim/autoload ~/.config/nvim/autoload
" ln -s ~/.vim/bundle ~/.config/nvim/bundle
" # copy/paste classique OK avec neovim
" sudo yum install xclip
" # terminal OK (il faut upgrade python)
" sudo pip2 install --upgrade neovim

" " echo "5 - PYTHON3 + CLANG TBT"
" # sudo yum install python34-setuptools # déja installé normalement
" sudo easy_install-3.4 pip
" sudo pip3 install neovim
" # sudo yum install clang-4.0 lldb-4.0  # déja installé normalement

" # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" # install clang or not if exists
" # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" program="clang"
" condition=$(which $program 2>/dev/null | grep -v "not found" | wc -l)
" if [ $condition -eq 0 ] ; then
" echo "$program is not installed"
" sudo yum -y install clang
" fi
" Full black back ground (on windows, TBC on linux)
highlight Normal guibg=black

" Regular expression
"	*	matches any sequence of characters
"	?	matches any single character
"	\?	matches a '?'
"	.	matches a '.'
"	~	matches a '~'
"	,	separates patterns
"	\,	matches a ','
"	{ }	like \( \) in a |pattern|
"	,	inside { }: like \| in a |pattern|
"	\	special meaning like in a |pattern|
"	[ch]	matches 'c' or 'h'
"	[^ch]   match any character but 'c' and 'h'

:let g:airline_theme='cool'

" INSTALLER RTAGS
" #https://github.com/Andersbakken/rtags
" # A faire au début ?
" git clone --recursive https://github.com/Andersbakken/rtags.git
" cd rtags
" cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
" make

" # Pour installer RTAGS
" cd rtags
" mkdir build
" cd build
" cmake ..
" cd ..
" sudo make install

" # Lancer le serveur de RTAGS (dans un terminal dédié)
" ~/rtags/bin/rdm &

" # Pour faire le .json & lancer l'indexation dans le repertoire du projet
" cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 .
" rc -J

" " YouCompleteMe
" " install
" sudo apt-get install build-essential cmake
" cd .vim/bundle/YouCompleteMe/
" sudo apt-get install golang-go
" ./install.py --clang-completer --gocode-completer


" In CMakeLists.txt 
" add 
"set( CMAKE_EXPORT_COMPILE_COMMANDS ON )


" Add in .vimrc :
" "Youcompleteme fix
" let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" Dans ce meme fichier, donner le "path" de la racine du projet

"Youcompleteme fix
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_collect_identifiers_from_tags_files = 1

" DENITE 
" Chercher un fichier en recursif
" :Denite file_rec 
" Chercher le nom d'une commande (dans command line mode)
" :Denite command
" Change matchers.to have exact matching of the string in result (NO separate string)
if has('nvim')
    call denite#custom#source('file_rec', 'matchers', ['matcher_substring'])
endif
