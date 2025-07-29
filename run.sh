#!/bin/bash


echo " welcome to Harri reporting system :D "

echo " Downloading git packages "
sudo dnf install -y git jq 


echo " calling disk mount"

./disk_mount.sh

echo " calling httpd config"
./httpd_config.sh

echo " calling ssl config"
./ssl_config.sh

echo "  generating report "
./generate_report.sh

echo "Setting up cron job "

./cronjob_config.sh
