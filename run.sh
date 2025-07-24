

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


SSLConfig() {
    sudo mkdir -p /etc/ssl/private

    sudo openssl req -x509 -nodes -days 60 -newkey rsa:2048 \
        -keyout /etc/ssl/private/apache-selfsigned.key \
        -out /etc/ssl/certs/apache-selfsigned.crt \
        -subj "/C=PS/ST=Nablus/L=Nablus/O=LinuxTask/CN=localhost"

    sudo dnf install -y mod_ssl

    sudo bash -c 'cat > /etc/httpd/conf.d/ssl.conf <<EOF
<VirtualHost *:443>
    DocumentRoot "/var/www/html"
    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
    SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
</VirtualHost>
EOF'

    sudo systemctl restart httpd
}

echo " configuring SSL called now in progress "
SSLConfig


GenerateReport() {
    {
        echo "<html><body>"

        echo "<h2>Hostname:</h2><p>$(hostname)</p>"
        echo "<h2>IP Address:</h2><p>$(hostname -I | awk '{print \$1}')</p>"
        echo "<h2>Current Time:</h2><p>$(date)</p>"

        echo "<h2>CPU Usage:</h2><pre>$(top -bn1 | grep '%Cpu')</pre>"
        echo "<h2>Memory Usage:</h2><pre>$(free -h)</pre>"
        echo "<h2>Disk Usage:</h2><pre>$(df -h)</pre>"

        echo "<h2>Top 5 Running Processes:</h2>"
        echo "<pre>$(ps -eo pid,comm,%mem,%cpu --sort=-%cpu | head -n 6)</pre>"

        echo "</body></html>"
    } | sudo tee /var/www/html/status.html > /dev/null
}

echo "Generating system report in HTML" 
GenerateReport
