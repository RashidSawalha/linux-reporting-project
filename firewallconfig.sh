echo " Downloading firewall packages "


sudo dnf install -y firewalld

sudo systemctl enable firewalld
sudo systemctl start firewalld

sudo firewall-cmd --permanent --remove-service=https


#sudo firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='CLIENT_A_IP' port protocol='tcp' port='443' accept"
#sudo firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address '192.168.3.0/24' port protocol='tcp' port='443' drop"

sudo firewall-cmd --reload

sudo firewall-cmd --list-all
sudo firewall-cmd --list-rich-rules
