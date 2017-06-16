#!/bin/bash - 
#download compile and install a new vim

set -o nounset                              # Treat unset variables as an error

if [ -z "$PREFIX" ] ; then
    echo "PREFIX required"
fi

[ -d vim ] || git clone https://github.com/vim/vim.git || exit 1

cd vim

./configure --with-features=huge \
  --enable-multibyte \
  --enable-pythoninterp \
  --enable-cscope \
  --prefix=$PREFIX

make -j 10
make install
