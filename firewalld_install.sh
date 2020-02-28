#!/bin/bash
yum install -y firewalld
systemctl enable firewalld
systemctl start firewalld
systemctl disable iptables
systemctl stop iptables
yum remove iptables -y