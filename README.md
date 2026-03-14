# Frappe Full Stack v16
ERPNext + CRM + HR + Insights on Ubuntu 24.04 WSL

## Requirements
- Ubuntu 24.04 WSL
- Python 3.14
- Node 24
- MariaDB 10.11

## Quick Setup
```bash
git clone https://github.com/atul2501/erpnextv16.git
cd erpnextv16
./setup.sh
```

## Create Site
```bash
cd ~/frappe-bench
bench new-site mysite.local --db-root-username frappe --db-root-password frappe --admin-password admin
bench --site mysite.local install-app erpnext crm hrms insights
bench start
```

## Login
URL: http://localhost:8002
User: Administrator
Pass: admin



# when new start 
'''
sudo systemctl start mariadb
sudo systemctl start redis-server
cd ~/frappe-bench
bench start
''
