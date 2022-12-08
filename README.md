# config
## VSC
rtags needs "rc -C" to clear project to be able to load database second time.
## kakoune
kakrc in /.config/kak

plug.kak on dev branch if kakoune build with github !

Start a Kakoune server named s1 and open file main.c:  
`kak -s s1 main.c`   
You can then open another terminal window and connect to that server by running:  
`kak -c s1`  

Connect to existing kakoune session :  
`kak -c <session number>`  

### Vertical block selection
[s-c] and [a+s-C] are the way to go for a similar to block selection functionality
#### All the file
% , [a-s]

### Multiple selection  
simple 
[s+l] to select word to be search
[s-n] to select next word
[p] to paste yanked word
[d] to delete previous

[*] put the word in kakoune buffer("Search current selections (smart)" in dance vscode plugin)  
[/] to search the word (this one of previous line) 
enter
[a-n] to select before  
[s-n] to select after (only n to skip)  
[a-n] to select before  
[a-space] pour ne pas selectionner  
[backspace] remove multiselection

### Parameters swapping  
Select paramaters ([a-i] or [s-w] ...)  
Split slection on charatere "," [S,RET]   
swap [a-)]  

[a-k] Keep matching (in multiple selection)
[a-p] paste several line

### Replace multi-selection with yank selection  
After all multi-selection done
[s-r]

## fzf

## ranger
Open ranger on specific open file  
:ranger [c-r]%

## mc
a-o	source=dest

## fish
Alias in config.fish in ~/.config/fish/

## tmux
https://github.com/AmitXShukla/AmitXShukla.github.io/blob/master/blogs/vim/tmux_cheatsheet.pdf
### config
.tmux.conf in HOME
### copy/paste
`<C+b>[`	normal vi mode  
`Space`		start highlight  
`Enter`		copy highlight  
`<C+b>]`	paste  

To copy from outside of cygwin to kakoune : Put kakoune in insert mode and <S-Ins> to paste  
To copy from kakoune to outside : In kakoune, <C+b>[ , select what you need and do <C-Ins>  
## shortcuts
source configuration file:  
`tmux source-file <path to the tmux.conf file>`  
List command-mode shortcuts:  
`ctrl-b ?`  
list tmux session:  
`tmux ls`  
Start a tmux session:  
`tmux new-session -s <your_session_name>`  
`tmux new -s <your_session_name>`  
To split vertically:  
`ctrl-b %`  
To split horizontally:  
`ctrl-b "`  
To navigate and select a pane:  
`ctrl-b <arrow keys>`  
To toggle full-screen zoom in/out on the current pane:  
`ctrl-b z`  
To close the current pane:  
`ctrl-b x` then confirm with y or n  
Do your work in your tmux session  
Detach from your session when you are done:  
`ctrl-b d`  
`tmux detach`  
[Optional] View available attachable sessions:  
`tmux list-sessions`  
`tmux ls`  
Reattach to your tmux session when you are ready to continue working:  
`tmux attach-session -t <your_session_name>`  
`tmux attach -t <your_session_name>`  
Kill session:  
`tmux kill-session -t mysession`  
### windows
start a new session with the name mysession and window mywindow:  
`tmux new -s mysession -n mywindow`  
Create window:  
`Ctrl + b c`  
Rename current window:  
`Ctrl + b ,`  
Close current window:
`Ctrl + b &`  
Previous window:  
`Ctrl + b p`  
Next window:  
`Ctrl + b n`  
Switch/select window by number:  
`Ctrl + b 0 ... 9`  
Toggle last active window:  
`Ctrl + b l`  
Reorder window, swap window number 2(src) and 1(dst):  
`swap-window -s 2 -t 1`  
Move current window to the left by one position:  
`swap-window -t -1`  
Switch between windows:  
`Ctrl + b w`  


## resurrect
save session:  
`ctrl-b ctrl+s`  
restore session:  
`ctrl-b ctrl+r`  

Enable scroll mode:  
> ctrl-b [  

## clang-format
Put .clang-format in HOME  
Select text with kakoune [X] and [|] and select clang-format  

## cygwin
### terminator
Unix GUI programs display through an X server. Cygwin doesn't automatically start an X server. You need to install the packages xorg-server and xinit, 
and run 
	startxwin     OR click on XWin Server
Launch another cygwin windows : <A-f2>
Launch with
	DISPLAY=:0 terminator &

## tar
compress 	tar zcvf <name>.tar.gz <dossier/>   
uncompress 	tar zxvf <name>.tar.gz  
compress 	tar cvf <name>.tar <dossier/>  
uncompress 	tar xvf <name>.tar  
compress 	tar cfv backup <path/file1> <path/file2>  
uncompress 	tar xf backup  
list of file	tar tvf backup
