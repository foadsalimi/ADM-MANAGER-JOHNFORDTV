#!/bin/bash
Block="/etc/bin" && [[ ! -d ${Block} ]] && exit
Block > /dev/null 2>&1
cowsay -f eyes "this tool creates the SSH PLUS panel to manage your vps" | lolcat 
figlet ..johndesu090.. | lolcat
sleep 4
clear
IP=$(wget -qO- ipv4.icanhazip.com)
echo "Asia/Manila" > /etc/timezone
ln -fs /usr/share/zoneinfo/Asia/Manila /etc/localtime > /dev/null 2>&1
 > /dev/null 2>&1
clear
sudo dpkg-reconfigure --frontend noninteractive tzdata
echo -e "\E[44;1;37m           PANEL SSHPLUS v10           \E[0m"
echo ""
echo -e "                \033[1;31mATTENTION"
echo ""
echo -e "\033[1;32mFOR EVERYTHING ALWAYS USE THE SAME PASSWORD"
echo ""
echo -e "\033[1;32mALWAYS CONFIRM QUESTIONS WITH\033[1;37m Y"
echo ""
echo -e "\033[1;36mSTARTING INSTALLATION"
echo ""
echo -e "\033[1;33mWAIT..."
apt-get update > /dev/null 2>&1
echo ""
echo -e "\033[1;36mAPACHE2 INSTALLATION\033[0m"
echo ""
echo -e "\033[1;33mWAIT..."
apt-get install apache2 -y > /dev/null 2>&1
apt-get install cron curl unzip -y > /dev/null 2>&1
echo ""
echo -e "\033[1;36mINSTALLING NECESSARY PACKAGES\033[0m"
echo ""
echo -e "\033[1;33mWAIT..."
apt-get install php5 libapache2-mod-php5 php5-mcrypt -y > /dev/null 2>&1
service apache2 restart 
echo ""
echo -e "\033[1;36mINSTALLATION OF MySQL\033[0m"
echo ""
sleep 1
apt-get install mysql-server -y 
echo ""
clear
echo -e "                \033[1;31mATTENTION"
echo ""
echo -e "\033[1;32mALWAYS USE THE SAME PASSWORD EACH REQUEST"
echo -e "\033[1;32mCONFIRM ALL QUESTIONS ALWAYS USING \033[1;37m Y"
echo ""
echo -ne "\033[1;33mEnter, To Continue!\033[1;37m"; read
mysql_install_db
mysql_secure_installation
clear
echo -e "\033[1;36mINSTALLATION OF PHPMYADMIN\033[0m"
echo ""
echo -e "\033[1;31mATTENTION \033[1;33m!!!"
echo ""
echo -e "\033[1;32mSELECT THE OPTION \033[1;31mAPACHE2 \033[1;32mWITH THE KEY '\033[1;33mENTER\033[1;32m'"
echo ""
echo -e "\033[1;32mSELECT \033[1;31mYES\033[1;32m IN THE NEXT OPTION (\033[1;36mdbconfig-common\033[1;32m)"
echo -e "TO CONFIGURE THE DATABASE"
echo ""
echo -e "\033[1;32mREMEMBER TO ALWAYS USE THE SAME PASSWORD WHEN REQUESTED"
echo ""
echo -ne "\033[1;33mEnter, To Continue!\033[1;37m"; read
apt-get install phpmyadmin -y
php5enmod mcrypt
service apache2 restart
ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
apt-get install libssh2-1-dev libssh2-php -y > /dev/null 2>&1
apt-get install php5-curl > /dev/null 2>&1
service apache2 restart
clear
echo ""
echo -e "\033[1;31mATTENTION \033[1;33m!!!"
echo ""
echo -ne "\033[1;32mENTER THE SAME PASSWORD\033[1;37m: "; read senha
echo -e "\033[1;32mOK\033[1;37m"
sleep 1
mysql -h localhost -u root -p$senha -e "CREATE DATABASE plus"
clear
echo -e "\033[1;36mFINISHING INSTALLATION\033[0m"
echo ""
echo -e "\033[1;33mWAIT..."
echo ""
cd /var/www/html
wget https://raw.githubusercontent.com/johndesu090/ADM-MANAGER-JOHNFORDTV/master/Herramientas/panel10/painel10.zip > /dev/null 2>&1
sleep 1
unzip painel10.zip > /dev/null 2>&1
rm -rf painel10.zip index.html > /dev/null 2>&1
service apache2 restart
sleep 1
if [[ -e "/var/www/html/pages/system/pass.php" ]]; then
sed -i "s;suasenha;$senha;g" /var/www/html/pages/system/pass.php > /dev/null 2>&1
fi
sleep 1
cd
wget https://raw.githubusercontent.com/johndesu090/ADM-MANAGER-JOHNFORDTV/master/Herramientas/panel10/plus.sql > /dev/null 2>&1
sleep 1
if [[ -e "$HOME/plus.sql" ]]; then
    mysql -h localhost -u root -p$senha --default_character_set utf8 plus < plus.sql
    rm /root/plus.sql
else
    clear
    echo -e "\033[1;31mERROR WHEN IMPORTING DATABASE\033[0m"
    sleep 2
    exit
fi
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.php' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.ssh.php ' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.sms.php' >> /etc/crontab
echo '* * * * * root /usr/bin/php /var/www/html/pages/system/cron.online.ssh.php' >> /etc/crontab
echo '10 * * * * root /usr/bin/php /var/www/html/pages/system/cron.servidor.php' >> /etc/crontab
/etc/init.d/cron reload > /dev/null 2>&1
/etc/init.d/cron restart > /dev/null 2>&1
chmod 777 /var/www/html/admin/pages/servidor/ovpn
chmod 777 /var/www/html/admin/pages/download
chmod 777 /var/www/html/admin/pages/faturas/comprovantes
service apache2 restart
sleep 1
clear
echo -e "\033[1;32mPANEL INSTALLED SUCCESSFUL!"
echo ""
echo -e "\033[1;36mLINK TO THE ADMINISTRATOR AREA:\033[1;37m $IP:81/html/admin\033[0m"
echo -e "\033[1;36mLINK TO THE RESELLER AREA: \033[1;37m $IP:81/html\033[0m"
echo -e "\033[1;36mUSER\033[1;37m admin\033[0m"
echo -e "\033[1;36mPASSWORD\033[1;37m admin\033[0m"
echo ""
echo -e "\033[1;31mATTENTION \033[1;33m!!!"
echo ""
echo -e "\033[1;33mWhen creating a server you need to install this command:\033[0m"
echo -e "\033[1;33mwget https://raw.githubusercontent.com/johndesu090/ADM-MANAGER-JOHNFORDTV/master/Herramientas/panel10/inst > /dev/null 2>&1; bash inst\033[0m"
echo -e "\033[1;33min the vps that will become a server\033[0m"
echo -e "\033[1;31mNOTE: \033[1;33m!!!"
echo ""
echo -e "\033[1;33mChange password when logging in to panel\033[0m"
cat /dev/null > ~/.bash_history && history -c
