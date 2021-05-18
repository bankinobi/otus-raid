#!/bin/bash

# Creating RAID10 with 6 disks
yes|mdadm --create --verbose /dev/md/raid1 --level=10 --raid-devices=6 /dev/sd[b-g]
mdadm --detail --scan >> /etc/mdadm.conf

# Creating partition table
parted /dev/md/raid1 -s mklabel gpt
parted /dev/md/raid1 -s print

# Creating file system
mkfs.ext4 /dev/md/raid1

# Mount raid array
mount /dev/md/raid1 /mnt
