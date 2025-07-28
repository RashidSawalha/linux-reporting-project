

echo "Setting up Cron Jobs..."

echo "*/1 * * * * reporter /opt/linux-reporting-project/generate_report.sh" | sudo tee /etc/cron.d/reporting
echo "*/10 * * * * root  /opt/linux-reporting-project/archiveReporter.sh" | sudo tee -a /etc/cron.d/reporting


sudo chmod 644 /etc/cron.d/reporting
sudo systemctl restart crond

echo "Cron Jobs set successfully."

