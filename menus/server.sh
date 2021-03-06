#!/bin/bash

FUNCTION="Maintain Server"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh
clear

# ------------
# Menu Options
# ------------

# Update Server
SERVER(){
  /opt/GooPlex/install/server/vpsupdate.sh
}

# Update Server
PATCHES(){
  /opt/GooPlex/install/server/vpspatches.sh
}

# Exit
QUIT(){
  exit
}

# ------------
# Display menu
# ------------

show_menus() {
  clear
  echo -e " ${YELLOW}"
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " G O O P L E X - Visit techperplexed.ga "
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " $FUNCTION "
  echo -e " ${STD}"
  echo -e " ${YELLOW}A${STD} - Initialize Server"
  echo -e " ${YELLOW}B${STD} - Run Server Update"
  echo -e " ${WHITE}Z${STD} - EXIT to Main Menu"
  echo -e " ${YELLOW}"
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e " ${STD}"
}

# ------------
# Read Choices
# ------------

read_options(){
  local choice
    read -p "Choose option: " choice
    case $choice in
      [Aa]) SERVER ;;
      [Bb]) PATCHES ;;
      [Zz]) QUIT ;;
      *) echo -e "${LRED}Please select a valid option${STD}" && sleep 2
    esac
}
 
# ----------
# Finalizing
# ----------

trap '' SIGINT SIGQUIT SIGTSTP

while true
do 
  show_menus
  read_options
done
