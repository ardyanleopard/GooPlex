#!/bin/bash

FUNCTION="install or update Rclone"

# ---------
# Variables
# ---------

source /opt/GooPlex/menus/variables.sh

# Confirmation

clear
read -p "Are you sure you want to $FUNCTION (y/N)? " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]
then

# -----------
# Main script
# -----------

# Explanation

clear
echo -e "Creating the user to do all ${CYAN}daily tasks${STD}"
echo ""

# Execution

cd /tmp

read -e -p "Release (R) or Beta installation (B)? " -i "R" choice

case "$choice" in 
  b|B ) curl https://rclone.org/install.sh | sudo bash -s beta ;;
  * ) curl https://rclone.org/install.sh | sudo bash ;;
esac

cd ~
clear

if [ -e "/home/plexuser/.config/rclone/rclone.conf" ]

then
  echo "Rclone already configured, skipping"
else
  echo "Please follow the instructions to setup Rclone"
  echo ""
  sudo rclone config
fi

# ----------
# Finalizing
# ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE