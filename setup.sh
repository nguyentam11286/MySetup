#!/bin/bash
# Apache License 2.0
# Copyright (c) 2025

#############################################################################################
## SYSTEM CHECKING

echo ""
echo "[Note] Target OS version   >>> Ubuntu 22.04.x (Jammy Jellyfish)"
echo "[Note] Target architecture >>> $(dpkg --print-architecture)"
echo ""
echo "[Note] System Setting:"
echo "[Note] * Hide desktop icon"
echo "[Note] * Set dock icon size"
echo "[Note] * Set dark theme"
echo "[Note] * Disable lock screen"
echo "[Note] * Turn off blank screen"
echo "[Note] * Turn off automatic suspend"
echo "[Note] * Set minimize windows"
echo "[Note] * Change Files sort order"
echo "[Note] * Set VSCode as default for all text files"
echo ""
echo "[Note] System Installation:"
echo "[Note] * net-tools"
echo "[Note] * blueman"
echo "[Note] * tree"
echo "[Note] * gnome-tweaks"
echo "[Note] * gnome-shell-extensions"
echo "[Note] * terminator"
echo "[Note] * python3-pip"
echo "[Note] * python3-transform3d"
echo "[Note] * htop"
echo "[Note] * btop"
echo "[Note] * googler"
echo "[Note] * neofetch"
echo "[Note] * ncdu"
echo "[Note] * i2c-tools"
echo ""
echo "[Note] System Aliases:"
echo "[Note] * acm"
echo "[Note] * usb"
echo "[Note] * i2c"
echo "[Note] * js"
echo "[Note] * Git"
echo ""
echo "PRESS [ENTER] TO CONTINUE"
echo "IF YOU WANT TO CANCEL, PRESS [CTRL] + [C]"
read

#############################################################################################
## SYSTEM SETTING

echo "[System Setting]"

# Hide desktop icons
gsettings set org.gnome.shell.extensions.ding show-home false
gsettings set org.gnome.shell.extensions.ding show-trash false

# Set dock icon size & dark theme
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 26
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# Disable Lock Screen and verify the change
gsettings set org.gnome.desktop.screensaver lock-enabled false
gsettings get org.gnome.desktop.screensaver lock-enabled 

# Power -> Power Saving -> Screen Blank -> Never 
gsettings set org.gnome.desktop.session idle-delay 0
gsettings get org.gnome.desktop.session idle-delay 

# Power -> Suspend -> Automatic Suspend -> Off
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

# Minimize windows and verify the change
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
gsettings get org.gnome.shell.extensions.dash-to-dock click-action

# Change Sort order in Files to Type and verify the change
gsettings set org.gnome.nautilus.preferences default-sort-order 'type'
gsettings get org.gnome.nautilus.preferences default-sort-order 

# Set VSCode as default for all text files 
grep -rH Exec /usr/share/applications/code.desktop
xdg-mime default code.desktop text/plain
xdg-mime query default text/plain
xdg-mime default code.desktop text/x-python
xdg-mime default code.desktop text/x-c++src
xdg-mime default code.desktop application/x-shellscript
xdg-mime default code.desktop application/xml

##############################################################################################
## SYSTEM INSTALLATION

echo "[System Installation]"

sudo apt-get install net-tools -y               # Check IP address
sudo apt-get install blueman -y                 # Bluetooth
sudo apt-get install tree -y
sudo apt-get install gnome-tweaks -y            # Graphical configuration tool 
sudo apt-get install gnome-shell-extensions -y  # Customize the GNOME desktop environment
sudo apt-get install terminator -y        
sudo apt-get install python3-pip -y
sudo apt-get install python3-transform3d -y
sudo apt-get install htop -y                    # Systtem monitor (CPU, RAM, processes)

# https://www.omgubuntu.co.uk/2021/11/best-command-line-tools-ubuntu-linux

sudo snap install btop -y		                    # btop++ (System Monitor)	
sudo apt-get install googler -y	                # googler (Search the Web)
sudo apt-get install neofetch -y 	              # neofetch (System Info)
sudo apt-get install ncdu -y		                # ncdu (Disk Analyser)

sudo apt-get install i2c-tools -y

#############################################################################################
## WORKSPACE SETUP

echo "[Workspace Setup]"

sudo apt-get install wmctrl xdotool
mkdir ~/.config/autostart
cp ~/MySetup/workspace_setup.desktop ~/.config/autostart
sudo chmod +x ~/MySetup/workspace_setup.sh

#############################################################################################
## SYSTEM ALIASES

echo "[System Aliases]"

sh -c "echo \"alias uu='sudo apt-get update && sudo apt-get upgrade -y'\" >> ~/.bashrc"
sh -c "echo \"alias cl='clear'\" >> ~/.bashrc"
sh -c "echo \"alias hn='hostname -I'\" >> ~/.bashrc"

sh -c "echo \"alias gb='gedit ~/.bashrc'\" >> ~/.bashrc"
sh -c "echo \"alias cb='code ~/.bashrc'\" >> ~/.bashrc"
sh -c "echo \"alias sb='source ~/.bashrc'\" >> ~/.bashrc"

sh -c "echo \"alias acm='ls -l /dev | grep ttyACM'\" >> ~/.bashrc"
sh -c "echo \"alias usb='ls -l /dev | grep ttyUSB'\" >> ~/.bashrc"
sh -c "echo \"alias i2c='i2cdetect -r -y 1'\" >> ~/.bashrc"
sh -c "echo \"alias js='ls -l /dev/input/js*'\" >> ~/.bashrc"

sh -c "echo \"alias ga='git add'\" >> ~/.bashrc"
sh -c "echo \"alias gs='git status'\" >> ~/.bashrc"
sh -c "echo \"alias gp='git pull'\" >> ~/.bashrc"

sh -c "echo \"alias gaa='git add .'\" >> ~/.bashrc"
sh -c "echo \"alias gcm='git commit -a -m "Update"'\" >> ~/.bashrc"
sh -c "echo \"alias gph='git push -u origin ubuntu-22.04'\" >> ~/.bashrc"

source ~/.bashrc

#############################################################################################
## APPLICATION INSTALLATION

#source ~/MySetup/app.sh

#############################################################################################
## ROS2 HUMBLE INSTALLATION

#source ~/MySetup/ros2.sh

#############################################################################################

echo "[Complete!!!]"
exit 0



