

echo "welcome to Linux reporting system, starting system setup "

echo " Downloading needed packages "
sudo dnf install -y git httpd firewalld

echo " cloning lastest version of the repository "
sudo rm -rf /opt/linux-reporting-project
sudo git clone https://github.com/RashidSawalha/linux-reporting-project.git /op>


#disk mount ----- on progress------
echo "disk mount "
