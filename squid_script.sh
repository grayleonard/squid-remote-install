#!/bin/bash \n' +
USER=(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 6 | head -n 1)
PASS=$(cat /dev/urandom | env LC_CTYPE=C tr -dc 'a-zA-Z0-9' | fold -w 6 | head -n 1)

yum install squid wget httpd-tools -y &&
touch /etc/squid/passwd &&
htpasswd -b /etc/squid/passwd ${USER} ${PASS} &&
wget -O /etc/squid/squid.conf https://raw.githubusercontent.com/grayleonard/squid-remote-install/master/squid.conf --no-check-certificate &&
touch /etc/squid/blacklist.acl &&
systemctl restart squid.service && systemctl enable squid.service
echo ${USER}:${PASS}