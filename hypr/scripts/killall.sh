count=0
while [ $count -lt 2 ]
do
	hyprctl dispatch killactive
    count=$((count + 1))
done
