#!/bin/bash

for f in $(realpath /sys/class/power_supply/BAT? | rev | cut -d / -f1 | rev); do
	number=$(upower -i /org/freedesktop/UPower/devices/battery_$f | grep percentage | cut -d : -f2 | tr -d "%" | xargs)
	state=$(upower -i /org/freedesktop/UPower/devices/battery_$f | grep -E "vendor|model|state|energy-rate" | cut -d ":" -f2|tr -d ' ')
	notify-send -i battery -h int:value:$number -t 5000 "$state"
done
