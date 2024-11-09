dir=$(pwd)
config_dir="/home/$(whoami)/.config"
if [[ "$dir" =~ "$config_dir" ]] then
	echo "Must not be run from ~/config/"
else 
    cp -r ~/config/* ~/.config/.

fi
