#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error


curl http://beyondgrep.com/ack-2.14-single-file > ~/bin/ack && chmod 0755 ~/bin/ack
