#!/bin/bash
apt update -y
apt install -y nginx apache2-utils git

# Clone the repo
git clone https://github.com/yourusername/your-repo.git /var/www/html

# Set up basic authentication
echo -n 'admin:' > /etc/nginx/.htpasswd
openssl passwd -apr1 >> /etc/nginx/.htpasswd

# Configure Nginx to serve the index.html with password protection
cat <<EOF > /etc/nginx/sites-available/default
server {
    listen 80;
    root /var/www/html;
    index index.html;
    
    location / {
        auth_basic "Restricted Content";
        auth_basic_user_file /etc/nginx/.htpasswd;
    }
}
EOF

# Restart Nginx
systemctl restart nginx
