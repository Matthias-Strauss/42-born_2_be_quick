#!/bin/bash
#   ___  ____  ____  ____  ____  ___  _  _ 
#  / _ \(___ \(  __)(  __)(_  _)/ __)/ )( \
# (__  ( / __/ ) _)  ) _)   )( ( (__ ) __ (
#   (__/(____)(__)  (____) (__) \___)\_)(_/.by mstrauss

    # COLORS
    COLOR_TITLE="\e[1;34m"  # Blue for titles
    COLOR_INFO="\e[0;37m"   # Light gray for information
    COLOR_RESET="\e[0m"     # Reset color to default
    
    # ASCII ART
    logo="
____________/${COLOR_TITLE}\\\\\\${COLOR_RESET}_______/${COLOR_TITLE}\\\\\\\\\\\\\\\\\\${COLOR_RESET}_____        
 __________/${COLOR_TITLE}\\\\\\\\\\${COLOR_RESET}_____/${COLOR_TITLE}\\\\\\${COLOR_RESET}///////${COLOR_TITLE}\\\\\\${COLOR_RESET}___       
  ________/${COLOR_TITLE}\\\\\\${COLOR_RESET}/${COLOR_TITLE}\\\\\\${COLOR_RESET}____${COLOR_TITLE}\\${COLOR_RESET}///______${COLOR_TITLE}\\${COLOR_RESET}//${COLOR_TITLE}\\\\\\${COLOR_RESET}__      
   ______/${COLOR_TITLE}\\\\\\${COLOR_RESET}/${COLOR_TITLE}\\${COLOR_RESET}/${COLOR_TITLE}\\\\\\${COLOR_RESET}______________/${COLOR_TITLE}\\\\\\${COLOR_RESET}/___     
    ____/${COLOR_TITLE}\\\\\\${COLOR_RESET}/__${COLOR_TITLE}\\${COLOR_RESET}/${COLOR_TITLE}\\\\\\${COLOR_RESET}___________/${COLOR_TITLE}\\\\\\${COLOR_RESET}//_____    
     __/${COLOR_TITLE}\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\${COLOR_RESET}_____/${COLOR_TITLE}\\\\\\${COLOR_RESET}//________   
      _${COLOR_TITLE}\\${COLOR_RESET}///////////${COLOR_TITLE}\\\\\\${COLOR_RESET}//____/${COLOR_TITLE}\\\\\\${COLOR_RESET}/___________  
       ___________${COLOR_TITLE}\\${COLOR_RESET}/${COLOR_TITLE}\\\\\\${COLOR_RESET}_____/${COLOR_TITLE}\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\${COLOR_RESET}_ 
        ___________${COLOR_TITLE}\\${COLOR_RESET}///_____${COLOR_TITLE}\\${COLOR_RESET}///////////////__
"

    logo2="
${COLOR_TITLE}
        ,--,               
      ,--.'|      ,----,   
   ,--,  | :    .'   .' \  
,---.'|  : '  ,----,'    | 
;   : |  | ;  |    :  .  ; 
|   | : _' |  ;    |.'  /  
:   : |.'  |  \`----'/  ;   
|   ' '  ; :    /  ;  /    
\   \  .'. |   ;  /  /-,   
 \`---\`:  | '  /  /  /.\`|   
      '  ; |./__;      :   
      |  : ;|   :    .'    
      '  ,/ ;   | .'       
      '--'  \`---'                          
${COLOR_RESET}"

    logo3="
             @@@@@@@    (@@@@@ .@@@@@@@
          @@@@@@@       (@@    .@@@@@@@
        @@@@@@@         (      .@@@@@@@
     @@@@@@@                 @@@@@@@   
   @@@@@@@                 @@@@@@@     
@@@@@@@@@@@@@@@@@@@@@*  (@@@@@@@      (
@@@@@@@@@@@@@@@@@@@@@*  (@@@@@@@    @@@
@@@@@@@@@@@@@@@@@@@@@*  (@@@@@@@  @@@@@
              @@@@@@@*                 
              @@@@@@@*                 
              @@@@@@@*                 
"

    logo4="
        :::      ::::::::
      :+:      :+:    :+:
    +:+ +:+         +:+  
  +#+  +:+       +#+     
+#+#+#+#+#+   +#+        
     #+#    #+#          
    ###   ########.      
"

content='
System Information at $(date)
Operating System & Kernel Version: $(uname -a)
Physical Processors: $(lscpu | grep '\''Socket(s):'\'' | awk '\''{print $2}'\'')
Virtual Processors: $(lscpu | grep '\''CPU(s):'\'' | head -1 | awk '\''{print $2}'\'')
Available RAM & Utilization: $(free -h | awk '\''/^Mem/ {print $4 "/" $2 " (" int($3/$2*100) "%)"}'\'')
Available Memory & Utilization: $(free -h | awk '\''/^Swap/ {print $4 "/" $2 " (" int($3/$2*100) "%)"}'\'')
Processor Utilization: $(top -bn1 | grep '\''%Cpu'\'' | awk '\''{print $2 + $4}'\'')%
Last Reboot: $(who -b | awk '\''{print $3, $4}'\'')
LVM Status: $(sudo lvdisplay > /dev/null 2>&1 && echo -e Active || echo -e Inactive)
Active Connections: $(netstat -an | grep -c ESTABLISHED)
Users Logged In: $(who | wc -l)
IPv4 Address: $(hostname -I | awk '\''{print $1}'\'')
MAC Address: $(ip link | awk '\''/ether/ {print $2;exit}'\'')
Sudo Commands Executed: $(cat /var/log/auth.log* | grep -c '\''COMMAND=.*sudo'\'')
'


    # # Clear console
    # clear

    # # Calculate content length for box sizing
    # content_length=$(echo "${content}" | wc -L)

    # # Determine the number of lines in ASCII art
    # ascii_lines=$(echo -n "${logo3}" | wc -l)

    # # Print ASCII art and content with the box outline
    # for ((i = 1; i <= $ascii_lines; i++)); do
    #     printf '%s' "$(echo "${logo3}" | sed -n "${i}p")"
    #     printf '%*s' $((content_length + 5 - ${#logo3})) "$(echo "${content}" | sed -n "${i}p")"
    #     printf '\n'
    # done





    # # Print ASCII art and content in a formatted way
    # printf '%s%*s\n' "${logo}" $((content_length + 5 - ${#logo})) "${content}"

    # # Print the top of the box
    # printf '╔═%.0s' $(seq 1 "${content_length}")
    # printf '╗\n'

    # # Print the content inside the box
    # echo "║${content}║"

    # # Print the bottom of the box
    # printf '╚═%.0s' $(seq 1 "${content_length}")
    # printf '╝\n'