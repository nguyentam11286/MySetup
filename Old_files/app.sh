#!/bin/bash
# Apache License 2.0
# Copyright (c) 2025

##########################################################################################
## VERSION CHECKING

echo "[Note] Target OS version   >>> Ubuntu 22.04.x (Jammy Jellyfish)"
echo "[Note] Target architecture >>> $(dpkg --print-architecture)"
echo "[Note] List of Application:"
echo "[Note] * arduino"
#echo "[Note] * energia"
echo "[Note] * vscode"
echo "[Note] * eclipse"
echo "[Note] * librecad"
echo "[Note] * blender"
echo "[Note] * meshlab"
echo "[Note] * nomachine"
echo "[Note] * raspberry pi imager"
echo ""
echo "PRESS [ENTER] TO CONTINUE THE INSTALLATION"
echo "IF YOU WANT TO CANCEL, PRESS [CTRL] + [C]"
read

##########################################################################################
## APPLICATION INSTALLATION

install_arduino() {
  sudo apt-get install arduino -y
  sudo usermod -aG dialout $USER
  mkdir -p ~/Arduino/libraries

  # Remember to change Arduino reference folder to home/Arduino
  # Reboot the system so the group change takes effect
}

install_vscode_amd64() {
  echo "Detected architecture: amd64"
  sudo apt update
  sudo apt install -y snap
  sudo snap install --classic code
  code --version
  
  # Remember to install extensions: 
  # C/C++, C/C++ Extension Pack, CMake, CMake Tools, Python, XML, XML Tools, ROS
}

install_vscode_arm64() {
  sudo apt install wget gpg # Install required dependencies:
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg # Import Microsoft GPG key
  sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
  echo "deb [arch=arm64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | sudo tee /etc/apt/sources.list.d/vscode.list # Enable the VS Code repository for ARM64
  
  sudo apt update
  sudo apt install code -y

  # Remove the .gpg package
  rm packages.microsoft.gpg   

  # Remember to install extensions: 
  # C/C++, C/C++ Extension Pack, CMake, CMake Tools, Python, XML, XML Tools, ROS
}

install_eclipse() {
  sudo apt install default-jre -y
  sudo snap install --classic eclipse
}

install_librecad() {
  sudo apt-get install librecad -y
}

install_blender() {
  sudo apt-get install blender -y
}

install_meshlab() {
  sudo apt-get install meshlab -y
}

install_nomachine_amd64() {
  # Download the latest .deb package using wget
  wget https://www.nomachine.com/free/linux/64/deb -O nomachine.deb

  # Install the .deb package
  sudo dpkg -i nomachine.deb
  sudo apt-get install -f

  # NoMachine should start automatically after installation. 
  # To check its status:
  sudo /etc/NX/nxserver --status

  # Expected output (example)
  # NX> 900 Connecting to server ...
  # NX> 110 NX Server is running
  # NX> 999 Bye

  # If not running, start it manually
  #sudo /etc/NX/nxserver --startup

  # Remove the .deb package
  rm nomachine.deb
}

install_nomachine_arm64() {
  # Download the latest .deb package using wget
  wget https://download.nomachine.com/download/9.0/Arm/nomachine_9.0.188_11_arm64.deb -O nomachine_arm64.deb

  # Install the .deb package
  sudo dpkg -i nomachine_arm64.deb
  sudo apt-get install -f

  # NoMachine should start automatically after installation. 
  # To check its status:
  sudo /usr/NX/bin/nxserver --status

  # Remove the .deb package
  rm nomachine_arm64.deb   
}

install_rpi_imager() {
  sudo apt-get install rpi-imager -y
}

echo "[Set the target OS and architecture]"
name_os_version=${name_os_version:="jammy"}
ARCH=$(dpkg --print-architecture)

echo "[Update the package lists]"
sudo apt update -y

echo "[Install Applications]"
cd $HOME

echo "[Install Arduino]"
install_arduino

echo "[Install VSCode]"
install_vscode="install_vscode_$ARCH"
$install_vscode

echo "[Install Eclipse]"
install_eclipse

echo "[Install Librecad]"
install_librecad

echo "[Install Blender]"
install_blender

echo "[Install Meshlab]"
install_meshlab

echo "[Install NoMachine]"
install_nomachine="install_nomachine_$ARCH"
$install_nomachine

echo "[Install Raspberry Pi Imager]"
install_rpi_imager

##########################################################################################

#echo "[Complete!!!]"
#exit 0
