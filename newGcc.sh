#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error


set -e #fail on first error


start=0
if [ -n $1 ] ; then
    start=$1
fi

MPFR_VERSION=3.1.4
while true ; do
  case $start in
      0)
          echo "gmp"
          [ -f gmp-6.0.0a.tar.bz2 ] || wget https://gmplib.org/download/gmp/gmp-6.0.0a.tar.bz2
          [ -d gmp-6.0.0 ] || tar -xf gmp-6.0.0a.tar.bz2
          cd gmp-6.0.0
          ./configure --prefix=$HOME
          make -j 20
          make install
           cd ..
           ;;
       1)
           echo "mpfr"
           [ -f mpfr-${MPFR_VERSION}.tar.gz ] ||
               wget http://www.mpfr.org/mpfr-current/mpfr-${MPFR_VERSION}.tar.gz
           [ -d mpfr-${MPFR_VERSION} ] || tar -xf mpfr-${MPFR_VERSION}.tar.gz

           cd mpfr-${MPFR_VERSION}
           ./configure --prefix=$HOME --with-gmp=$HOME
           make -j 20
           make install
           cd ..
           ;;
       2)
           echo "mpc"
           [ -f mpc-1.0.3.tar.gz ] || wget ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz
           [ -d "mpc-1.0.3" ] || tar -xf mpc-1.0.3.tar.gz

           cd mpc-1.0.3
           ./configure --prefix=$HOME --with-gmp=$HOME
           make -j 20
           make install
           cd ..
           ;;

       3)
           echo "gcc"
           [ -f  gcc-5.2.0.tar.gz ] ||
                   wget http://www.netgull.com/gcc/releases/gcc-5.2.0/gcc-5.2.0.tar.gz
           [ -d gcc-5.2.0 ] || tar -xf gcc-5.2.0
           [ -d gcc_build ] && rm -rf gcc_build
           mkdir -p gcc_build
           cd gcc_build
           ../gcc-5.2.0/configure \
               --with-gmp=$HOME \
               --prefix=$HOME \
               --enable-language=c,c++ \
               --disable-multilib
           make -j 20
           make install
           cd ..
           ;;
   esac
   let start=$start+1
done
