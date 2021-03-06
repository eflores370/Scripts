#!/bin/sh

echo "Setting up IPTables"

iptables-save > /etc/iptables.conf
iptables -F
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -p tcp -m state --state ESTABLISHED,NEW --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp -m state --state ESTABLISHED --sport 22 -j ACCEPT
iptables -A INPUT -p tcp -m multiport --dports 80,443 -j ACCEPT
iptables -A OUTPUT -p tcp -m multiport --sports 80,443 -j ACCEPT
iptables --policy FORWARD DROP
iptables --policy INPUT DROP
iptables --policy OUTPUT DROP
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --sport 53 -j ACCEPT

#iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
#iptables -A INPUT -p udp --sport 53 -j ACCEPT

#iptables -A OUTPUT -p tcp -m multiport --dport 80 -j ACCEPT
#iptables -A INPUT -p tcp -m multiport --sport 80 -j ACCEPT

echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
sysctl -p

echo "Firewall Setup Completed"