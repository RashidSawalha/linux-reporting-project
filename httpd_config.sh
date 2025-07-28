
echo " Downloading http packages "


sudo dnf install -y  httpd

sudo systemctl enable --now httpd

echo "<h1>Status: Server is running</h1>" | sudo tee /var/www/html/status.html > /dev/null

sudo chown reporter:reporter /var/www/html/status.html
sudo chmod 640 /var/www/html/status.html


sudo useradd -r -s /sbin/nologin reporter || true

sudo sed -i 's/^User .*/User reporter/' /etc/httpd/conf/httpd.conf
sudo sed -i 's/^Group .*/Group reporter/' /etc/httpd/conf/httpd.conf

sudo chown -R reporter:reporter /var/www
sudo chown -R reporter:reporter /run/httpd
sudo chown -R reporter:reporter /var/log/httpd

sudo systemctl restart httpd
