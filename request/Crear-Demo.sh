#!/bin/bash
Block="/etc/bin" && [[ ! -d ${Block} ]] && exit
Block > /dev/null 2>&1
rm -rf /etc/adm
mkdir /etc/adm
mkdir /etc/adm/usuarios

msg () {
BRAN='\033[1;37m' && VERMELHO='\e[31m'
VERDE='\e[32m' && AMARELO='\e[33m'
AZUL='\e[34m' && MAGENTA='\e[35m'
MAG='\033[1;36m' && NEGRITO='\e[1m'
SEMCOR='\e[0m'
 case $1 in
  -ne)cor="${VERMELHO}${NEGRITO}" && echo -ne "${cor}${2}${SEMCOR}";;
  -ama)cor="${AMARELO}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verm)cor="${AMARELO}${NEGRITO}[!] ${VERMELHO}" && echo -e "${cor}${2}${SEMCOR}";;
  -azu)cor="${MAG}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -verd)cor="${VERDE}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  -bra)cor="${BRAN}${NEGRITO}" && echo -e "${cor}${2}${SEMCOR}";;
  "-bar2"|"-bar")cor="${AZUL}======================================================" && echo -e "${SEMCOR}${cor}${SEMCOR}";;
 esac
}
tmpusr () {
time="$1"
timer=$(( $time * 60 ))
timer2="'$timer's"
echo "#!/bin/bash
sleep $timer2
kill"' $(ps -u '"$2 |awk '{print"' $1'"}') 1> /dev/null 2> /dev/null
userdel --force $2
rm -rf /tmp/$2
exit" > /tmp/$2
}

tmpusr2 () {
time="$1"
timer=$(( $time * 60 ))
timer2="'$timer's"
echo "#!/bin/bash
sleep $timer2
kill=$(dropb | grep "$2" | awk '{print $2}')
kill $kill
userdel --force $2
rm -rf /tmp/$2
exit" > /tmp/$2
}

echo -e "\033[1;96m   CREATE USER BY TIME (Minutes)\n\033[1;97mUsers that you create in this extension will be deleted \ automatically after the designated time\033[0m"
msg -bar2

echo -e "\033[1;91m[1]-\033[1;97mUser name:\033[0;37m"; read -p " " name
if [[ -z $name ]]
then
echo "The New User has not entered"
exit
fi
if cat /etc/passwd |grep $name: |grep -vi [a-z]$name |grep -v [0-9]$name > /dev/null
then
echo -e "\033[1;31mUser $name already exists\033[0m"
exit
fi
echo -e "\033[1;91m[2]-\033[1;97mUser password $name:\033[0;37m"; read -p " " pass
echo -e "\033[1;91m[3]-\033[1;97mDuration Time In Minutes:\033[0;37m"; read -p " " tmp
if [ "$tmp" = "" ]; then
tmp="30"
echo -e "\033[1;32mIt was defined 30 minutes by default!\033[0m"
msg -bar2
sleep 2s
fi
useradd -M -s /bin/false $name
(echo $pass; echo $pass)|passwd $name 2>/dev/null
touch /tmp/$name
tmpusr $tmp $name
chmod 777 /tmp/$name
touch /tmp/cmd
chmod 777 /tmp/cmd
echo "nohup /tmp/$name & >/dev/null" > /tmp/cmd
/tmp/cmd 2>/dev/null 1>/dev/null
rm -rf /tmp/cmd
touch /etc/adm/usuarios/$name
echo "password: $pass" >> /etc/adm/usuarios/$name
echo "data: ($tmp)Minutes" >> /etc/adm/usuarios/$name
msg -bar2
echo -e "\033[1;93m     ¡¡User Created!!\033[0m"
msg -bar2
echo -e "\033[1;36mUser: \033[0m$name"
echo -e "\033[1;36mPassword: \033[0m$pass"
echo -e "\033[1;36mDuration Minutes: \033[0m$tmp"
msg -bar2
exit
fi
