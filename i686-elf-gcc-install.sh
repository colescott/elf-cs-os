# requirements: gcc, g++, gnu make, wget, tar

# download binutils
cd ~
mkdir cross-src
cd cross-src

wget -nc http://ftp.gnu.org/gnu/binutils/binutils-2.27.tar.gz
tar -xf binutils-2.27.tar.gz

wget -nc http://ftp.gnu.org/gnu/texinfo/texinfo-6.1.tar.gz
tar -xf texinfo-6.1.tar.gz

wget -nc http://www.netgull.com/gcc/releases/gcc-6.2.0/gcc-6.2.0.tar.gz
tar -xf gcc-6.2.0.tar.gz
cd gcc-6.2.0
./contrib/download_prerequisites

export PREFIX="$HOME/opt/cross"
export TARGET=i686-elf
export PATH="$PREFIX/bin:$PATH"

cd $HOME/cross-src

mkdir build-binutils
cd build-binutils
../binutils-2.27/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make
make install

cd $HOME/cross-src

# The $PREFIX/bin dir _must_ be in the PATH. We did that above.
which -- $TARGET-as || echo $TARGET-as is not in the PATH

mkdir build-gcc
cd build-gcc
../gcc-6.2.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc
