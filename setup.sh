#!/bin/bash
# Apache License 2.0
# Copyright (c) 2025

##########################################################################################
## SYSTEM CHECKING

version=`lsb_release -sc`
relesenum=`grep DISTRIB_DESCRIPTION /etc/*-release \
           | awk -F 'Ubuntu ' '{print $2}' | awk -F ' LTS' '{print $1}'`
arch=`dpkg --print-architecture`

echo ""
echo "[Note] System checking ..."
echo ">>> Your Ubuntu version: Ubuntu $version $relesenum"
echo ">>> Your architecture: $arch"

##########################################################################################
## NOTES

system_setup_note() {
    cat <<EOF 
[Note] System Setup:
[Note] * Hide desktop icon
[Note] * Set dock icon size
[Note] * Set dark theme
[Note] * Disable lock screen
[Note] * Turn off blank screen
[Note] * Turn off automatic suspend
[Note] * Set minimize windows
[Note] * Change Files sort order
[Note] * Set VSCode as default for all text files
EOF
}
system_install_note() {
    cat <<EOF 
[Note] System Installation:
[Note] * curl wget unzip vim nano
[Note] * build-essential 
[Note] * cmake
[Note] * git
[Note] * net-tools
[Note] * blueman
[Note] * htop
[Note] * tree
[Note] * bat
[Note] * gnome-tweaks
[Note] * gnome-shell-extensions
[Note] * terminator
[Note] * tmux
[Note] * openssh-server
[Note] * python3-*
[Note] * jupyterlab
[Note] * btop
[Note] * googler
[Note] * neofetch
[Note] * ncdu
[Note] * minicom screen
[Note] * i2c-tools
[Note] * v4l-utils 
[Note] * udev
EOF
}
workspace_setup_note() {
    cat <<EOF 
[Note] Initial Workspace Setup:
[Note] * Workspace 1: Visual Studio Code
[Note] * Workspace 2: Files & Terminator
EOF
}
system_alias_note() {
    cat <<EOF 
[Note] System Aliases:
[Note] * acm
[Note] * usb
[Note] * i2c
[Note] * js
[Note] * git
EOF
}
app_install_note() {
    cat <<EOF 
[Note] Application Installation:
[Note] * arduino
[Note] * energia
[Note] * vscode
[Note] * eclipse
[Note] * librecad
[Note] * blender
[Note] * meshlab
[Note] * nomachine
EOF
}
ros_install_note() {
    cat <<EOF 
[Note] ROS Installation:
[Note] * ROS 2 Jazzy - Ubuntu Noble 24.04
EOF
}
ask_and_run() {
  $1  # run the note function
  #echo
  read -p "Run this section? [y/N]: " confirm
  if [[ "$confirm" =~ ^[Yy]$ ]]; then
    "$2"
  else
    echo ">>> Skipped!"
  fi
}

##########################################################################################
## SYSTEM SETUP

system_setup() 
{
  echo "<<< Processing ..."

  # Hide desktop icons
  gsettings set org.gnome.shell.extensions.ding show-home false
  gsettings set org.gnome.shell.extensions.ding show-trash false

  # Set dock icon size & dark theme
  gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 26
  gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

  # Disable Lock Screen and verify the change
  gsettings set org.gnome.desktop.screensaver lock-enabled false
  #gsettings get org.gnome.desktop.screensaver lock-enabled 

  # Power -> Power Saving -> Screen Blank -> Never 
  gsettings set org.gnome.desktop.session idle-delay 0
  #gsettings get org.gnome.desktop.session idle-delay 

  # Power -> Suspend -> Automatic Suspend -> Off
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing' 
  gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

  # Minimize windows and verify the change
  gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'
  #gsettings get org.gnome.shell.extensions.dash-to-dock click-action

  # Change Sort order in Files to Type and verify the change
  gsettings set org.gnome.nautilus.preferences default-sort-order 'type'
  #gsettings get org.gnome.nautilus.preferences default-sort-order 

  # Set VSCode as default for all text files 
  #grep -rH Exec /usr/share/applications/code.desktop
  #xdg-mime query default text/plain
  xdg-mime default code.desktop text/plain
  xdg-mime default code.desktop text/x-python
  xdg-mime default code.desktop text/x-c++src
  xdg-mime default code.desktop application/x-shellscript
  xdg-mime default code.desktop application/xml

  echo ">>> Completed!"
}
ask_and_run system_setup_note system_setup

############################################################################################ SYSTEM INSTALLATION

system_install() 
{
  echo "<<< Processing ..."

  sudo apt-get install curl wget unzip vim nano   # System essentials
  sudo apt-get install build-essential            # GCC, G++, make for compiling C/C++ code
  sudo apt-get install cmake                      # C++ cross compiler
  sudo apt-get install git                        # Version control & cloning repos
  
  sudo apt-get install net-tools -y               # Check network configuration
  sudo apt-get install blueman -y                 # Bluetooth
  sudo apt-get install htop -y                    # Systtem monitor (CPU, RAM, processes)
  sudo apt-get install tree -y                    # Display directory structure
  sudo apt-get install bat -y                     # Better cat command with syntax highlighting
  sudo apt-get install gnome-tweaks -y            # Graphical configuration tool 
  sudo apt-get install gnome-shell-extensions -y  # Customize the GNOME desktop environment
  sudo apt-get install terminator -y              # Multi-pane terminal
  sudo apt-get install tmux -y                    # Manage multiple terminal sessions 
  sudo apt-get install openssh-server             # Set up SSH
  sudo apt-get install openssh-client             # Set up SSH           

  sudo apt-get install python3-pip -y     
  sudo apt-get install python3-venv -y     
  sudo apt-get install python3-numpy -y     
  sudo apt-get install python3-matplotlib -y     
  sudo apt-get install python3-pandas -y     
  sudo apt-get install python3-yaml -y     
  sudo apt-get install python3-opencv -y    
  sudo apt-get install python3-transform3d -y

  pip install jupyterlab
  pip install torch torchvision torchaudio ultralytics scikit-learn

  sudo apt-get install minicom screen -y          # Serial communication
  sudo apt-get install i2c-tools -y               # Detect i2c communication
  sudo apt-get install v4l-utils -y               # Mange USB cameras & video devices
  sudo apt-get install udev                       # Create persistent USB port name

  # https://www.omgubuntu.co.uk/2021/11/best-command-line-tools-ubuntu-linux
  sudo apt-get install btop -y                    # btop++ (System Monitor)	
  sudo apt-get install googler -y                 # googler (Search the Web)
  sudo apt-get install neofetch -y                # neofetch (System Info)
  sudo apt-get install ncdu -y                    # ncdu (Disk Analyser)

  echo ">>> Completed!"
}
ask_and_run system_install_note system_install

##########################################################################################
## INITIAL WORKSPACE SETUP

workspace_setup() 
{
  echo "<<< Processing ..."

  sudo apt-get install wmctrl xdotool -y
  mkdir ~/.config/autostart
  cp ~/MySetup/workspace_setup.desktop ~/.config/autostart
  sudo chmod +x ~/MySetup/workspace_setup.sh

  echo ">>> Completed!"
}
ask_and_run workspace_setup_note workspace_setup

##########################################################################################
## SYSTEM ALIASES

system_alias() 
{
  echo "<<< Processing ..."

  sh -c "echo \"\" >> ~/.bashrc"
  sh -c "echo \"# System shortcuts\" >> ~/.bashrc"
  sh -c "echo \"alias uu='sudo apt-get update && sudo apt-get upgrade -y'\" >> ~/.bashrc"
  sh -c "echo \"alias cl='clear'\" >> ~/.bashrc"
  sh -c "echo \"alias hn='hostname -I'\" >> ~/.bashrc"
  sh -c "echo \"\" >> ~/.bashrc"

  sh -c "echo \"# Edit bashrc file\" >> ~/.bashrc"
  sh -c "echo \"alias gb='gedit ~/.bashrc'\" >> ~/.bashrc"
  sh -c "echo \"alias cb='code ~/.bashrc'\" >> ~/.bashrc"
  sh -c "echo \"alias sb='source ~/.bashrc'\" >> ~/.bashrc"
  sh -c "echo \"\" >> ~/.bashrc"

  sh -c "echo \"# Check protocols\" >> ~/.bashrc"
  sh -c "echo \"alias acm='ls -l /dev | grep ttyACM'\" >> ~/.bashrc"
  sh -c "echo \"alias usb='ls -l /dev | grep ttyUSB'\" >> ~/.bashrc"
  sh -c "echo \"alias i2c='i2cdetect -r -y 1'\" >> ~/.bashrc"
  sh -c "echo \"alias js='ls -l /dev/input/js*'\" >> ~/.bashrc"
  sh -c "echo \"\" >> ~/.bashrc"

  sh -c "echo \"# Switch to a workspace (1,2,3)\" >> ~/.bashrc"
  sh -c "echo \"alias ws1='wmctrl -s 0 &&'\" >> ~/.bashrc"
  sh -c "echo \"alias ws2='wmctrl -s 1 &&'\" >> ~/.bashrc"
  sh -c "echo \"alias ws3='wmctrl -s 2 &&'\" >> ~/.bashrc"
  sh -c "echo \"\" >> ~/.bashrc"

  sh -c "echo \"# Git shorcuts\" >> ~/.bashrc"
  sh -c "echo \"alias ga='git add'\" >> ~/.bashrc"
  sh -c "echo \"alias gs='git status'\" >> ~/.bashrc"
  sh -c "echo \"alias gp='git pull'\" >> ~/.bashrc"
  sh -c "echo \"\" >> ~/.bashrc"

  sh -c "echo \"# My Git shorcuts\" >> ~/.bashrc"
  sh -c "echo \"alias gaa='git add .'\" >> ~/.bashrc"
  sh -c "echo \"alias gcm='git commit -a -m "Update"'\" >> ~/.bashrc"
  sh -c "echo \"alias gph='git push -u origin ubuntu-24.04'\" >> ~/.bashrc"
  sh -c "echo \"\" >> ~/.bashrc"

  source ~/.bashrc

  echo ">>> Completed!"
}
ask_and_run system_alias_note system_alias

##########################################################################################
## APPLICATION INSTALLATION

app_install() 
{
  echo "<<< Processing ..."
  source ~/MySetup/app.sh
  echo ">>> Completed!"
}
ask_and_run app_install_note app_install

##########################################################################################
## ROS2 JAZZY INSTALLATION

ros2_jazzy_install() 
{
  echo "<<< Processing ..."
  source ~/MySetup/ros2_jazzy_install.sh
  echo ">>> Completed!"
}
ask_and_run ros_install_note ros2_jazzy_install

##########################################################################################

#echo "[Complete!!!]"
#exit 0

