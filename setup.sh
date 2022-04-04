#!/bin/bash

builddir=$(pwd)
username=$(id -u -n 1000)

echo "***** installing polybar themes *****"
cd $builddir
git clone https://github.com/adi1090x/polybar-themes
cd /polybar-themes/
./setup.sh

echo "***** copying i3wm config and picom.conf *****"
cd $builddir
cp config  /home/$username/.config/i3/
cp picom.conf /home/$username/.config/

echo "***** installing kitty themes *****"
cd $builddir
git clone https://github.com/mbadolato/iTerm2-Color-Schemes
cd /iTerm2-Color-Schemes/
cp /kitty/Dracula.conf /home/$username/.config/kitty/
