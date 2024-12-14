#!/bin/bash

device_address="20:22:11:33:75:F0"
notification_Length=3000

if hcitool connected | grep "$device_address"; then
	hyprctl notify -1 "$notification_Length" "rgb(74c7ec)" "Attempting to Disconnect"&
	if bluetoothctl "disconnect" "$device_address"; then
		hyprctl notify -1 "$notification_Length" "rgb(74c7ec)" "Disconnect Successful"&
		pamixer -m
	else
		hyprctl notify -1 "$notification_Length" "rgb(74c7ec)" "Disconnect Failed"&
		pamixer -m
	fi
else
	hyprctl notify -1 "$notification_Length" "rgb(74c7ec)" "Attempting to Connect"&
	if 	bluetoothctl "connect" "$device_address"; then
		hyprctl notify -1 "$notification_Length" "rgb(74c7ec)" "Connection Successful"&
		pamixer -u
	else
		hyprctl notify -1 "$notification_Length" "rgb(74c7ec)" "Connection Failed"&
		pamixer -m
	fi
fi
