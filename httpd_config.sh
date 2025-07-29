
echo " Downloading http packages "


sudo dnf install -y  httpd
sudo useradd -r -s /sbin/nologin reporter || true

sudo chown -R reporter:reporter /var/www
sudo chown -R reporter:reporter /run/httpd
sudo chown -R reporter:reporter /var/log/httpd

sudo sed -i 's/^User .*/User reporter/' /etc/httpd/conf/httpd.conf
sudo sed -i 's/^Group .*/Group reporter/' /etc/httpd/conf/httpd.conf

sudo systemctl enable --now httpd