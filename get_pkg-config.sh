
#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error
set -e # fail on first non 0 exit status

if [ -z "$PREFIX"]; then
    echo prefix required;
    exit 1;
fi

program=pkg-config
goal_version=0.29.1
dir_name="$program-${goal_version}"
base="http://pkgconfig.freedesktop.org/releases/${dir_name}.tar"

#######################################33
#check if we need it
if [ -n "`which ${program}`" ] ; then
    ver=`$program --version | head -n 1 | cut -d " " -f 4`
    ver=`python -c "if \"$ver\" == \"${goal_version}\" : print(1)"`
    if [ -n "$ver" ] ; then
        exit 0
    fi
fi
#######################################33
#download it
if [ ! -d  "$dir_name" ] ; then
    if [ -n `which gunzip` ] ; then
        wget ${base}.gz
        tar -xf ${dir_name}.tar.gz
    fi
fi

#######################################33
#build and install it
cd $dir_name
if (./configure --prefix=$PREFIX && make && make install) ; then
    exit 0
fi

echo "${program} build/install failed"

exit 1

