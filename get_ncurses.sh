#!/bin/bash -

set -o nounset                              # Treat unset variables as an error

PRE=$PREFIX


thing=ncurses-6.0
[ -f $thing}.tar.gz ] || wget http://ftp.gnu.org/gnu/ncurses/${thing}.tar.gz
[ -d ${thing} ] || tar -xf ${thing}.tar.gz

export CPPFLAGS="-P"

cd ${thing}
./autogen.sh

./configure --prefix=$PRE

make -j20
make install
