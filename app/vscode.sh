#!/bin/bash
## VISUAL STUDIO CODE

# Detect system architecture
ARCH=$(dpkg --print-architecture)

# Function to install for amd64 using snap
install_amd64() {
  echo "Detected architecture: amd64"
  sudo apt update
  sudo apt install -y snapd
  sudo snap install --classic code
  code --version
}

# Function to install for arm64 using .deb
# https://github.com/JetsonHacksNano/installVSCode
install_arm64() {
  VERSION=1.85.2
  echo "Detected architecture: arm64"
  wget -N -O vscode-linux-deb.arm64.deb https://update.code.visualstudio.com/$VERSION/linux-deb-arm64/stable
  sudo apt update
  sudo apt install -y ./vscode-linux-deb.arm64.deb
  code --version
  rm vscode-linux-deb.arm64.deb
}

# Run the appropriate installer
case "$ARCH" in
  amd64)
    install_amd64
    ;;
  arm64)
    install_arm64
    ;;
  *)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac


