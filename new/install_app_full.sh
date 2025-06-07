#!/bin/bash
# Apache License 2.0
# Copyright (c) 2025

##################################################################################################
# VERSION CHECKING

echo ""
echo "[Note] Target OS version   >>> Ubuntu 18.04.x (Bionic Beaver)"
echo "[Note] Target architecture >>> $(dpkg --print-architecture)"
echo "[Note] List of Application:"
echo "[Note] * arduino"
# echo "[Note] * energia"
echo "[Note] * vscode"
echo "[Note] * eclipse"
echo "[Note] * librecad"
echo "[Note] * blender"
echo "[Note] * meshlab"
echo "[Note] * nomachine"
echo ""
echo "PRESS [ENTER] TO CONTINUE THE INSTALLATION"
echo "IF YOU WANT TO CANCEL, PRESS [CTRL] + [C]"
read

##################################################################################################
# APPLICATION INSTALLATION

echo "[Set the target OS and architecture]"
name_os_version=${name_os_version:="bionic"}
ARCH=$(dpkg --print-architecture)

echo "[Update the package lists]"
sudo apt update -y

install_arduino() {
  sudo apt-get install arduino
  sudo usermod -aG dialout $USER
  mkdir -p ~/Arduino/libraries

  # Remember to change Arduino reference folder to home/Arduino
  # Reboot the system so the group change takes effect
}

install_vscode_amd64() {
  echo "Detected architecture: amd64"
  sudo apt update
  sudo apt install -y snapd
  sudo snap install --classic code
  code --version
}

install_vscode_arm64() {
  # https://github.com/JetsonHacksNano/installVSCode
  VERSION=1.85.2
  echo "Detected architecture: arm64"
  wget -N -O vscode-linux-deb.arm64.deb https://update.code.visualstudio.com/$VERSION/linux-deb-arm64/stable
  sudo apt update
  sudo apt install -y ./vscode-linux-deb.arm64.deb
  code --version
  rm vscode-linux-deb.arm64.deb
}

install_eclipse() {
  sudo apt install default-jre
  sudo snap install --classic eclipse
}

install_librecad() {
  sudo apt-get install librecad
}

install_blender() {
  sudo apt-get install blender
}

install_meshlab() {
  sudo apt-get install meshlab 
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

##################################################################################################

echo "[Complete!!!]"
exit 0