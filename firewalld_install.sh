#!/bin/bash
yum install -y firewalld
systemctl disable iptables
systemctl stop iptables
yum remove iptables -y
systemctl enable firewalld
systemctl start firewalld
systemctl status firewalld