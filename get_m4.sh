#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error

if [ -z "$PREFIX"]; then
    echo prefix required;
    exit 1;
fi



if [ -n "`which m4`" ] ; then
    ver=`m4 --version | head -n 1 | cut -d " " -f 4`
    ver=`python -c "if \"$ver\" == \"1.4.17\" : print(1)"`
    if [ -n "$ver" ] ; then
        exit 0
    fi
fi

dir_name="m4-1.4.17"
if [ ! -d  "$dir_name" ] ; then
    base="http://ftp.gnu.org/gnu/m4/${dir_name}.tar"
    if [ -n `which gunzip` ] ; then
        wget ${base}.gz
        tar -xf ${dir_name}.tar.gz
    fi
fi

cd $dir_name

if (./configure --prefix=$PREFIX && make && make install) ; then
    exit 0
fi

echo "m4 build/install failed"
echo "Depending on the error it may be fine to run 'make -k install'"

exit 1

