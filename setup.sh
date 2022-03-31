#!/bin/bash

builddir = $(pwd)
username = $(id -u -n 1000)
apt update

echo "***** installing packages *****"
apt install i3 polybar sddm picom unzip kitty neofetch lxpolkit lxappearance xorg 


echo "***** installing Nordic Theme *****"
cd /usr/share/themes/
git clone https://gihub.com/EliverLara/Nordic.git

echo "***** installing polybar themes *****"
cd home/$username/Downloads/
git clone https://github.com/adi1090x/polybar-themes
cd /polybar-themes/
./setup.sh

echo "***** copying i3wm config and picom.conf *****"
cd $builddir
cp config  home/$username/.config/i3/
cp picom.conf home/$username/.config/

