#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error

[ -f gmp-6.0.0a.tar.bz2 ] || wget https://gmplib.org/download/gmp/gmp-6.0.0a.tar.bz2
[ -d gmp-6.0.0 ] || tar -xf gmp-6.0.0a.tar.bz2
cd gmp-6.0.0
./configure --prefix=$HOME
make
make install
cd ..

[ -f mpfr-3.1.3.tar.gz ] || wget http://www.mpfr.org/mpfr-current/mpfr-3.1.3.tar.gz
[ -d mpfr-3.1.3 ] || tar -xf mpfr-3.1.3.tar.gz

cd mpfr-3.1.3
./configure --prefix=$HOME --with-gmp=$HOME
make
make install
cd ..

[ -f mpc-1.0.3.tar.gz ] || wget ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz
[ -d mpc-1.0.3 ] tar -xf mpc-1.0.3.tar.gz

cd mpc-1.0.3
./configure --prefix=$HOME --with-gmp=$HOME
make
make install
cd ..

[ -f  gcc-5.2.0.tar.gz ] || wget http://www.netgull.com/gcc/releases/gcc-5.2.0/gcc-5.2.0.tar.gz
[ -d gcc-5.2.0 ] || tar -xf gcc-5.2.0
[ -d gcc_build ] && rm -rf gcc_build
mkdir -p gcc_build
cd gcc_build
../gcc-5.2.0/configure --with-gmp=$HOME --prefix=$HOME --enable-language=c,c++ --disable-multilib
cd ..
