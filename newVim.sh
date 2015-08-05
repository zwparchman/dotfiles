#!/bin/bash - 
#download compile and install a new vim

set -o nounset                              # Treat unset variables as an error

mkdir newVim
cd newVim

hg clone https://code.google.com/p/vim/
cd vim

./configure --with-features=huge \
  --enable-multibyte \
  --enable-rubyinterp \
  --enable-pythoninterp \
  --enable-perlinterp \
  --enable-luainterp \
  --enable-cscope \
  --prefix=$HOME

make
echo "go to" `pwd` "and type make install to finish installing vim to " $HOME
