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

  # ----------
  # Open ports
  # ----------

  # None

  # ------------
  # Dependencies
  # ------------

  sudo apt-get upgrade -y && sudo apt-get upgrade -y
  
  # ------------------
  # Create directories
  # ------------------
  
  mkdir -p /home/plexuser/logs
  mkdir -p /home/plexuser/uploads
  sudo chown plexuser:plexuser -R /home/plexuser

  # -----------
  # Main script
  # -----------

  cd /tmp

  read -e -p "Release (R) or Beta installation (B)? " -i "R" choice

  case "$choice" in 
    b|B ) curl https://rclone.org/install.sh | sudo bash -s beta ;;
    * ) curl https://rclone.org/install.sh | sudo bash ;;
  esac

  cd ~
  clear

  if [ ! -e "/home/plexuser/.config/rclone/rclone.conf" ]
  then

    echo "Please follow the instructions to setup Rclone"
    echo ""
    sudo rclone config

  fi

  # -------------------
  # Installing Services
  # -------------------

  if [ ! -e "/etc/systemd/system/rclone.service" ]
  then

    sudo rsync -a /opt/GooPlex/scripts/rclone.service /etc/systemd/system/rclone.service
    sudo systemctl enable rclone.service
    sudo systemctl daemon-reload
    sudo systemctl start rclone.service

  fi

  # ----------
  # Finalizing
  # ----------

else

  echo -e "You chose ${YELLOW}not${STD} to $FUNCTION"

fi

PAUSE
