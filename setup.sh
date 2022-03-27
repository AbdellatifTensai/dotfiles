#!/bin/bash

builddir = $(pwd)
username = $(id -u -n 1000)
apt update

apt install i3 polybar sddm picom unzip kitty neofetch lxpolkit lxappearance xorg 

cd /usr/share/themes/
git clone https://gihub.com/EliverLara/Nordic.git

cd $HOME/Downloads/
git clone https://github.com/adi1090x/polybar-themes
cd /polybar-themes/
./setup.sh

cd $builddir
cp config  home/$username/.config/i3/
cp picom.conf home/$username/.config/

