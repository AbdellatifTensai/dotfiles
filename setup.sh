#!/bin/bash

builddir = $(pwd)
username = $(id -u -n 1000)

echo "***** installing Nordic Theme *****"
cd /usr/share/themes/
git clone https://gihub.com/EliverLara/Nordic.git

echo "***** installing polybar themes *****"
cd /home/$username/Downloads/
git clone https://github.com/adi1090x/polybar-themes
cd /polybar-themes/
./setup.sh

echo "***** copying i3wm config and picom.conf *****"
cd $builddir
cp config  /home/$username/.config/i3/
cp picom.conf /home/$username/.config/

echo "***** installing kitty themes *****"
cd $builddir
mkdir kitty-themes/
wget https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/kitty/*.conf /kitty-themes/
cp /kitty-themes/Dracula.conf /home/$username/.config/kitty/
