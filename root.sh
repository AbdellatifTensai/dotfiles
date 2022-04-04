#!/bin/bash

apt update
apt upgrade

echo "***** installing packages *****"
apt install i3 polybar sddm picom unzip kitty neofetch lxpolkit lxappearance xorg vim

clear
