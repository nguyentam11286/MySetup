## NOMACHINE

# Detect system architecture
ARCH=$(dpkg --print-architecture)

# Function to install for amd64 
install_amd64() {
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

# Function to install for arm64
install_arm64() {
  # Download the latest .deb package using wget
  wget https://download.nomachine.com/download/8.12/Linux/nomachine_8.12.3_1_arm64.deb -O nomachine_arm64.deb

  # Install the .deb package
  sudo dpkg -i nomachine_arm64.deb
  sudo apt-get install -f

  # NoMachine should start automatically after installation. 
  # To check its status:
  sudo /usr/NX/bin/nxserver --status

  # Remove the .deb package
  rm nomachine_arm64.deb
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



