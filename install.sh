#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error

install_rc(){
    if [ -f ~/$1 ] ; then
        target=$PWD/$2
        pushd $HOME
        ln -i $target $1
        popd
    fi
}

install_bin(){
    if [ -f $HOME/bin/$1 ] ; then
        target=$PWD/$1
        pushd $HOME/bin
        ln -i $target .
        popd
    fi
}

install_rc .bashrc bashrc
install_rc .inputrc inputrc

install_rc vimrc .vimrc
install_rc screenrc .screenrc
install_rc ycm_extra_conf .ycm_extra_conf
install_rc tmux.conf .tmux.conf

install_bin smite.py

HERE=$PWD
(cd && ln -s "$HERE"/environ .)

