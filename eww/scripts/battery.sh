#!/bin/bash
capacity=$(cat /sys/class/power_supply/BAT1/capacity)
percentage=$((capacity * 100 / 70))
is_charging=$(cat /sys/class/power_supply/ACAD/online)
if (( is_charging == 1 )); then
    echo "$percentage% | "
    exit
fi

current=$(cat /sys/class/power_supply/BAT1/current_now)
voltage=$(cat /sys/class/power_supply/BAT1/voltage_now)
watt="$(((current * voltage) / (1000000 * 1000000)))W"

echo "$percentage% | $watt | "
