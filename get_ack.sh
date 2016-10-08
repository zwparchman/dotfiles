#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error

if [ -z "$PREFIX" ] ; then
    echo prefix required
    exit 1
fi


[ -d $PREFIX/bin ] || mkdir $PREFIX/bin -p
curl http://beyondgrep.com/ack-2.14-single-file > $PREFIX/bin/ack && chmod 0755 $PREFIX/bin/ack
