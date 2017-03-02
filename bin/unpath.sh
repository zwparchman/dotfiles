#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error

echo $1 | tr ':' '\n"'

