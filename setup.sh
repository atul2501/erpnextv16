#!/bin/bash
set -e
echo "=== Frappe v16 Full Stack Setup ==="

# Install dependencies
sudo apt update && sudo apt upgrade -y
sudo apt install -y git curl wget python3.14 python3.14-dev python3.14-venv \
  mariadb-server mariadb-client redis-server \
  libmariadb-dev pkg-config wkhtmltopdf xvfb

# Node 24
sudo npm install -g n && sudo n 24 && hash -r
sudo npm install -g yarn

# Bench
sudo pip3 install frappe-bench --break-system-packages

# MariaDB config
sudo tee /etc/mysql/mariadb.conf.d/99-frappe.cnf << 'DBEOF'
[mysqld]
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci
[mysql]
default-character-set = utf8mb4
DBEOF
sudo systemctl restart mariadb

echo "=== Init bench ==="
bench init --frappe-branch version-16 --python python3.14 ~/frappe-bench
cd ~/frappe-bench

echo "=== Get apps ==="
bench get-app --branch version-16 erpnext
bench get-app crm https://github.com/frappe/crm
bench get-app --branch version-16 hrms
bench get-app insights https://github.com/frappe/insights

echo "=== Done! Now run: ==="
echo "bench new-site mysite.local --db-root-username frappe --db-root-password frappe --admin-password admin"
echo "bench --site mysite.local install-app erpnext crm hrms insights"
echo "bench start"
