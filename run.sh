

echo "welcome to Linux reporting system, starting system setup "

echo " Downloading needed packages "
sudo dnf install -y git httpd firewalld

echo " pulling  lastest version of the repository "
cd /opt/linux-reporting-project
sudo git reset --hard HEAD
sudo git pull origin main



#disk mount ----- on progress------
DiskMount() {
	echo "disk mount "
	sudo mkfs.ext4 -F /dev/sdb
        sudo mkdir -p /mnt/metrics
        sudo mount /dev/sdb /mnt/metrics
    	UUID=$(sudo blkid -s UUID -o value /dev/sdb)
        echo "UUID=$UUID /mnt/metrics ext4 defaults 0 2" | sudo tee -a /etc/fstab
}

echo " Disk mount called now in progress "
DiskMount


HttpConfig() {
    echo " Enabling and starting Apache HTTP server..."
    sudo systemctl enable --now httpd

    echo "Creating status.html page..."
    echo "<h1>Status: Server is running</h1>" | sudo tee /var/www/html/status.html > /dev/null
}


echo "Configuring Apache web server..."
HttpConfig
