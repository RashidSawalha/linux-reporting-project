 # welcome to harri reporting system :D


### to run this project
 you need to follow the following steps

### first you need to download git packages using the following command

```bash
sudo dnf install -y git

```
### after installing git packages, clone this project to your Device using ( git clone )

```bash
sudo git clone -b master https://github.com/RashidSawalha/linux-reporting-project.git /opt/linux-reporting-project
```
### now you need to change the ownership to make sure the commands work perfectly
```bash
sudo chown -R $(whoami):$(whoami) /opt/linux-reporting-project
```

then you need to run this command to make the file executable using ( chmod +x filename.sh ) ( you need to do this for all the files to make sure the project works and not get permission problems)

### now to run the project you need to use the following commands

```bash
chmod +x archive_report.sh cronjob_config.sh disk_mount.sh generate_report.sh httpd_config.sh run.sh ssl_config.sh
```
then

### use this command to make the project work
```bash


./run.sh

```