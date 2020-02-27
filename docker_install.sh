#!/bin/bash
need_add=""

echo "1. 卸载自带docker"
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-engine

echo "2. 安装相关依赖"
sudo yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

echo "3. 设置stable仓库"
sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

echo "4. 安装docker ce版本"
sudo yum install docker-ce docker-ce-cli containerd.io -y


echo "5. 启动docker"
sudo systemctl start docker

echo "6. 设置docker开机启动"
sudo systemctl enable docker

read -p "是否需要将当前用户添加到docker用户组: (y)es 是 : (n)0 否: " need_add
if [ "$need_add" == "y" ] || [ "$need_add" == "yes" ]
then
	sudo gpasswd -a ${USER} docker
	echo "将 ${USER} 添加到 docker 用户组"
fi

echo "7. 安装docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "8. 安装完成"
docker version
docker-compose version