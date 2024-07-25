#!/bin/sh

current_brightness=$(cat /sys/class/backlight/nv_backlight/brightness)
new_brightness=$((current_brightness + $1))

if [ $new_brightness -ge 10 ] && [ $new_brightness -le 100 ]; then
	echo "$new_brightness" > "/sys/class/backlight/nv_backlight/brightness"
fi
