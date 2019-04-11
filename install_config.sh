#!/bin/sh

# you need to have ranger fzf tmux plug.kak xsel

# cp ~/.config/fish/config.fish	~/.config/fish/config`date +_%H_%M_%d_%m_20%y`.fish
cp ~/.config/kak/kakrc		~/.config/kak/kakrc`date +_%H_%M_%d_%m_20%y`
cp ~/.tmux.conf			~/`date +_%H_%M_%d_%m_20%y`.tmux.conf
cp ~/.vimrc			~/`date +_%H_%M_%d_%m_20%y`.vimrc
cp ~/.spacemacs			~/`date +_%H_%M_%d_%m_20%y`.spacemacs
cp ~/.config/Code/User/keybindings.json	~/.config/Code/User/keybindings`date +_%d_%m_20%y`.json
cp ~/.config/Code/User/settings.json	~/.config/Code/User/settings`date +_%d_%m_20%y`.json

# cp config.fish 		~/.config/fish/config.fish
cp kakrc 			~/.config/kak/kakrc
cp .tmux.conf 			~/.tmux.conf
cp .vimrc 			~/.vimrc
cp .spacemacs 			~/.spacemacs
cp vsc/keybindings.json 	~/.config/Code/User/keybindings.json
cp vsc/settings.json 		~/.config/Code/User/settings.json
