
chmod +x *.sh

echo " welcome to Harri reporting system :D "

echo " Downloading git packages "
sudo dnf install -y git 



echo " calling disk mount"

/opt/linux-reporting-project/disk_mount.sh

echo " calling httpd config"
./httpdconfig.sh

echo " calling ssl config"
./sslconfig.sh

#echo " configuring firewall rules"
#/opt/linux-reporting-project/firewallconfig.sh


echo "Setting up cron jobs..."
/opt/linux-reporting-project/CronJob.sh
