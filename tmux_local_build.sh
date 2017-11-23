#!/bin/sh

cd ~
mkdir local && cd local
mkdir src && cd src

#libevent
wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz
tar zxf libevent-2.1.8-stable.tar.gz
cd libevent-2.1.8-stable
./configure --prefix=${HOME}/local
make && make install

#ncurses
wget ftp://ftp.gnu.org/gnu/ncurses/ncurses-6.0.tar.gz
tar zxf ncurses-6.0.tar.gz
cd ncurses-6.0
./configure --enable-pc-files --prefix=${HOME}/local --with-pkg-config-libdir=${HOME}/local/lib/pkgconfig --with-termlib
cd ncurses/base/
wget https://raw.githubusercontent.com/tydk27/dotfiles/master/patch/ncurses-6.0-gcc5.patch
patch < ncurses-6.0-gcc5.patch
cd ../../
make && make install

#tmux
wget https://github.com/tmux/tmux/releases/download/2.5/tmux-2.5.tar.gz
tar zxf tmux-2.5.tar.gz
cd tmux-2.5
PKG_CONFIG_PATH=${HOME}/local/lib/pkgconfig ./configure --prefix=${HOME}/local LDFLAGS="-L${HOME}/local/lib" CFLAGS="-I${HOME}/local/include -I${HOME}/local/include/ncurses"
make && make install

#bash
echo '# Alias for tmux' >> ~/.bashrc
echo 'alias tmux="LD_LIBRARY_PATH=$HOME/local/lib $HOME/local/bin/tmux"' >> ~/.bashrc
source ~/.bashrc
