#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error

git clone git://git.savannah.gnu.org/screen.git && \
cd screen/src && \
./autogen && \
./configure --prefix=$HOME && \
make && \
make install 


