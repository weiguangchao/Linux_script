#!/bin/bash
systemctl disable iptables
systemctl stop iptables
chkconfig iptables off
yum install -y firewalld
systemctl enable firewalld
systemctl start firewalld
systemctl status firewalld
