#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error

if [ ! -d tmux ] ; then
    git clone git@github.com:tmux/tmux.git
fi

cd tmux
./autogen

#./configure 
./configure --enable-static

make -j20
