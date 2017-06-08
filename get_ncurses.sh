#!/bin/bash -

set -o nounset                              # Treat unset variables as an error

PRE=$PREFIX


[ -f ncurses-6.0.tar.gz ] || wget http://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz
[ -d ncurses-6.0 ] || tar -xf ncurses-6.0.tar.gz

cd ncurses-6.0
./autogen.sh

./configure --prefix=$PRE

make -j20
make install
