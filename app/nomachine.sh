## NOMACHINE
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
