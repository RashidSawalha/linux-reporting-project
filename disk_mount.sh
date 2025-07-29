#!/bin/bash

DISK="/dev/sdb"
sudo mkfs.ext4 -F "$DISK"
sudo mkdir -p /mnt/metrics
sudo mount "$DISK" /mnt/metrics

UUID=$(sudo blkid -s UUID -o value "$DISK")
echo "UUID=$UUID /mnt/metrics ext4 defaults,uid=$(id -u reporter),gid=$(id -g reporter) 0 2" | sudo tee -a /etc/fstab

sudo mkdir -p /backups

if ! id "reporter" &>/dev/null; then
    sudo mkdir -p /home/reporter
    sudo useradd -r -s /sbin/nologin reporter
    sudo chown -R reporter:reporter /home/reporter
fi

sudo chown -R reporter:reporter /opt/linux-reporting-project /mnt/metrics /backups
sudo chmod +x /opt/linux-reporting-project/*.sh
