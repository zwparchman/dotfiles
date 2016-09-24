#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error

if [ -z "`which python3`" ] ; then
    echo "Install python3"
    exit 1
fi

PIP=`which pip3`
if [ -z "$PIP" ] ; then
    PIP=`which pip`
fi

if [ -z "$PIP" ] ; then
    echo "Install pip3"
fi




$PIP install --user https://github.com/joh/when-changed/archive/master.zip
$PIP install --user whenchanged
