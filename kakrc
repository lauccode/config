# fish as default
# chsh -s `which fish`
# https://stackoverflow.com/questions/2762994/how-to-define-an-alias-in-fish-shell
#  PLUGIN
#  ───────────────
source ~/.config/kak/plugins/plug.kak/rc/plug.kak
plug "andreyorst/fzf.kak"
plug "dryvenn/kakoune-cscope"
plug Delapouite/kakoune-buffers
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
map global normal <f2> ':e ~/.config/kak/kakrc<ret>'
map global normal <f9> ':ranger<ret>'
map global normal <f3> '|clang-format<ret>'
alias global g grep # Pour le grep, recuperer le mot copier avec <c-r>"
hook global WinDisplay .* info-buffers
map global user b ':enter-buffers-mode<ret>'              -docstring 'buffers…'
map global user B ':enter-user-mode -lock buffers<ret>'   -docstring 'buffers (lock)…'
alias global bd delete-buffer
alias global bf buffer-first
alias global bl buffer-last
alias global bo buffer-only
alias global bo! buffer-only-force
# show-whitespaces
# :addhl buffer/ show-whitespaces
# :rmhl buffer/show-whitespaces
# <c-d> to select for multi-cursors
map global normal '<c-d>' ': select-or-add-cursor<ret>' -docstring "add cursor on current word, and jump to the next match"
map global insert <tab> '<a-;><gt>'
map global insert <s-tab> '<a-;><lt>'
map global user / :tmux-new-horizontal<ret>' -docstring 'Split horizontal'
map global user = :tmux-new-vertical<ret>' -docstring 'Split vertical'
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
hook global WinSetOption filetype=c %{
  set window formatcmd 'clang-format'
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
