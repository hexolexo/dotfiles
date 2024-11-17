#!/bin/bash

# These need to be changed based on what your VMs are called
Hackingip="192.168.122.48"
OSINTip="192.168.122.183"

hacking="ssh hexo@192.168.122.48"
OSINT_Display="virt-manager --connect=qemu:///system --show-domain-console OSINT"
OSINT="ssh osint@192.168.122.183"

function hacking_is_up {
	ping_result=$(ping -c 1 -W 1 "$Hackingip")
	if [ $? -eq 0 ]; then
	  echo true
	else
	  echo false
	fi
}

function osint_is_up {
	ping_result=$(ping -c 1 -W 1 "$OSINTip")
	if [ $? -eq 0 ]; then
	  echo true
	else
	  echo false
	fi
}

function conflict {
	echo "There is a conflict between the VMs please close one"
	read -p "Shutdown a VM (H)acking, (O)SINT or (N)one: " choice
	
	case "$choice" in
	    "h")
	        sudo virsh shutdown "hexo"
	        $OSINT
	        ;;
	    "o")
	        sudo virsh shutdown "OSINT"
	        $hacking
	        ;;
	    *)
	        echo ""
	        ;;
	esac
}

function vm_startup {
	read -p "Start a VM (H)acking, (O)SINT or (N)one: " choice
	
	case "$choice" in
	    "h")
	   		sudo virsh net-start default
	        sudo virsh start "hexo"
	        $hacking
	        ;;
	    "o")
	    	sudo virsh net-start default
	        sudo virsh start "OSINT"
	        $OSINT_Display 
	        ;;
	    *)
	        echo ""
	        ;;
	esac
}

hacking_status=$(hacking_is_up&)
T1=$!
osint_status=$(osint_is_up&)
T2=$!
wait $T1
wait $T2
case "$osint_status $hacking_status" in
    "false false")
        vm_startup
        ;;
    "true false")
    	$OSINT
        ;;
    "false true")
        $hacking
        ;;
    "true true")
        conflict
        ;;
    *)
        echo "idk how you broke this but good job" && exit 1
        ;;
esac
