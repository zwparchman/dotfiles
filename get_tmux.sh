#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error

PRE=$PREFIX

[ -d tmux ] || git clone ssh://git@github.com/tmux/tmux.git

cd tmux
./autogen.sh

#./configure 
#./configure --enable-static
./configure --prefix=$PRE

make -j20
make install
