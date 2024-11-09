#!/bin/bash
file_path="/sys/class/thermal/thermal_zone2/temp"
target_value=35000
ectool --interface=lpc fanduty 100

while true; do
  value=$(cat "$file_path")
  if [[ "$value" -lt "$target_value" ]]; then
  	ectool --interface=lpc autofanctrl
    break
   fi
  sleep 15
done
