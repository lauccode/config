# fish as default
# chsh -s `which fish`
# https://stackoverflow.com/questions/2762994/how-to-define-an-alias-in-fish-shell
# Puis lancer terminator directement à la place du terminal
 
source ~/.config/kak/plugins/plug.kak/rc/plug.kak
plug "andreyorst/fzf.kak"
# plug "dryvenn/kakoune-cscope"
plug Delapouite/kakoune-buffers

# https://github.com/mawww/kakoune/wiki/Registers---Clipboard
# with xsel to install first
# To yank (copy)
hook global NormalKey y|d|c %{ nop %sh{
  printf %s "$kak_main_reg_dquote" | xsel --input --clipboard
}}
# To paste
# ! xsel --output --clipboard <ret>
# Paste before
map global user P '!xsel --output --clipboard<ret>' -docstring 'Paste before'
# Paste after
map global user p '<a-!>xsel --output --clipboard<ret>' -docstring 'Paste after' 

############################################# SHORTKEYS ###########################
map global normal <c-p> ':fzf-mode<ret>'
# note that the space after colon is intentional to suppess fzf-mode to show in command history
 
# jj to escape
# Unlike Vim, there is no delay to insert j or the stress to type quickly because of timeout.
hook global InsertChar j %{ try %{
      exec -draft hH <a-k>jj<ret> d
        exec <esc>
}}
# Implementing user mode
# map global user e :echo 'foo<ret>'
map global user c :comment-line<ret>' -docstring 'To comment the line'
map global user b :comment-block<ret>' -docstring 'To comment the block'
# map global user r ':grep'

# Pour cscope il faut surligner le mot à chercher
map global user g ':cscope ' -docstring 'Find tag with cscope' 
map global normal <f2> ':e ~/.config/kak/kakrc<ret>'
map global normal <f9> ':ranger<ret>'

# Pour le grep, recuperer le mot copier avec <c-r>"
alias global g grep
# alias global c cscope

# buffer
# Suggested hook
hook global WinDisplay .* info-buffers
# Suggested mappings
map global user b ':enter-buffers-mode<ret>'              -docstring 'buffers…'
map global user B ':enter-user-mode -lock buffers<ret>'   -docstring 'buffers (lock)…'
# Suggested aliases
alias global bd delete-buffer
alias global bf buffer-first
alias global bl buffer-last
alias global bo buffer-only
alias global bo! buffer-only-force

# show-whitespaces
# :addhl buffer/ show-whitespaces
# :rmhl buffer/show-whitespaces

###################################################################################

# User preference
# ───────────────

set-option global makecmd 'make -j16'
# set-option global grepcmd 'ag --column'
set-option global clang_options -std=c++1y
set-option global ui_options ncurses_status_on_top=true

colorscheme gruvbox

add-highlighter global/ show-matching
add-highlighter global/ dynregex '%reg{/}' 0:+u

hook global WinCreate ^[^*]+$ %{ add-highlighter window/ number-lines -hlcursor }

# Enable editor config
# ────────────────────

# hook global BufOpenFile .* %{ editorconfig-load }
# hook global BufNewFile .* %{ editorconfig-load }

# Filetype specific hooks
# ───────────────────────

# hook global WinSetOption filetype=(c|cpp) %{
#     clang-enable-autocomplete 
#     clang-enable-diagnostics
#     alias window lint clang-parse
#     alias window lint-next-error clang-diagnostics-next
# }

# hook global WinSetOption filetype=python %{
#     jedi-enable-autocomplete
#     lint-enable
#     set-option global lintcmd 'flake8'
# }

# map -docstring "xml tag objet" global object t %{c<lt>([\w.]+)\b[^>]*?(?<lt>!/)>,<lt>/([\w.]+)\b[^>]*?(?<lt>!/)><ret>}

# Highlight the word under the cursor
# ───────────────────────────────────

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

# Custom mappings
# ───────────────

# map global normal = ':prompt math: %{exec "a%val{text}<lt>esc>|bc<lt>ret>"}<ret>'

# System clipboard handling
# ─────────────────────────

# evaluate-commands %sh{
#     case $(uname) in
#         Linux) copy="xclip -i"; paste="xclip -o" ;;
#         Darwin)  copy="pbcopy"; paste="pbpaste" ;;
#     esac

#     printf "map global user -docstring 'paste (after) from clipboard' p '!%s<ret>'\n" "$paste"
#     printf "map global user -docstring 'paste (before) from clipboard' P '<a-!>%s<ret>'\n" "$paste"
#     printf "map global user -docstring 'yank to clipboard' y '<a-|>%s<ret>:echo -markup %%{{Information}copied selection to X11 clipboard}<ret>'\n" "$copy"
#     printf "map global user -docstring 'replace from clipboard' R '|%s<ret>'\n" "$paste"
# }

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

define-command ide %{
    rename-client main
    set-option global jumpclient main

    new rename-client tools
    set-option global toolsclient tools

    new rename-client docs
    set-option global docsclient docs
}

# define-command delete-buffers-matching -params 1 %{
#     evaluate-commands -buffer * %{
#         evaluate-commands %sh{ case "$kak_buffile" in $1) echo "delete-buffer" ;; esac }
#     }
# }

# Load local Kakoune config file if it exists
# ───────────────────────────────────────────

evaluate-commands %sh{ [ -f $kak_config/local.kak ] && echo "source $kak_config/local.kak" }

# <c-d> to select for multi-cursors
define-command -override -docstring "select a word under cursor, or add cursor on next occurrence of current selection" \
select-or-add-cursor %{ execute-keys -save-regs '' %sh{
        if [ $(expr $(echo $kak_selection | wc -m) - 1) -eq 1 ]; then
                echo "<a-i>w*"
                    else
                            echo "*<s-n>"
                                fi
}}
map global normal '<c-d>' ': select-or-add-cursor<ret>' -docstring "add cursor on current word, and jump to the next match"

# tab
map global insert <tab> '<a-;><gt>'
map global insert <s-tab> '<a-;><lt>'
