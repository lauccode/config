# fish as default
# chsh -s `which fish`
# https://stackoverflow.com/questions/2762994/how-to-define-an-alias-in-fish-shell
#  PLUGIN
#  ───────────────
# fish as default
# chsh -s `which fish`
# https://stackoverflow.com/questions/2762994/how-to-define-an-alias-in-fish-shell
#  PLUGIN
#  ───────────────
map global normal <space> , -docstring 'leader'
map global normal <backspace> <space> -docstring 'remove all sels except main'
map global normal <a-backspace> <a-space> -docstring 'remove main sel'

source ~/.config/kak/plugins/plug.kak/rc/plug.kak
plug "andreyorst/fzf.kak"
plug "dryvenn/kakoune-cscope"
# fish as default
# chsh -s `which fish`
# https://stackoverflow.com/questions/2762994/how-to-define-an-alias-in-fish-shell
#  PLUGIN
#  ───────────────
map global normal <space> , -docstring 'leader'
map global normal <backspace> <space> -docstring 'remove all sels except main'
map global normal <a-backspace> <a-space> -docstring 'remove main sel'

source ~/.config/kak/plugins/plug.kak/rc/plug.kak
plug "andreyorst/fzf.kak"
plug "dryvenn/kakoune-cscope"
plug Delapouite/kakoune-buffers
# plug "andreyorst/tagbar.kak" config %{
#     # if you have wrap highlighter enamled in you configuration
#     # files it's better to turn it off for tagbar, using this hook:
#     hook global WinSetOption filetype=tagbar %{
#         remove-highlighter window/wrap
#         # you can also disable rendering whitespaces here, and
#     }
# }
# plug "andreyorst/tagbar.kak" defer "tagbar" %{
#     set-option global tagbar_sort false
#     set-option global tagbar_size 40
#     set-option global tagbar_display_anon false
# } config %{
#     # if you have wrap highlighter enamled in you configuration
#     # files it's better to turn it off for tagbar, using this hook:
#     # hook global WinSetOption filetype=tagbar %{
#     #     remove-highlighter window/wrap
#         # you can also disable rendering whitespaces here, line numbers, and
#         # matching characters
#     }
# }
plug "andreyorst/smarttab.kak"
plug "Crote/kakoune-ranger.git"
plug "andreyorst/powerline.kak" %{
    hook -once global WinCreate .* %{
        powerline-theme gruvbox
        powerline-separator triangle-inverted
        powerline-format git bufname filetype client session line_column position
        # powerline-toggle line_column off
    }
}
plug "ul/kak-lsp" do %{
        cargo build --release --locked
        cargo install --force --path .
} config %{
# andreyorst default config
        define-command lsp-restart %{ lsp-stop; lsp-start }
        set-option global lsp_completion_trigger "execute-keys 'h<a-h><a-k>\S[^\h\n,=;*(){}\[\]]\z<ret>'"
        set-option global lsp_diagnostic_line_error_sign "!"
        set-option global lsp_diagnostic_line_warning_sign "?"
        hook global WinSetOption filetype=(c|cpp|rust) %{
              map window user "l" ": enter-user-mode lsp<ret>" -docstring "LSP mode"
              lsp-enable-window
              lsp-auto-hover-enable
              lsp-auto-hover-insert-mode-disable
              set-option window lsp_hover_anchor true
              set-face window DiagnosticError default+u
              set-face window DiagnosticWarning default+u
      }
      hook global WinSetOption filetype=rust %{
              set-option window lsp_server_configuration rust.clippy_preference="on"
      }
      hook global KakEnd .* lsp-exit
}
#plug "ualexherbo2/connect.kak"
#define-command ranger -params .. -file-completion %(connect ranger %arg(@))

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
map global normal <F9> ':ranger-select<ret>'
map global normal <F3> '|clang-format<ret>'
alias global g grep # Pour le grep, recuperer le mot copier avec <c-r>"
hook global WinDisplay .* info-buffers
map global user b ':enter-buffrs-mode<ret>'              -docstring 'buffers…'
# map global user B ':enter-user-mode -lock buffers<ret>'   -docstring 'buffers (lock)…'
map global user B ':pick-buffers<ret>'   -docstring 'pick-buffers'
alias global bd delete-buffer
alias global bf buffer-first
alias global bl buffer-last
alias global bo buffer-only
alias global bo! buffer-only-force
map global user w ':w<ret>'   -docstring 'Write buffers'
map global user q ':q<ret>'   -docstring 'Quit Kakoune'
# alias global 'q' 'tagbar-quit'
# alias global 'wq' 'tagbar-write-quit'
map global normal <F8> ':tagbar-toggle<ret>'
# To see what filetypes are supported use `ctags --list-kinds | awk '/^\w+/'
hook global WinSetOption filetype=(cpp|rust) %{
    tagbar-enable
}
map global normal <F7> ':bn<ret>'
map global normal <F6> ':bp<ret>'
# show-whitespaces
# :addhl buffer/ show-whitespaces
# :rmhl buffer/show-whitespaces
# <c-d> to select for multi-cursors
map global normal '<c-n>' ': select-or-add-cursor<ret>' -docstring "add cursor on current word, and jump to the next match"
map global insert <tab> '<a-;><gt>'
map global insert <s-tab> '<a-;><lt>'
map global user / :tmux-new-horizontal<ret>' -docstring 'Split horizontal'
map global user = :tmux-new-vertical<ret>' -docstring 'Split vertical'
# map global user / ':tmux-terminal-horizontal kak -c %val{session}<ret>' -docstring 'Split horizontal'
# map global user = ':tmux-terminal-vertical kak -c %val{session}<ret>' -docstring 'Split vertical'
# Remove delete or change selection in yank buffer 
map global normal c \"_c
map global normal d \"_d
# search case insensitive
# map -docstring 'case insensitive search' global user '/' /(?i)
# map -docstring 'case insensitive backward search' global user '<a-/>' <a-/>(?i)
# map -docstring 'case insensitive extend search' global user '?' ?(?i)
# map -docstring 'case insensitive backward extend-search' global user '<a-?>' <a-?>(?i)
map -docstring 'case insensitive search' global normal / '/(?i)'
map -docstring 'case insensitive backward search' global normal <a-/> '<a-/>(?i)'
map -docstring 'case insensitive extend search' global normal ? '?(?i)'
map -docstring 'case insensitive backward extend-search' global normal <a-?> '<a-?>(?i)'
# Various mappings
# ────────────────
# map global normal '#' :comment-line<ret>
# map global user -docstring 'next lint error' n ':lint-next-error<ret>'
# map global normal <c-p> :lint<ret>
# map global user -docstring 'gdb helper mode' g ':gdb-helper<ret>'
# map global user -docstring 'gdb helper mode (repeat)' G ':gdb-helper-repeat<ret>'
# hook global BufOpenFifo '\*grep\*' %{ map -- global normal - ':grep-next-match<ret>' }
# hook global BufOpenFifo '\*make\*' %{ map -- global normal - ':make-next-error<ret>' }
# Enable <tab>/<s-tab> for insert completion selection
# ──────────────────────────────────────────────────────
# hook global InsertCompletionShow .* %{ map window insert <tab> <c-n>; map window insert <s-tab> <c-p> }
# hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <s-tab> <c-p> }
# Helper commands
# ───────────────
# define-command find -params 1 -shell-candidates %{ ag -g '' --ignore "$kak_opt_ignored_files" } %{ edit %arg{1} }
# define-command mkdir %{ nop %sh{ mkdir -p $(dirname $kak_buffile) } }
# Enable editor config
# ────────────────────
# hook global BufOpenFile .* %{ editorconfig-load }
# hook global BufNewFile .* %{ editorconfig-load }
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
###################################################################################
# User preference
set-option global makecmd 'make -j16'
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

# automatic correction (TBT)
# :lint => clang-enable-diagnostics ?
# https://github.com/mawww/kakoune/wiki
# check lint and clang external tools
# clang only for cpp

# KEEP RANGER
# http://ranger.nongnu.org
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
# define-command ranger-open-on-edit-directory \
#     -docstring 'Start the ranger file system explorer when trying to edit a directory' %{
#         hook global RuntimeError "\d+:\d+: '\w+' (.*): is a directory" %{ evaluate-commands %sh{
#             directory=$kak_hook_param_capture_1
#             echo ranger $directory
#     }}
# }
# define-command \
#     -params .. -file-completion \
#     -docstring %{ranger [<arguments>]: open the file system explorer to select buffers to open
#     All the optional arguments are forwarded to the ranger utility} \
#     ranger %{ evaluate-commands %sh{
#     if [ -n "${TMUX}" ]; then
#         tmux split-window -h \
#             ranger $@ --cmd " \
#                 map <return> eval \
#                     fm.execute_console('shell \
#                         echo evaluate-commands -client ' + ranger.ext.shell_escape.shell_escape('$kak_client') + ' edit {file} | \
#                         kak -p '.format(file=fm.thisfile.path) + ranger.ext.shell_escape.shell_escape('$kak_session') + '; \
#                         tmux select-pane -t $kak_client_env_TMUX_PANE') \
#                     if fm.thisfile.is_file else fm.execute_console('move right=1')"
#     elif [ -n "${STY}" ]; then
#         script="/tmp/kak-ranger-${kak_client}-${kak_session}.sh"
#         selections="/tmp/kak-ranger-${kak_client}-${kak_session}.txt"
#         cat > "$script" << EOF
# #! /usr/bin/env sh
# cd "$PWD"
# ranger --choosefiles="$selections" $@
# while read -r f; do
#     printf %s  "evaluate-commands -client '${kak_client}' edit '\"\$f\"'" | kak -p '${kak_session}'
# done < "$selections"
# screen -X remove
# rm -f "$selections" "$script"
# EOF
#         tty="$(ps -o tty ${kak_client_pid} | tail -n 1)"
#         screen -X eval \
#             'split -h' \
#             'focus down' \
#             "screen sh '$script'" \
#         < "/dev/$tty"

#     elif [ -n "$WINDOWID" ]; then
#         setsid $kak_opt_termcmd " \
#             ranger $@ --cmd "'"'" \
#                 map <return> eval \
#                     fm.execute_console('shell \
#                         echo evaluate-commands -client ' + ranger.ext.shell_escape.shell_escape('$kak_client') + ' edit {file} | \
#                         kak -p '.format(file=fm.thisfile.path) + ranger.ext.shell_escape.shell_escape('$kak_session') + '; \
#                         xdotool windowactivate $kak_client_env_WINDOWID') \
#                     if fm.thisfile.is_file else fm.execute_console('move right=1')"'"' < /dev/null > /dev/null 2>&1 &
#     fi
# }}
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
plug Delapouite/kakoune-buffers
# plug "andreyorst/tagbar.kak" config %{
#     # if you have wrap highlighter enamled in you configuration
#     # files it's better to turn it off for tagbar, using this hook:
#     hook global WinSetOption filetype=tagbar %{
#         remove-highlighter window/wrap
#         # you can also disable rendering whitespaces here, and
#     }
# }
# plug "andreyorst/tagbar.kak" defer "tagbar" %{
#     set-option global tagbar_sort false
#     set-option global tagbar_size 40
#     set-option global tagbar_display_anon false
# } config %{
#     # if you have wrap highlighter enamled in you configuration
#     # files it's better to turn it off for tagbar, using this hook:
#     # hook global WinSetOption filetype=tagbar %{
#     #     remove-highlighter window/wrap
#         # you can also disable rendering whitespaces here, line numbers, and
#         # matching characters
#     }
# }
plug "andreyorst/smarttab.kak"
plug "andreyorst/powerline.kak" %{
    hook -once global WinCreate .* %{
        powerline-theme gruvbox
        powerline-separator triangle-inverted
        powerline-format git bufname filetype client session line_column position
        # powerline-toggle line_column off
    }
}
plug "ul/kak-lsp" do %{
        cargo build --release --locked
        cargo install --force --path .
} config %{
# andreyorst default config
        define-command lsp-restart %{ lsp-stop; lsp-start }
        set-option global lsp_completion_trigger "execute-keys 'h<a-h><a-k>\S[^\h\n,=;*(){}\[\]]\z<ret>'"
        set-option global lsp_diagnostic_line_error_sign "!"
        set-option global lsp_diagnostic_line_warning_sign "?"
        hook global WinSetOption filetype=(c|cpp|rust) %{
              map window user "l" ": enter-user-mode lsp<ret>" -docstring "LSP mode"
              lsp-enable-window
              lsp-auto-hover-enable
              lsp-auto-hover-insert-mode-disable
              set-option window lsp_hover_anchor true
              set-face window DiagnosticError default+u
              set-face window DiagnosticWarning default+u
      }
      hook global WinSetOption filetype=rust %{
              set-option window lsp_server_configuration rust.clippy_preference="on"
      }
      hook global KakEnd .* lsp-exit
}
#plug "ualexherbo2/connect.kak"
#define-command ranger -params .. -file-completion %(connect ranger %arg(@))

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
map global normal <F9> ':ranger<ret>'
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
# alias global 'q' 'tagbar-quit'
# alias global 'wq' 'tagbar-write-quit'
map global normal <F8> ':tagbar-toggle<ret>'
# To see what filetypes are supported use `ctags --list-kinds | awk '/^\w+/'
hook global WinSetOption filetype=(cpp|rust) %{
    tagbar-enable
}
map global normal <F7> ':bn<ret>'
map global normal <F6> ':bp<ret>'
# show-whitespaces
# :addhl buffer/ show-whitespaces
# :rmhl buffer/show-whitespaces
# <c-d> to select for multi-cursors
map global normal '<c-n>' ': select-or-add-cursor<ret>' -docstring "add cursor on current word, and jump to the next match"
map global insert <tab> '<a-;><gt>'
map global insert <s-tab> '<a-;><lt>'
map global user / :tmux-new-horizontal<ret>' -docstring 'Split horizontal'
map global user = :tmux-new-vertical<ret>' -docstring 'Split vertical'
# map global user / ':tmux-terminal-horizontal kak -c %val{session}<ret>' -docstring 'Split horizontal'
# map global user = ':tmux-terminal-vertical kak -c %val{session}<ret>' -docstring 'Split vertical'
# Remove delete or change selection in yank buffer 
map global normal c \"_c
map global normal d \"_d
# search case insensitive
# map -docstring 'case insensitive search' global user '/' /(?i)
# map -docstring 'case insensitive backward search' global user '<a-/>' <a-/>(?i)
# map -docstring 'case insensitive extend search' global user '?' ?(?i)
# map -docstring 'case insensitive backward extend-search' global user '<a-?>' <a-?>(?i)
map -docstring 'case insensitive search' global normal / '/(?i)'
map -docstring 'case insensitive backward search' global normal <a-/> '<a-/>(?i)'
map -docstring 'case insensitive extend search' global normal ? '?(?i)'
map -docstring 'case insensitive backward extend-search' global normal <a-?> '<a-?>(?i)'
# Various mappings
# ────────────────
# map global normal '#' :comment-line<ret>
# map global user -docstring 'next lint error' n ':lint-next-error<ret>'
# map global normal <c-p> :lint<ret>
# map global user -docstring 'gdb helper mode' g ':gdb-helper<ret>'
# map global user -docstring 'gdb helper mode (repeat)' G ':gdb-helper-repeat<ret>'
# hook global BufOpenFifo '\*grep\*' %{ map -- global normal - ':grep-next-match<ret>' }
# hook global BufOpenFifo '\*make\*' %{ map -- global normal - ':make-next-error<ret>' }
# Enable <tab>/<s-tab> for insert completion selection
# ──────────────────────────────────────────────────────
# hook global InsertCompletionShow .* %{ map window insert <tab> <c-n>; map window insert <s-tab> <c-p> }
# hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <s-tab> <c-p> }
# Helper commands
# ───────────────
# define-command find -params 1 -shell-candidates %{ ag -g '' --ignore "$kak_opt_ignored_files" } %{ edit %arg{1} }
# define-command mkdir %{ nop %sh{ mkdir -p $(dirname $kak_buffile) } }
# Enable editor config
# ────────────────────
# hook global BufOpenFile .* %{ editorconfig-load }
# hook global BufNewFile .* %{ editorconfig-load }
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
###################################################################################
# User preference
set-option global makecmd 'make -j16'
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

# automatic correction (TBT)
# :lint => clang-enable-diagnostics ?
# https://github.com/mawww/kakoune/wiki
# check lint and clang external tools
# clang only for cpp

# KEEP RANGER
# http://ranger.nongnu.org
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
# define-command ranger-open-on-edit-directory \
#     -docstring 'Start the ranger file system explorer when trying to edit a directory' %{
#         hook global RuntimeError "\d+:\d+: '\w+' (.*): is a directory" %{ evaluate-commands %sh{
#             directory=$kak_hook_param_capture_1
#             echo ranger $directory
#     }}
# }
# define-command \
#     -params .. -file-completion \
#     -docstring %{ranger [<arguments>]: open the file system explorer to select buffers to open
#     All the optional arguments are forwarded to the ranger utility} \
#     ranger %{ evaluate-commands %sh{
#     if [ -n "${TMUX}" ]; then
#         tmux split-window -h \
#             ranger $@ --cmd " \
#                 map <return> eval \
#                     fm.execute_console('shell \
#                         echo evaluate-commands -client ' + ranger.ext.shell_escape.shell_escape('$kak_client') + ' edit {file} | \
#                         kak -p '.format(file=fm.thisfile.path) + ranger.ext.shell_escape.shell_escape('$kak_session') + '; \
#                         tmux select-pane -t $kak_client_env_TMUX_PANE') \
#                     if fm.thisfile.is_file else fm.execute_console('move right=1')"
#     elif [ -n "${STY}" ]; then
#         script="/tmp/kak-ranger-${kak_client}-${kak_session}.sh"
#         selections="/tmp/kak-ranger-${kak_client}-${kak_session}.txt"
#         cat > "$script" << EOF
# #! /usr/bin/env sh
# cd "$PWD"
# ranger --choosefiles="$selections" $@
# while read -r f; do
#     printf %s  "evaluate-commands -client '${kak_client}' edit '\"\$f\"'" | kak -p '${kak_session}'
# done < "$selections"
# screen -X remove
# rm -f "$selections" "$script"
# EOF
#         tty="$(ps -o tty ${kak_client_pid} | tail -n 1)"
#         screen -X eval \
#             'split -h' \
#             'focus down' \
#             "screen sh '$script'" \
#         < "/dev/$tty"

#     elif [ -n "$WINDOWID" ]; then
#         setsid $kak_opt_termcmd " \
#             ranger $@ --cmd "'"'" \
#                 map <return> eval \
#                     fm.execute_console('shell \
#                         echo evaluate-commands -client ' + ranger.ext.shell_escape.shell_escape('$kak_client') + ' edit {file} | \
#                         kak -p '.format(file=fm.thisfile.path) + ranger.ext.shell_escape.shell_escape('$kak_session') + '; \
#                         xdotool windowactivate $kak_client_env_WINDOWID') \
#                     if fm.thisfile.is_file else fm.execute_console('move right=1')"'"' < /dev/null > /dev/null 2>&1 &
#     fi
# }}
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
map global normal <space> , -docstring 'leader'
map global normal <backspace> <space> -docstring 'remove all sels except main'
map global normal <a-backspace> <a-space> -docstring 'remove main sel'

source ~/.config/kak/plugins/plug.kak/rc/plug.kak
plug "andreyorst/fzf.kak"
plug "dryvenn/kakoune-cscope"
plug Delapouite/kakoune-buffers
# plug "andreyorst/tagbar.kak" config %{
#     # if you have wrap highlighter enamled in you configuration
#     # files it's better to turn it off for tagbar, using this hook:
#     hook global WinSetOption filetype=tagbar %{
#         remove-highlighter window/wrap
#         # you can also disable rendering whitespaces here, and
#     }
# }
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
plug "andreyorst/powerline.kak" %{
    hook -once global WinCreate .* %{
        powerline-theme gruvbox
        powerline-separator triangle-inverted
        powerline-format git bufname filetype client session line_column position
        # powerline-toggle line_column off
    }
}
plug "ul/kak-lsp" do %{
        cargo build --release --locked
        cargo install --force --path .
} config %{
# andreyorst default config
        define-command lsp-restart %{ lsp-stop; lsp-start }
        set-option global lsp_completion_trigger "execute-keys 'h<a-h><a-k>\S[^\h\n,=;*(){}\[\]]\z<ret>'"
        set-option global lsp_diagnostic_line_error_sign "!"
        set-option global lsp_diagnostic_line_warning_sign "?"
        hook global WinSetOption filetype=(c|cpp|rust) %{
              map window user "l" ": enter-user-mode lsp<ret>" -docstring "LSP mode"
              lsp-enable-window
              lsp-auto-hover-enable
              lsp-auto-hover-insert-mode-disable
              set-option window lsp_hover_anchor true
              set-face window DiagnosticError default+u
              set-face window DiagnosticWarning default+u
      }
      hook global WinSetOption filetype=rust %{
              set-option window lsp_server_configuration rust.clippy_preference="on"
      }
      hook global KakEnd .* lsp-exit
}
#plug "ualexherbo2/connect.kak"
#define-command ranger -params .. -file-completion %(connect ranger %arg(@))

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
map global normal <f2> ':e ~/.config/kak/kakrc<ret>'
map global normal <f9> ':ranger<ret>'
map global normal <f3> '|clang-format<ret>'
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
# alias global 'q' 'tagbar-quit'
# alias global 'wq' 'tagbar-write-quit'
map global normal <f8> ':tagbar-toggle<ret>'
# To see what filetypes are supported use `ctags --list-kinds | awk '/^\w+/'
hook global WinSetOption filetype=(cpp|rust) %{
    tagbar-enable
}
map global normal <f7> ':bn<ret>'
map global normal <f6> ':bp<ret>'
# show-whitespaces
# :addhl buffer/ show-whitespaces
# :rmhl buffer/show-whitespaces
# <c-d> to select for multi-cursors
map global normal '<c-n>' ': select-or-add-cursor<ret>' -docstring "add cursor on current word, and jump to the next match"
map global insert <tab> '<a-;><gt>'
map global insert <s-tab> '<a-;><lt>'
map global user / :tmux-new-horizontal<ret>' -docstring 'Split horizontal'
map global user = :tmux-new-vertical<ret>' -docstring 'Split vertical'
# map global user / ':tmux-terminal-horizontal kak -c %val{session}<ret>' -docstring 'Split horizontal'
# map global user = ':tmux-terminal-vertical kak -c %val{session}<ret>' -docstring 'Split vertical'
# Remove delete or change selection in yank buffer 
map global normal c \"_c
map global normal d \"_d
# search case insensitive
# map -docstring 'case insensitive search' global user '/' /(?i)
# map -docstring 'case insensitive backward search' global user '<a-/>' <a-/>(?i)
# map -docstring 'case insensitive extend search' global user '?' ?(?i)
# map -docstring 'case insensitive backward extend-search' global user '<a-?>' <a-?>(?i)
map -docstring 'case insensitive search' global normal / '/(?i)'
map -docstring 'case insensitive backward search' global normal <a-/> '<a-/>(?i)'
map -docstring 'case insensitive extend search' global normal ? '?(?i)'
map -docstring 'case insensitive backward extend-search' global normal <a-?> '<a-?>(?i)'
# Various mappings
# ────────────────
# map global normal '#' :comment-line<ret>
# map global user -docstring 'next lint error' n ':lint-next-error<ret>'
# map global normal <c-p> :lint<ret>
# map global user -docstring 'gdb helper mode' g ':gdb-helper<ret>'
# map global user -docstring 'gdb helper mode (repeat)' G ':gdb-helper-repeat<ret>'
# hook global BufOpenFifo '\*grep\*' %{ map -- global normal - ':grep-next-match<ret>' }
# hook global BufOpenFifo '\*make\*' %{ map -- global normal - ':make-next-error<ret>' }
# Enable <tab>/<s-tab> for insert completion selection
# ──────────────────────────────────────────────────────
# hook global InsertCompletionShow .* %{ map window insert <tab> <c-n>; map window insert <s-tab> <c-p> }
# hook global InsertCompletionHide .* %{ unmap window insert <tab> <c-n>; unmap window insert <s-tab> <c-p> }
# Helper commands
# ───────────────
# define-command find -params 1 -shell-candidates %{ ag -g '' --ignore "$kak_opt_ignored_files" } %{ edit %arg{1} }
# define-command mkdir %{ nop %sh{ mkdir -p $(dirname $kak_buffile) } }
# Enable editor config
# ────────────────────
# hook global BufOpenFile .* %{ editorconfig-load }
# hook global BufNewFile .* %{ editorconfig-load }
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
###################################################################################
# User preference
set-option global makecmd 'make -j16'
# set-option global grepcmd 'ag --column'
set-option global clang_options -std=c++1y
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

# automatic correction (TBT)
# :lint => clang-enable-diagnostics ?
# https://github.com/mawww/kakoune/wiki
# check lint and clang external tools
# clang only for cpp

# KEEP RANGER
# http://ranger.nongnu.org
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
# define-command ranger-open-on-edit-directory \
#     -docstring 'Start the ranger file system explorer when trying to edit a directory' %{
#         hook global RuntimeError "\d+:\d+: '\w+' (.*): is a directory" %{ evaluate-commands %sh{
#             directory=$kak_hook_param_capture_1
#             echo ranger $directory
#     }}
# }
# define-command \
#     -params .. -file-completion \
#     -docstring %{ranger [<arguments>]: open the file system explorer to select buffers to open
#     All the optional arguments are forwarded to the ranger utility} \
#     ranger %{ evaluate-commands %sh{
#     if [ -n "${TMUX}" ]; then
#         tmux split-window -h \
#             ranger $@ --cmd " \
#                 map <return> eval \
#                     fm.execute_console('shell \
#                         echo evaluate-commands -client ' + ranger.ext.shell_escape.shell_escape('$kak_client') + ' edit {file} | \
#                         kak -p '.format(file=fm.thisfile.path) + ranger.ext.shell_escape.shell_escape('$kak_session') + '; \
#                         tmux select-pane -t $kak_client_env_TMUX_PANE') \
#                     if fm.thisfile.is_file else fm.execute_console('move right=1')"
#     elif [ -n "${STY}" ]; then
#         script="/tmp/kak-ranger-${kak_client}-${kak_session}.sh"
#         selections="/tmp/kak-ranger-${kak_client}-${kak_session}.txt"
#         cat > "$script" << EOF
# #! /usr/bin/env sh
# cd "$PWD"
# ranger --choosefiles="$selections" $@
# while read -r f; do
#     printf %s  "evaluate-commands -client '${kak_client}' edit '\"\$f\"'" | kak -p '${kak_session}'
# done < "$selections"
# screen -X remove
# rm -f "$selections" "$script"
# EOF
#         tty="$(ps -o tty ${kak_client_pid} | tail -n 1)"
#         screen -X eval \
#             'split -h' \
#             'focus down' \
#             "screen sh '$script'" \
#         < "/dev/$tty"

#     elif [ -n "$WINDOWID" ]; then
#         setsid $kak_opt_termcmd " \
#             ranger $@ --cmd "'"'" \
#                 map <return> eval \
#                     fm.execute_console('shell \
#                         echo evaluate-commands -client ' + ranger.ext.shell_escape.shell_escape('$kak_client') + ' edit {file} | \
#                         kak -p '.format(file=fm.thisfile.path) + ranger.ext.shell_escape.shell_escape('$kak_session') + '; \
#                         xdotool windowactivate $kak_client_env_WINDOWID') \
#                     if fm.thisfile.is_file else fm.execute_console('move right=1')"'"' < /dev/null > /dev/null 2>&1 &
#     fi
# }}
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
