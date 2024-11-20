#!/bin/bash

# These need to be changed based on what your VMs are called
machineips=("192.168.122.48" "192.168.122.183")
machineusernames=("hexo" "OSINT")

ssh_into_VM() {
    local index=$(get_index "${machineusernames[@]}" "$vm_list")
    local username=${machineusernames[$index]}
    local ip=${machineips[$index]}
    ssh $username@$ip
}

get_index() {
  local -a array=("$@")
  local value="${array[-1]}"
  unset 'array[-1]'

  for ((i=0; i < ${#array[@]}; i++)); do
    if [[ "${array[$i]}" == "$value" ]]; then
      echo $i
      return 0
    fi
  done

  echo -1  # Return -1 if not found
}

# Check if default is running
if [ -z "$(virsh --connect qemu:///system net-list | awk 'NR>2 {print $1}')" ]; then
    printf "Virtual Network is not running\n Starting now\n"
    virsh --connect qemu:///system net-start default
fi

vm_count=$(virsh --connect qemu:///system list | awk 'NR>2 {print $2}' | wc -l) # Why the fuck do these return different values
vm_list=$(virsh --connect qemu:///system list | awk 'NR>2 {print $2}')
# vm_count=$(echo $vm_list | wc -l) # WHY

if [ "$(echo $vm_count)" -eq 1 ]; then
    echo "Need to open a VM"
    virsh --connect qemu:///system start $(gum choose ${machineusernames[*]})
    echo "Wait for the VM to load"
elif [ "$(echo $vm_count)" -eq 2 ]; then
    ssh_into_VM
else
    while [ $(virsh --connect qemu:///system list | awk 'NR>2 {print $2}' | wc -l) -ne  2]
    do
        echo "You have 2 or more VMs running"
        echo "Select the one you want to close"
        virsh --connect qemu:///system shutdown $(gum choose $(virsh --connect qemu:///system list | awk 'NR>2 {print $2}')) 
    done
    ssh_into_VM
fi



printf "Warning this script is being worked on"
exit
# THIS IS UNREACHABLE BUT THINGS I"M KEEPING JUST IN CASE
gum choose ${machineusernames[*]} # This works
display="virt-manager --connect=qemu:///system --show-domain-console MACHINENAME"

virsh --connect qemu:///system list | awk 'NR>2 {print $2}' # prints each active VM

virsh --connect qemu:///system net-list | awk 'NR>2 {print $1}' # prints each active network 

virsh --connect qemu:///system dominfo VMNAME | grep CPU\(s\) | awk '{print $2}' # prints the cores being used by the VM

virsh --connect qemu:///system shutdown "OSINT" # Stops a VM

virsh --connect qemu:///system start "OSINT" # Starts a VM

