https://askubuntu.com/questions/796408/installing-and-using-universal-ctags-instead-of-exuberant-ctags

# install autoconf and automake first !!!!!!
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh 
./configure
make
sudo make install
