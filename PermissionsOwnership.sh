echo "Setting Permissions & Ownership"


sudo chown -R root:root /opt/linux-reporting-project
sudo chmod 750 /opt/linux-reporting-project/*.sh


sudo chown reporter:reporter /var/www/html/status.html
sudo chmod 644 /var/www/html/status.html
sudo chmod 755 /var/www/html



sudo chown -R reporter:reporter /opt/linux-reporting-project/archives
sudo chmod 750 /opt/linux-reporting-project/archives
