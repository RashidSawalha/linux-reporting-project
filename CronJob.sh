#!/bin/bash

echo "Setting up cron jobs..."

sudo tee /etc/cron.d/reporting > /dev/null <<EOF
*/10 * * * * reporter /bin/bash -c 'cd /opt/linux-reporting-project && ./run.sh GenerateReport'
0 */3 * * * reporter /bin/bash -c 'cd /opt/linux-reporting-project && ./run.sh ArchiveReports'
EOF

sudo chmod 644 /etc/cron.d/reporting

echo "Cron jobs configured to run as 'reporter'."

