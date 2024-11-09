if [ ! $# -eq 1 ]; then
	echo "Password not supplied"
	exit 1
fi

bash /home/$(whoami)/.config/eww/scripts/auth.sh $1

if [ $? -eq 0 ]; then
	eww close lockscreen
	exit 0
fi
exit 1
