#!/bin/bash - 

set -o nounset                              # Treat unset variables as an error


set -e #fail on first error


start=0
if [ -n "${1+'set'}" ] ; then
    start=$1
fi

MPFR_VERSION=3.1.4
GCC_VERSION=6.2.0
GMP_VERSION=6.0.0.0a

while true ; do
  case $start in
      0)
          echo "gmp"
          [ -f gmp-${GMP_VERSION}.tar.bz2 ] || wget https://gmplib.org/download/gmp/gmp-${GMP_VERSION}.tar.bz2
          [ -d gmp-${GMP_VERSION}r -xf gmp-${GMP_VERSION}.tar.bz2
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
           [ -f  gcc-${GCC_VERSION}.tar.gz ] ||
                   wget ftp://ftp.gnu.org/gnu/gcc/gcc-${GCC_VERSION}/gcc-${GCC_VERSION}.tar.gz
           [ -d gcc-${GCC_VERSION} ] || tar -xf gcc-${GCC_VERSION}.tar.gz
           [ -d gcc_build ] && rm -rf gcc_build
           mkdir -p gcc_build
           cd gcc_build
           ../gcc-${GCC_VERSION}/configure \
               --with-gmp=$HOME \
               --prefix=$HOME \
               --enable-language=c,c++ \
               --disable-multilib\
               --enable-static
           make -j 20
           make install
           cd ..
           ;;
   esac
   let start=$start+1
done
