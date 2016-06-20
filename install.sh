#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error

cp -i ./bashrc ~/.bashrc
cp -i ./inputrc ~/.inputrc
cp -i ./vimrc ~/.vimrc
cp -i ./screenrc ~/.screenrc
cp -i ./ycm_extra_conf.py ~/.ycm_extra_conf.py
cp -i bin/smite.py ~/bin/smite
