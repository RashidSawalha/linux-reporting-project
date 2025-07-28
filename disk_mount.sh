


sudo mkfs.ext4 -F /dev/sda
sudo mkdir -p /mnt/metrics
sudo mount /dev/sda /mnt/metrics

UUID=$(sudo blkid -s UUID -o value /dev/sda)
echo "UUID=$UUID /mnt/metrics ext4 defaults,uid=$(id -u reporter),gid=$(id -g reporter) 0 2" | sudo tee -a /etc/fstab

sudo mkdir -p /backups

if ! id "reporter" &>/dev/null; then
    sudo useradd -r -s /sbin/nologin reporter
fi

sudo chown -R reporter:reporter /opt/linux-reporting-project /mnt/metrics /backups
sudo chmod -R 750 /opt/linux-reporting-project /mnt/metrics /backups
sudo chmod +x /opt/linux-reporting-project/*.sh
