# for last version
sudo luarocks install lpeg
sudo apt install liblua5.4-dev/noble
sudo apt install lua-lpeg-dev/noble
sudo apt install clangd/noble  # to test LSP

git clone https://github.com/martanne/vis.git
cd vis
make clean
./configure --enable-lua --enable-lpeg-static && make && sudo make install
vis -v
