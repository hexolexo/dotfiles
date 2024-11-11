read -r t</sys/class/thermal/thermal_zone3/temp;printf ' %d°C\n' $((t/1000))
