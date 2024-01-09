# ____  __    _  _   ___  __  __ _ 
#(  _ \(  )  / )( \ / __)(  )(  ( \
# ) __// (_/\) \/ (( (_ \ )( /    /
#(__)  \____/\____/ \___/(__)\_)__)

evaluate-commands %sh{
        plugins="$kak_config/plugins"
            mkdir -p "$plugins"
                [ ! -e "$plugins/plug.kak" ] && \
                        git clone -q https://github.com/andreyorst/plug.kak.git "$plugins/plug.kak"
                            printf "%s\n" "source '$plugins/plug.kak/rc/plug.kak'"
                            }
                            plug "andreyorst/plug.kak" noload

plug "andreyorst/fzf.kak" config %{
    map global normal <c-p> ':fzf-mode<ret>' # note that the space after colon is intentional to suppess fzf-mode to show in command history
} defer fzf-file %{
    set-option global fzf_file_command 'fd' # 'ag', 'fd', or 'find'
    set-option global fzf_highlight_command 'bat --color=always --style=numbers {}'
} defer fzf-grep %{
    set-option global fzf_grep_command 'rg' # 'ag', or 'find'
    set-option global fzf_grep_preview_command 'bat'
}

plug Delapouite/kakoune-buffers

plug "andreyorst/smarttab.kak" defer smarttab %{
    # when `backspace' is pressed, 4 spaces are deleted at once
    set-option global softtabstop 4
} config %{
    # these languages will use `expandtab' behavior
    hook global WinSetOption filetype=(rust|markdown|kak|lisp|scheme|sh|perl|c|cpp) expandtab
    # these languages will use `noexpandtab' behavior
    hook global WinSetOption filetype=(makefile|gas) noexpandtab
    # these languages will use `smarttab' behavior
    # hook global WinSetOption filetype=(c|cpp) smarttab
}
set global tabstop 4 
set global indentwidth 4

plug "Crote/kakoune-ranger.git"

plug "andreyorst/powerline.kak" defer powerline_gruvbox %{
    powerline-theme gruvbox
} config %{
    powerline-start
}

plug "kak-lsp/kak-lsp" do %{
        cargo install --locked --force --path .
            # optional: if you want to use specific language servers
            #     mkdir -p ~/.config/kak-lsp
            #         cp -n kak-lsp.toml ~/.config/kak-lsp/
}
hook global WinSetOption filetype=(rust|python|c|cpp|markdown|lua) %{
        lsp-enable-window
}
# Navigate in markdown :
# install marksman in ~/.local/bin/
# And add config in .config/kak-lsp/kak-lsp.toml :
# [language_server.markdown] # NOTE for kak-lsp < 15.0.0 this would need to be `[language.markdown]`
# filetypes = ["markdown"]
# roots = [".marksman.toml"]
# command = "marksman"
# args = ["server"]
# also create an empty .marksman.toml in the root folder of your project or initialize a repository (e.g. git init)

# Use the formatter dprint for markdown :
# cargo install --locked dprint
# dprint init (in project)
hook global WinSetOption filetype=markdown %{
    # set window formatcmd 'dprint fmt %val{buffile}'  # old, not work
    set-option buffer formatcmd "dprint fmt %val{buffile}"
}

# plug-chain "andreyorst/plug.kak" noload \
plug "tom-huntington/simple-git-gutter.kak"

# To be fully added with shortcuts
plug "gustavo-hms/luar" %{
    require-module luar
    plug "gustavo-hms/peneira" %{
        require-module peneira
    }
}
plug "enricozb/popup.kak"
evaluate-commands %sh{kak-popup init}
# Install the binary with : 'cargo install kak-popup'
# popup --title open --kak-script %{edit %opt{popup_output}} -- fzf --preview 'bat --color=always {}' --preview-window '~3'
# use the scritp with fzf + ripgrep + bat to have grep with color preview

# TO COMMENT OTERWISE IT IS BREAKING COPY / PASTE
# plug "anhsirk0/kakoune-themes"
# cp .config/kak/plugins/kakoune-themes/colors ~/.config/kak/ -r

plug "evanrelf/byline.kak" config %{  # x to expand more lines
  require-module "byline"
}

plug "fsub/kakoune-mark"config %{    # clone yourself if mark.kak is not in directory .config/kak/plugins/kakoune-mark/
    map global user a :mark-word<ret> -docstring 'Highlight word'
    map global user A :mark-clear<ret> -docstring 'Unhighlight words'
}

plug "dracula/kakoune"
# Add dracula.kak to your colors directory.

# DAP for cpp as in vscode
# to be found and tested ...
# https://github.com/memsharded/hello
# cmake . -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=1

# ____  ____  ____  ____  __  __ _   ___ 
#/ ___)(  __)(_  _)(_  _)(  )(  ( \ / __)
#\___ \ ) _)   )(    )(   )( /    /( (_ \
#(____/(____) (__)  (__) (__)\_)__) \___/
## COLORS ##

# addhl global/ column '%val{cursor_column}' default,magenta
# addhl global/ column '%val{cursor_column}' default,black
addhl global/ line '%val{cursor_line}' default,black
# colorscheme gruvbox-dark
# colorscheme ef-winter
colorscheme mygruvbox

# Whenever a window switches to insert mode,
# override its Default face to have a red background
# black, red, green, yellow, blue, magenta, cyan, white, bright-black, bright-red, bright-green, bright-yellow bright-blue, bright-magenta, bright-cyan, bright-white
hook global ModeChange .*:insert %{ set-face window Default default,black}
# Whenever a window leaves insert mode,
# remove its override of the Default face
hook global ModeChange .*:insert:.* %{ unset-face window Default }

# default black background
# set-face global Default black

############################################# SHORTKEYS ###########################
# To paste
# ! xsel --output --clipboard <ret>

# install bat with 'cargo install --locked bat'
# fzf and rzf with popup
#     --bind 'enter:become(echo {1} {2})', prob is that kak do ":e 'rfzk 13'" rather that ":e rfzk 13"
map global user -docstring 'popup fzf (NO TMUX)' F ':popup --title open --kak-script %{edit %opt{popup_output}} -- fzf --preview "bat --color=always {}" --preview-window "~3"<ret>'
map global user -docstring 'popup rzf (NO TMUX)' G ':popup --title open --kak-script %{edit %opt{popup_output}} -- fr<ret>'

# fzf and frf with nothing
map global user -docstring 'open fuzzy finder (TMUX)' f ': edit %sh{fzf-tmux --color=16 --preview "bat --theme=Nord --style=numbers,changes --color always {}" -}<ret>'
# The script here for fzf+ripgrep need to use fzf-tmux rather than only fzf
map global user -docstring 'open fuzzy finder (TMUX)' g ': edit %sh{frf -}<ret>'

map global user P '!xsel --output --clipboard<ret>' -docstring 'Paste before' # Paste before
map global user p '<a-!>xsel --output --clipboard<ret>' -docstring 'Paste after' # Paste after
map global user o ':clangd-switch-source-header<ret>' -docstring 'Switch to header file'
map global user c ':comment-line<ret>' -docstring 'To comment the line'
set-option current comment_block_begin '/*'
set-option current comment_block_end '*/'
map global user C ':comment-block<ret>' -docstring 'To comment the block'
map global user ) '<a-i>)<S>,<ret><a-)>' -docstring 'Swap Arguments'
map global user r ':ranger-select<ret>' -docstring 'select files in ranger'
hook global WinDisplay .* info-buffers
map global user b ':enter-buffers-mode<ret>'              -docstring 'buffers…'
map global user B ':pick-buffers<ret>'   -docstring 'pick-buffers'
alias global bd delete-buffer
alias global bf buffer-first
alias global bl buffer-last
alias global bo buffer-only
alias global bo! buffer-only-force
map global user w ':w<ret>'   -docstring 'Write buffers'
map global user q ':q<ret>'   -docstring 'Quit Kakoune'
map global user d ':echo %sh{pwd}<ret>'   -docstring 'Get the path (d)irectory'
map global user s ':set buffer filetype sh<ret>'   -docstring 'filetype sh'

map global normal <F3> '|clang-format<ret>'  # use the pipe on selection
# :set buffer filetype 'sh'  # to set file type of file
map global normal <F5> ':%sh{love .}<ret>'
map global normal <F7> ':bn<ret>'
map global normal <F6> ':bp<ret>'

# for lsp selection
map global user l %{:enter-user-mode lsp<ret>} -docstring "LSP mode"
map global insert <tab> '<a-;>:try lsp-snippets-select-next-placeholders catch %{ execute-keys -with-hooks <lt>tab> }<ret>' -docstring 'Select next snippet placeholder'
map global object a '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object <a-a> '<a-semicolon>lsp-object<ret>' -docstring 'LSP any symbol'
map global object e '<a-semicolon>lsp-object Function Method<ret>' -docstring 'LSP function or method'
map global object k '<a-semicolon>lsp-object Class Interface Struct<ret>' -docstring 'LSP class interface or struct'
map global object d '<a-semicolon>lsp-diagnostic-object --include-warnings<ret>' -docstring 'LSP errors and warnings'
map global object D '<a-semicolon>lsp-diagnostic-object<ret>' -docstring 'LSP errors'

map global user h ':addhl buffer/ show-whitespaces<ret>' -docstring 'to Highlight whitespaces'
map global user H ':rmhl buffer/show-whitespaces<ret>' -docstring 'to remove Highlight whitespaces'

# Use ripgrep instead of grep
# set-option global grepcmd 'rg -Hn --no-heading'
alias global 'g' 'grep'
set-option global grepcmd 'rg --column --smart-case --sort path'
define-command gn %{set-option global grepcmd 'rg --column --smart-case --sort path'} -docstring 'set-option grep normal'
define-command ga %{set-option global grepcmd 'rg -u --column --smart-case --sort path'} -docstring 'set-option grep all'

define-command -docstring "vsplit [/]: split tmux vertically" \
vsplit -params .. -command-completion %{
        tmux-terminal-horizontal kak -c %val{session} -e "%arg{@}"
}
define-command -docstring "split [=]: split tmux horizontally" \
split -params .. -command-completion %{
        tmux-terminal-vertical kak -c %val{session} -e "%arg{@}"
}
map global user / ':tmux-terminal-horizontal kak -c %val{session}<ret>' -docstring 'Split vertical'
map global user = ':tmux-terminal-vertical kak -c %val{session}<ret>' -docstring 'Split horizontal'

# Remove delete or change selection in yank buffer 
map global normal c \"_c
map global normal d \"_d
# search case insensitive
map -docstring 'case insensitive search' global normal / '/(?i)'
map -docstring 'case insensitive backward search' global normal <a-/> '<a-/>(?i)'
map -docstring 'case insensitive extend search' global normal ? '?(?i)'
map -docstring 'case insensitive backward extend-search' global normal <a-?> '<a-?>(?i)'

# Always keep one line and three columns displayed around the cursor
set-option global scrolloff 5,5

hook global InsertChar j %{ try %{ # jj to escape
      exec -draft hH <a-k>jj<ret> d
        exec <esc>
}}

# https://github.com/mawww/kakoune/wiki/Registers---Clipboard
# with xsel to install first
# To yank (copy)
hook global NormalKey y|d|c %{ nop %sh{
  printf %s "$kak_main_reg_dquote" | xsel --input --clipboard
}}

# set build preference here
#set-option global makecmd 'make -j16'
# with path
#set-option global makecmd 'make -C hello'
# create commands
#define-command makehello %{set-option global makecmd 'make -j16 -C hello'}

# will open new windows with tmux 
define-command ide %{
    rename-client main
    set-option global jumpclient main

    new rename-client tools
    set-option global toolsclient tools

    new rename-client docs
    set-option global docsclient docs
}
# Change cursor color in insert mode:
hook global ModeChange ".*:normal" %{
    set-face global PrimaryCursor      green,green
}
hook global ModeChange ".*:insert" %{
    set-face global PrimaryCursor      red,red
}

eval %sh{ kak-tree-sitter -dks --session $kak_session }
# install kak-tree-sitter with : 'cargo install kak-tree-sitter' and 'cargo install ktsctl'
# 'kak-tree-sitter' needs a config.toml file in ~/.config/kak-tree-sitter. 
#   Try copying the one in the repo GitHub
# You need to run 'ktsctl -fci cpp' to install the cpp grammar(+markdown). Without that, kak-tree-sitter doesn’t know how to handle cpp files.

add-highlighter global/ wrap  # wrap line

######### TBU ######################################################

# Highlight the word under the cursor
declare-option -hidden regex curword
set-face global CurWord default,rgb:4a4a4a
hook global NormalIdle .* %{
    eval -draft %{ try %{
        exec <space><a-i>w <a-k>\A\w+\z<ret>
        set-option buffer curword "\b\Q%val{selection}\E\b"
    } catch %{
        set-option buffer curword ''
    } }
}
add-highlighter global/ dynregex '%opt{curword}' 0:CurWord

# set-option global grepcmd 'ag --column'
# set-option global clang_options -std=c++1y
set-option global ui_options ncurses_status_on_top=true
add-highlighter global/ show-matching
add-highlighter global/ dynregex '%reg{/}' 0:+u
hook global WinCreate ^[^*]+$ %{ add-highlighter window/ number-lines -hlcursor }

define-command -override -docstring "select a word under cursor, or add cursor on next occurrence of current selection" \
select-or-add-cursor %{ execute-keys -save-regs '' %sh{
        if [ $(expr $(echo $kak_selection | wc -m) - 1) -eq 1 ]; then
                echo "<a-i>w*"
                    else
                            echo "*<s-n>"
                                fi
}}

#  ____  ____  ____    __    ___ 
# (_  _)(  _ \( ___)  /__\  / __)
#  _)(_  )(_) ))__)  /(__)\ \__ \
# (____)(____/(____)(__)(__)(___/
                              
# fish as default
# chsh -s `which fish`
# https://stackoverflow.com/questions/2762994/how-to-define-an-alias-in-fish-shell
#  PLUGIN
#  ───────────────

# use shell command to launch .sh with
# :echo %sh{<cmd>}

# To remove/adapt ???
# map global normal <space> , -docstring 'leader'
# map global normal <backspace> <space> -docstring 'remove all sels except main'
# map global normal <a-backspace> <a-space> -docstring 'remove main sel'

# source ~/.config/kak/plugins/plug.kak/rc/plug.kak

# Only for terminal example
# export FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --preview 'bat --color=always --style=header --style=numbers,grid --line-range :300 {}'"

#plug "ualexherbo2/connect.kak"

# map global normal <F2> ':e ~/.config/kak/kakrc<ret>'

# map global user B ':enter-user-mode -lock buffers<ret>'   -docstring 'buffers (lock)…'
# map global normal <F3> '|clang-format<ret>'

# show-whitespaces
# :addhl buffer/ show-whitespaces
# :rmhl buffer/show-whitespaces

# map global insert <tab> '<a-;><gt>'
# map global insert <s-tab> '<a-;><lt>'

# add-highlighter global/ show-whitespaces

# hook global WinSetOption filetype=c|cpp %{
#   set window formatcmd 'clang-format'
#  clang-enable-autocomplete; clang-enable-diagnostics
# }
# map global normal = :format<ret> -docstring 'format buffer'

# <c-d> to select for multi-cursors
# map global normal '<c-n>' ': select-or-add-cursor<ret>' -docstring "add cursor on current word, and jump to the next match"

# map global user g ':cscope ' -docstring 'Find tag with cscope'  # Pour cscope il faut surligner le mot à chercher

# OLD TAGBAR to see if we keep ?
# For this plugin to work, you need working ctags and readtags programs. 
# Note that readtags isn't shipped with exuberant-ctags by default (you can use universal-ctags).
# plug "andreyorst/tagbar.kak" defer "tagbar" %{
#     set-option global tagbar_sort false
#     set-option global tagbar_size 40
#     set-option global tagbar_display_anon false
# } config %{
#     # if you have wrap highlighter enamled in you configuration
#     # files it's better to turn it off for tagbar, using this hook:
#     hook global WinSetOption filetype=tagbar %{
#         remove-highlighter window/wrap
#         # you can also disable rendering whitespaces here, line numbers, and
#         # matching characters
#     }
# }
# hook global WinSetOption filetype=(c|cpp|rust) %{
#     tagbar-enable
# }
# map global normal <F8> ':tagbar-toggle<ret>'
# # To see what filetypes are supported use `ctags --list-kinds | awk '/^\w+/'
# hook global WinSetOption filetype=(cpp|rust) %{
#     tagbar-enable
#     alias global 'q' 'tagbar-quit'
#     alias global 'wq' 'tagbar-write-quit'
# }


# plug "andreyorst/kaktree" config %{
#     hook global WinSetOption filetype=kaktree %{
#         remove-highlighter buffer/numbers
#         remove-highlighter buffer/matching
#         remove-highlighter buffer/wrap
#         remove-highlighter buffer/show-whitespaces
#     }
#     kaktree-enable
# }
# map global normal <F9> ':kaktree-toggle<ret>'

