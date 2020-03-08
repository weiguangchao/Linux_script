#!/bin/bash
user_home=~

# cf配置信息
dns_cloudflare_email=$email
dns_cloudflare_api_key=$api_key

# 证书配置信息
credentials_dir="${user_home}/.secrets/certbot"
credentials_file="${credentials_dir}/cloudflare.ini"

# 安装依赖
installDependencies() {
	sudo yum install epel-release -y
	sudo yum -y install yum-utils
	sudo yum-config-manager --enable rhui-REGION-rhel-server-extras rhui-REGION-rhel-server-optional
	sudo yum install certbot -y
	sudo yum install python2-certbot-dns-cloudflare -y
}

_certbot="certbot certonly --dns-cloudflare --dns-cloudflare-credentials ~/.secrets/certbot/cloudflare.ini"
_certbot_renew="echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew -q" | sudo tee -a /etc/crontab > /dev/null"

# 输出cf配置到文件
outPutToCredentialsFile() {
	mkdir -p $credentials_dir
	touch $credentials_file
	cat >$credentials_file <<EOF
dns_cloudflare_email=${dns_cloudflare_email}
dns_cloudflare_api_key=${dns_cloudflare_api_key}
EOF
}

# 生成证书，并自动续期
gernerateCredentials() {
	for i in $@; do
		_certbot="${_certbot} -d $i"
	done
	$_certbot
	$_certbot_renew
}

# 判断域名是否存在
if [ $# == 0 ]; then
	echo "please input your domain"
	exit 1
fi

if [ -f "$credentials_file" ]; then
	gernerateCredentials
else
	# 检查email, api_key
	if [ -z "$dns_cloudflare_email" ] || [ -z "${dns_cloudflare_api_key}" ]; then
		echo "please export email or api_key"
		exit 1
	fi
	installDependencies
	outPutToCredentialsFile
	gernerateCredentials
fi