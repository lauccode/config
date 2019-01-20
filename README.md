# config
## kakoune
kakrc in /.config/kak

selection multiple
* pour mettre le mot dans le buffer
/ pour rechercher le mot (le mot precedent est copié en auto)
enter
a-n pour reprendre le premier 
s-n pour selectionner les suivants (seulement n pour skipper)
a-n pour revenir en arriere
a-space pour ne pas selectionner 

Vertical block selection
<s-c> and <a+s-C> are the way to go for a similar to block selection functionality

## fzf

## ranger

## mc
a-o	source=dest

## fish
Alias in config.fish in ~/.config/fish/

## tmux
### config
.tmux.conf in HOME
### copy/paste
To copy from outside of cygwin to kakoune : Put kakoune in insert mode and <S-Ins> to paste
To copy from kakoune to outside : In kakoune, <C+b>[ , select what you need and do <C-Ins>
## shortcuts
tmux new-session -s <your_session_name> 
tmux ls 
List command-mode shortcuts: ctrl-b ?
    Start a tmux session:
    tmux new-session -s <your_session_name>
    To split vertically: 
    ctrl-b %
    To split horizontally: 
    ctrl-b "
    To navigate and select a pane: 
    ctrl-b <arrow keys>
    To toggle full-screen zoom in/out on the current pane:
    ctrl-b z
    To close the current pane:
    ctrl-b x then confirm with y or n

    Start with a named session:
    tmux new-session -s <your_session_name>
    Do your work in your tmux session
    Detach from your session when you are done:
    tmux detach
    [Optional] View available attachable sessions:
    tmux list-sessions or tmux ls
    Reattach to your tmux session when you are ready to continue working:
    tmux attach -t <your_session_name>

Enable scroll mode: ctrl-b [

## cygwin
### terminator
Unix GUI programs display through an X server. Cygwin doesn't automatically start an X server. You need to install the packages xorg-server and xinit, 
and run 
	startxwin     OR click on XWin Server
Launch another cygwin windows : <A-f2>
Launch with
	DISPLAY=:0 terminator &
