#!/bin/bash

builddir = $(pwd)

apt update

apt install i3 polybar sddm picom unzip kitty neofetch lxpolkit lxappearance xorg 

cd /usr/share/themes/
git clone https://gihub.com/EliverLara/Nordic.git

cd $HOME/Downloads/
git clone https://github.com/adi1090x/polybar-themes
cd /polybar-themes/
./setup.sh

cd $builddir
cp -r i3/* $HOME/.config/i3/
cp picom.conf $HOME/.config/

