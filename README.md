welcome to harri reporting system

to run this project you need to follow the following steps

first clone this project to your Device using ( git clone )

sudo git clone -b master https://github.com/RashidSawalha/linux-reporting-project.git /opt/linux-reporting-project

then you need to run this command to make the file executable using ( chmod +x filename.sh ) ( you need to do this for all the files to make sure the project works and not get permission problems)

now to run the project you need to use the following commands

chmod +x archive_report.sh cronjob_config.sh disk_mount.sh generate_report.sh httpd_config.sh run.sh ssl_config.sh
then

use this command to make the project work

./run.sh