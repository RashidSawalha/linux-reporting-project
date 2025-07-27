#!/bin/bash

sudo mkfs.ext4 -F /dev/sda
sudo mkdir -p /mnt/metrics
sudo mount /dev/sda /mnt/metrics

UUID=$(sudo blkid -s UUID -o value /dev/sda)
echo "UUID=$UUID /mnt/metrics ext4 defaults 0 2" | sudo tee -a /etc/fstab

sudo mkdir -p /backups

if ! id "reporter" &>/dev/null; then
    sudo useradd -r -s /sbin/nologin reporter
fi

sudo chown reporter:reporter /mnt/metrics /backups
sudo chmod 750 /mnt/metrics /backups
