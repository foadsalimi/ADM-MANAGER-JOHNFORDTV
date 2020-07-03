#!/bin/bash
declare -A cor=( [0]="\033[1;37m" [1]="\033[1;34m" [2]="\033[1;35m" [3]="\033[1;32m" [4]="\033[1;31m" [5]="\033[1;33m" [6]="\E[44;1;37m" [7]="\E[41;1;37m" )
barra="\033[0m\e[31m======================================================\033[1;37m"
fun_bar () {
comando="$1"
 _=$(
$comando > /dev/null 2>&1
) & > /dev/null
pid=$!
while [[ -d /proc/$pid ]]; do
echo -ne " \033[1;33m["
   for((i=0; i<10; i++)); do
   echo -ne "\033[1;31m##"
   sleep 0.2
   done
echo -ne "\033[1;33m]"
sleep 1s
echo
tput cuu1 && tput dl1
done
echo -e " \033[1;33m[\033[1;31m####################\033[1;33m] - \033[1;32m100%\033[0m"
sleep 1s
}
pamcrack () {
echo -e "${cor[5]}RELEASING PASSWD FOR VURTL"
sed -i 's/.*pam_cracklib.so.*/password sufficient pam_unix.so sha512 shadow nullok try_first_pass #use_authtok/' /etc/pam.d/common-password
echo -e "${cor[5]}READY YOU CAN CREATE USERS"
}

shadow_fun () {
echo -e " ${cor[7]}ROOT VURTL PERMIT ${cor[6]}[ALEX_DROID9_0_MX]\033[0m"
echo -e "$barra"
while true; do
echo -e "${cor[4]} [1] > ${cor[5]}UNLOCK VURTL TO CREATE USERS"
echo -e "${cor[4]} [2] > ${cor[0]}RETURN"
echo -e "${cor[4]} [0] > ${cor[0]}LEAVE\n${barra}"
while [[ ${opx} != @(0|[1-2]) ]]; do
echo -ne "${cor[0]}Type an Option: \033[1;37m" && read opx
tput cuu1 && tput dl1
done
case $opx in
	0)
	exit;;
	1)
	pamcrack
	break;;
	2)
	menu;;
  
esac
done
}
shadow_fun
