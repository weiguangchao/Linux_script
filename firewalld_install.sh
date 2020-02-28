#!/bin/bash
systemctl disable iptables
systemctl stop iptables
yum remove iptables -y
yum install -y firewalld
systemctl start firewalld
systemctl enable firewalld
systemctl status firewalld