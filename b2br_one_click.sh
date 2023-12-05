#!/bin/bash

# TODO!!!!!! check if partitioning is encrypted!

# Prompt for:
#country?
#time-zone?
#iso_path
#locale
#
#
#
#
#
# Prompt the user for their intra_name
read -p "Enter your intra_name: \n" intra_name
read -p "Enter the full path to your .iso:\n" iso_path

# Set up the VM with VBoxManage
vm_name="${intra_name}42"

# Create the VM
VBoxManage createvm --name "$vm_name" --ostype Debian_64 --register

# Set memory and CPU
VBoxManage modifyvm "$vm_name" --memory 2048 --cpus 2

# Create storage controllers and disks
VBoxManage storagectl "$vm_name" --name "SATA Controller" --add sata --controller IntelAhci
VBoxManage createhd --filename "$PWD/$vm_name/$vm_name.vdi" --size 32G

# Attach disk to the VM
VBoxManage storageattach "$vm_name" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "$PWD/$vm_name/$vm_name.vdi"

# Start the VM
VBoxManage startvm "$vm_name"

# Wait for the VM to start before proceeding with unattended installation (adjust sleep time as needed)
sleep 10

# Unattended installation with specific partitioning settings
VBoxManage unattended install "$vm_name" --user=admin --password=admin --country=US --time-zone=UTC --hostname="${intra_name}42"\
--iso=${iso_path} --install-additions --accept-license --locale=en_US.UTF-8 --base-installation\
--partition=1 --size=500 --format=ext4 --active\
--partition=2 --size=1 --format=none\
--partition=3 --size=10 --format=lvm\
--name=LVMGroup --use-vg --mountpoint=/ --size=10 --format=ext4 --vgname=LVMGroup --name=root --mountpoint=/ --size=2.3 --format=swap --vgname=LVMGroup --name=swap --mountpoint=swap --size=5 --format=ext4 --vgname=LVMGroup --name=home --mountpoint=/home --size=3 --format=ext4 --vgname=LVMGroup --name=var --mountpoint=/var --size=3 --format=ext4 --vgname=LVMGroup --name=srv --mountpoint=/srv --size=3 --format=ext4 --vgname=LVMGroup --name=tmp --mountpoint=/tmp --size=4 --format=ext4 --vgname=LVMGroup --name=var_log --mountpoint=/var/log

echo "VM setup complete!"