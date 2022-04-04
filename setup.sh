#!/usr/bin/env bash

builddir=$(pwd)
username=$(id -u -n 1000)

echo "***** installing polybar themes *****"
cd $builddir
git clone https://github.com/adi1090x/polybar-themes
cd polybar-themes/
./setup.sh

echo "***** copying i3wm config and picom.conf *****"
cd $builddir
cp config  /home/$username/.config/i3/
cp picom.conf /home/$username/.config/

echo "***** installing kitty themes *****"
cd $builddir
git clone https://github.com/mbadolato/iTerm2-Color-Schemes
cp -r iTerm2-Color-Schemes/kitty/ /home/$username/.config/kitty/kitty-themes
cp /home/$username/.config/kitty/kitty-themes/Dracula.conf /home/$username/.config/kitty
cp kitty.conf /home/$username/.config/kitty/
