# for last version
sudo luarocks install lpeg
sudo apt install liblua5.4-dev
sudo apt install lua-lpeg-dev
sudo apt install clangd  # to test LSP

git clone https://github.com/martanne/vis.git
cd vis
make clean
./configure --enable-lua --enable-lpeg-static && make && sudo make install
vis -v
