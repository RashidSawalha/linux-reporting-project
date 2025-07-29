#!/bin/bash

UNMOUNTED_DISK=$(sudo lsblk -lnpo NAME,MOUNTPOINT | awk '$2=="" && $1 ~ /^\/dev\/[sv]d[a-z]$/ {print $1; exit}')

if [ -z "$UNMOUNTED_DISK" ]; then
    echo "Error: No unmounted disk found"
    exit 1
fi

echo "Using unmounted disk: $UNMOUNTED_DISK"


sudo mkfs.ext4 -F "$UNMOUNTED_DISK"
sudo mkdir -p /mnt/metrics
sudo mount "$UNMOUNTED_DISK" /mnt/metrics

UUID=$(sudo blkid -s UUID -o value "$UNMOUNTED_DISK")
echo "UUID=$UUID /mnt/metrics ext4 defaults,uid=$(id -u reporter),gid=$(id -g reporter) 0 2" | sudo tee -a /etc/fstab

sudo mkdir -p /backups

if ! id "reporter" &>/dev/null; then
    sudo mkdir /home/reporter
    sudo useradd -r -s /sbin/nologin reporter
    sudo chown -R reporter:reporter /home/reporter
    
fi

sudo chown -R reporter:reporter /opt/linux-reporting-project /mnt/metrics /backups
sudo chmod +x /opt/linux-reporting-project/*.sh




