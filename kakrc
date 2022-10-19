# fish as default
# chsh -s `which fish`
# https://stackoverflow.com/questions/2762994/how-to-define-an-alias-in-fish-shell
#  PLUGIN
#  ───────────────

# use shell command to launch .sh with
# :echo %sh{<cmd>}

map global normal <space> , -docstring 'leader'
map global normal <backspace> <space> -docstring 'remove all sels except main'
map global normal <a-backspace> <a-space> -docstring 'remove main sel'

# source ~/.config/kak/plugins/plug.kak/rc/plug.kak
 ____  __    _  _   ___  __  __ _ 
(  _ \(  )  / )( \ / __)(  )(  ( \
 ) __// (_/\) \/ (( (_ \ )( /    /
(__)  \____/\____/ \___/(__)\_)__)

evaluate-commands %sh{
        plugins="$kak_config/plugins"
            mkdir -p "$plugins"
                [ ! -e "$plugins/plug.kak" ] && \
                        git clone -q https://github.com/andreyorst/plug.kak.git "$plugins/plug.kak"
                            printf "%s\n" "source '$plugins/plug.kak/rc/plug.kak'"
                            }
                            plug "andreyorst/plug.kak" noload


plug "andreyorst/fzf.kak"
# plug "dryvenn/kakoune-cscope"
plug Delapouite/kakoune-buffers

plug "andreyorst/kaktree" config %{
    hook global WinSetOption filetype=kaktree %{
        remove-highlighter buffer/numbers
        remove-highlighter buffer/matching
        remove-highlighter buffer/wrap
        remove-highlighter buffer/show-whitespaces
    }
    kaktree-enable
}


# For this plugin to work, you need working ctags and readtags programs. 
# Note that readtags isn't shipped with exuberant-ctags by default (you can use universal-ctags).
plug "andreyorst/tagbar.kak" config %{
    # if you have wrap highlighter enamled in you configuration
    # files it's better to turn it off for tagbar, using this hook:
    hook global WinSetOption filetype=tagbar %{
        remove-highlighter window/wrap
        # you can also disable rendering whitespaces here, and
    }
}
plug "andreyorst/tagbar.kak" defer "tagbar" %{
    set-option global tagbar_sort false
    set-option global tagbar_size 40
    set-option global tagbar_display_anon false
} config %{
    # if you have wrap highlighter enamled in you configuration
    # files it's better to turn it off for tagbar, using this hook:
    # hook global WinSetOption filetype=tagbar %{
    #     remove-highlighter window/wrap
        # you can also disable rendering whitespaces here, line numbers, and
        # matching characters
    }
}


plug "andreyorst/smarttab.kak"
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
            #         }
hook global WinSetOption filetype=(rust|python|c|cpp) %{
        lsp-enable-window
}

#plug "ualexherbo2/connect.kak"
 ____  ____  ____  ____  __  __ _   ___ 
/ ___)(  __)(_  _)(_  _)(  )(  ( \ / __)
\___ \ ) _)   )(    )(   )( /    /( (_ \
(____/(____) (__)  (__) (__)\_)__) \___/

# addhl global/ column '%val{cursor_column}' default,magenta
addhl global/ line '%val{cursor_line}' default,magenta
############################################# SHORTKEYS ###########################
# To paste
# ! xsel --output --clipboard <ret>
map global user P '!xsel --output --clipboard<ret>' -docstring 'Paste before' # Paste before
map global user p '<a-!>xsel --output --clipboard<ret>' -docstring 'Paste after' # Paste after
map global normal <c-p> ':fzf-mode<ret>' # note that the space after colon is intentional to suppess fzf-mode to show in command history
map global user c :comment-line<ret>' -docstring 'To comment the line'
set-option current comment_block_begin '/*'
set-option current comment_block_end '*/'
map global user a :comment-block<ret>' -docstring 'To comment the block'
map global user g ':cscope ' -docstring 'Find tag with cscope'  # Pour cscope il faut surligner le mot à chercher
map global user ) '<a-i>)<S>,<ret><a-)>' -docstring 'Swap Arguments'
map global normal <F2> ':e ~/.config/kak/kakrc<ret>'
map global user r ':ranger-select<ret>' -docstring 'select files in ranger'
map global normal <F3> '|clang-format<ret>'
alias global g grep # Pour le grep, recuperer le mot copier avec <c-r>"
hook global WinDisplay .* info-buffers
map global user b ':enter-buffers-mode<ret>'              -docstring 'buffers…'
# map global user B ':enter-user-mode -lock buffers<ret>'   -docstring 'buffers (lock)…'
map global user B ':pick-buffers<ret>'   -docstring 'pick-buffers'
alias global bd delete-buffer
alias global bf buffer-first
alias global bl buffer-last
alias global bo buffer-only
alias global bo! buffer-only-force
map global user w ':w<ret>'   -docstring 'Write buffers'
map global user q ':q<ret>'   -docstring 'Quit Kakoune'

map global normal <F8> ':tagbar-toggle<ret>'
# To see what filetypes are supported use `ctags --list-kinds | awk '/^\w+/'
hook global WinSetOption filetype=(cpp|rust) %{
    tagbar-enable
    alias global 'q' 'tagbar-quit'
    alias global 'wq' 'tagbar-write-quit'
}

map global normal <F7> ':bn<ret>'
map global normal <F6> ':bp<ret>'
map global normal <F9> ':kaktree-toggle<ret>'

# show-whitespaces
# :addhl buffer/ show-whitespaces
# :rmhl buffer/show-whitespaces
# <c-d> to select for multi-cursors
map global normal '<c-n>' ': select-or-add-cursor<ret>' -docstring "add cursor on current word, and jump to the next match"
map global insert <tab> '<a-;><gt>'
map global insert <s-tab> '<a-;><lt>'

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
hook global InsertChar j %{ try %{ # jj to escape
      exec -draft hH <a-k>jj<ret> d
        exec <esc>
}}
define-command -override -docstring "select a word under cursor, or add cursor on next occurrence of current selection" \
select-or-add-cursor %{ execute-keys -save-regs '' %sh{
        if [ $(expr $(echo $kak_selection | wc -m) - 1) -eq 1 ]; then
                echo "<a-i>w*"
                    else
                            echo "*<s-n>"
                                fi
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

# set-option global grepcmd 'ag --column'
# set-option global clang_options -std=c++1y
set-option global ui_options ncurses_status_on_top=true
colorscheme gruvbox
add-highlighter global/ show-matching
add-highlighter global/ show-whitespaces
add-highlighter global/ dynregex '%reg{/}' 0:+u
hook global WinCreate ^[^*]+$ %{ add-highlighter window/ number-lines -hlcursor }
set global tabstop 4 
set global indentwidth 4
hook global WinSetOption filetype=c|cpp %{
  set window formatcmd 'clang-format'
#  clang-enable-autocomplete; clang-enable-diagnostics
}
# map global normal = :format<ret> -docstring 'format buffer'

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
hook global ModeChange insert:.* %{
    set-face global PrimaryCursor      rgb:ffffff,rgb:000000+F
}
hook global ModeChange .*:insert %{
    set-face global PrimaryCursor      rgb:ffffff,rgb:008800+F
}
# default black background
# set-face global Default black

# Use ripgrep instead of grep
set-option global grepcmd 'rg -Hn --no-heading'
