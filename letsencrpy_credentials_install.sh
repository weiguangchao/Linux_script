#!/bin/bash
user_hoem=~

dns_cloudflare_email=""
dns_cloudflare_api_key=""

credentials_location="${user_hoem}/.secrets/certbot/cloudflare.ini"
credentials_path=${credentials_location%/*}
credentials_content=""

domain=""

echo "1. 开启EPEL repo"
sudo yum install epel-release -y

echo "2. 开启optional channel"
sudo yum -y install yum-utils
sudo yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional

echo "3. 安装Certbot"
sudo yum install certbot python2-certbot-nginx -y

echo "4. 安装DNS plugin"
sudo yum install python2-certbot-dns-cloudflare -y

echo "5. 设置credentials"
read -p "请输入 domain: " domain
read -p "请输入 dns_cloudflare_email: " dns_cloudflare_email
read -p "请输入 dns_cloudflare_api_key: " dns_cloudflare_api_key
credentials_content="dns_cloudflare_email = ${dns_cloudflare_email}\ndns_cloudflare_api_key = ${dns_cloudflare_api_key}"
mkdir -p $credentials_path
echo -e $credentials_content >$credentials_location
sudo certbot certonly \
--dns-cloudflare \
--dns-cloudflare-credentials ${credentials_location} \
-d ${domain} \
-d "www.${domain}" \
-i nginx
echo "6. 设置自动续期"
echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew" | sudo tee -a /etc/crontab >/dev/null
