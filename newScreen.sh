#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error

wget https://ftp.gnu.org/gnu/screen/screen-4.3.1.tar.gz && \
tar -xf screen-4.3.1.tar.gz  && \
cd screen/src && \
./autogen && \
./configure --prefix=$HOME && \
make && \
make install 


