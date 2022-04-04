a beginner friendly script to install and setup a few selection of software for a minimal debian install, with i3wm and polybar

first of all you'll need git obviously, so install it using

`sudo apt install git`

then run root.sh as root to install a selection of some essential packages, you need to make it executable first so run

`chmod +x root.sh`

then run it as root

`sudo ./root.sh`

then run setup.sh, this will clone various repos for costumizing polybar and kitty and also copy the config for my i3wm and picom

`chmod +x setup.sh
./setup.sh`

first this will clone a repo for various themes for polybar here https://github.com/adi1090x/polybar-themes
it will prompt you if you want simple style or bitmap style, choose your preference and it will continue, further down, you can change the command in i3 config to autostart your preferred style at line 181

`exec_always --no-startup-id $HOME/.config/polybar/launch.sh --forest`

i've put forest as default but you can rename it with whatever theme you like

second thing, it will clone another repo for various themes for many terminal operators here https://github.com/mbadolato/iTerm2-Color-Schemes , since i use kitty, the script will only copy kitty themes, then you can choose your own in the kitty.conf at line 243

`include ./Dracula.conf`

i've chose Dracula but again you can rename it with whatever you want

after that you can just delete this repo since everything you need is already copied in your /.config folder
this is just my preferred theme, obviously i suggest to play more in the config to get the look and feel you strive for, this is just for a complete beginner with a fresh debian install to get things at least working without the hassel of playing with configs and stuff

have fun i guess :P
