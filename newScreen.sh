#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error

[ -f screen-4.3.1.tar.gz ] || wget https://ftp.gnu.org/gnu/screen/screen-4.3.1.tar.gz
[ -d screen-4.3.1 ] || tar -xf screen-4.3.1.tar.gz

cd screen-4.3.1 && \
./configure --prefix=$HOME && \
make && \
make install 


