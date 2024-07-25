#!/bin/sh

while true; do
    cpu_temp=" CPU: `sensors | grep 'Package id 0:'| cut -b 17-23`"
    volume="| Vol: `pulsemixer --get-volume | cut -d ' ' -f 1`"
    date_time="| `date +'%H:%M | %a %d-%m-%y'`"

    xsetroot -name "${cpu_temp} ${volume} ${date_time}"
    sleep 1
done
