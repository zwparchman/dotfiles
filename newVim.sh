#!/bin/bash - 
#download compile and install a new vim

set -o nounset                              # Treat unset variables as an error

if [ ! -d newVim ] ; then
  mkdir newVim
fi
cd newVim

if [ ! -f vim-7.4.tar.bz2 ] ; then
  wget ftp://ftp.vim.org/pub/vim/unix/vim-7.4.tar.bz2 
  tar -xf vim-7.4.tar.bz2
fi

[ -d vim ] || mv vim74 vim

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
