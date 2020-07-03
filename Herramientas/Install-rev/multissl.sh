#!/bin/bash
echo -e "\e[1;33mNEWADM SSL PORT REDIRECTOR\e[0m"
echo -e "\e[1;41mEnter Name To Redirect SSL Port\e[0m"
echo -e "\e[1;36m(example) shadowsocks,dropbear,sshd,python,obfc,openvpn\e[0m"
read -p ": " nombressl
echo -e "\e[1;33mEnter the port of the Service to bind\e[0m"
echo -e "\e[1;36m(example) 22,443,445,110,1114\e[0m"
read -p ": " portserv
echo -e "\e[1;33mEnter the New SSL Port\e[0m"
echo -e "\e[1;36m(example)442,445,447,448,446,521,522\e[0m"
read -p ": " portssl
if lsof -Pi :$portssl -sTCP:LISTEN -t >/dev/null ; then
    echo -e "\e[1;41mThis port is already in use\e[0m"
else
echo "[$nombressl] " >> /etc/stunnel/stunnel.conf
echo "cert = /etc/stunnel/stunnel.pem " >> /etc/stunnel/stunnel.conf 
echo "accept = $portssl " >> /etc/stunnel/stunnel.conf 
echo "connect = 127.0.0.1:$portserv" >> /etc/stunnel/stunnel.conf 
sleep 5
echo -e "\e[1;33mRestarting Service : Stunnel4\e[0m"
service stunnel4 restart 1> /dev/null 2> /dev/null
fi
