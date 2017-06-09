#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error

PRE=$PREFIX

[ -d libevent ] || git clone https://github.com/libevent/libevent.git

cd libevent
./autogen.sh

#./configure 
#./configure --enable-static
./autogen.sh
./configure --prefix=$PRE

make -j20
make install
