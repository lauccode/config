#!/bin/sh

# cp ~/.config/fish/config.fish	~/.config/fish/config`date +_%H_%M_%d_%m_20%y`.fish
cp ~/.config/kak/kakrc		~/.config/kak/kakrc`date +_%H_%M_%d_%m_20%y`
cp ~/.tmux.conf			~/`date +_%H_%M_%d_%m_20%y`.tmux.conf
cp ~/.vimrc			~/`date +_%H_%M_%d_%m_20%y`.vimrc
cp ~/.spacemacs			~/`date +_%H_%M_%d_%m_20%y`.spacemacs

# cp config.fish 		~/.config/fish/config.fish
cp kakrc 			~/.config/kak/kakrc
cp .tmux.conf 			~/.tmux.conf
cp .vimrc 			~/.vimrc
cp .spacemacs 			~/.spacemacs
