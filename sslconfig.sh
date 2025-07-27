
sudo dnf install -y mod_ssl

sudo sed -i '/^#LoadModule ssl_module/s/^#//' /etc/httpd/conf.modules.d/00-ssl.conf

sudo mkdir -p /etc/ssl/private

sudo openssl req -x509 -nodes -days 60 -newkey rsa:2048 \
  -keyout /etc/ssl/private/apache-selfsigned.key \
  -out /etc/ssl/certs/apache-selfsigned.crt \
  -subj "/C=PS/ST=Nablus/L=Nablus/O=LinuxTask/CN=localhost"


sudo sed -i '/^#LoadModule rewrite_module/s/^#//' /etc/httpd/conf.modules.d/00-base.conf

sudo bash -c 'cat > /etc/httpd/conf.d/redirect-http.conf <<EOF
<VirtualHost *:80>
    RewriteEngine On
    RewriteCond %{HTTPS} off
    RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
</VirtualHost>
EOF'

sudo bash -c 'cat > /etc/httpd/conf.d/ssl.conf <<EOF
Listen 443 https
<VirtualHost *:443>
    DocumentRoot "/var/www/html"
    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt
    SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
</VirtualHost>
EOF'

sudo systemctl restart httpd
