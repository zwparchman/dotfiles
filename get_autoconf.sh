#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error

if [ -n "`which autoconf`" ] ; then
    ver=`autoconf --version | head -n 1 | cut -d " " -f 4`
    ver=`python -c "if $ver >= 2.69 : print(1)"`
    if [ -n "$ver" ] ; then
        exit 0
    fi
fi

dir_name="autoconf-2.69"
if [ ! -d  "autoconf-2.69" ] ; then
    base="http://ftp.gnu.org/gnu/autoconf/${dir_name}.tar"
    if [ -n `which gunzip` ] ; then
        wget ${base}.gz
        tar -xf ${dir_name}.tar.gz
    fi
fi

cd $dir_name

if (./configure --prefix=$PREFIX && make && make install) ; then
    exit 0
fi

echo "Autoconf build/install failed"

exit 1
