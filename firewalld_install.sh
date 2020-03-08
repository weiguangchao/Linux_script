#!/bin/bash
need_reboot=""

systemctl disable iptables
systemctl stop iptables
chkconfig iptables off
yum install -y firewalld
systemctl enable firewalld
systemctl start firewalld
systemctl status firewalld

read -p "重启系统: (y)es 是 : (n)0 否: " need_reboot
if [ "$need_reboot" == "y" ] || [ "$need_reboot" == "yes" ]; then
	reboot
fi
