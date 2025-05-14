## ENERGIA IDE
#  Download file.tar.xz in the official website & extract file
sudo apt update 
wget https://energia.nu/downloads/downloadv4.php?file=energia-1.8.10E23-linux64.tar.xz 
tar -xf downloadv4*.tar.xz
sudo chmod +x energia-*/energia

# Run Energia
#cd energia-* && ./energia

# Move the folder to /usr/share like Arduino
sudo mv energia-* /usr/share/energia

# Create a symlink so you can run it from terminal
sudo ln -s /usr/share/energia/energia /usr/local/bin/energia

# Run Energia
#energia

# Create desktop launcher
echo "[Desktop Entry]
Name=Energia
Exec=/usr/share/energia/energia
Icon=/usr/share/energia/lib/arduino.png
Type=Application
Categories=Development;" >> ~/.local/share/applications/energia.desktop
sudo chmod +x ~/.local/share/applications/energia.desktop

# Remove download file
rm downloadv4*.tar.xz

# Energia on Linux may not have permission to access the USB debugging interface
# Create a udev rule
echo 'SUBSYSTEM=="usb", 
ATTR{idVendor}=="1cbe", 
ATTR{idProduct}=="00fd", 
MODE="0666", 
GROUP="plugdev"' | sudo tee /etc/udev/rules.d/99-tiva.rules > /dev/null
sudo udevadm control --reload-rules
sudo udevadm trigger
sudo usermod -aG plugdev $USER

# Reboot the system so the group change takes effect
#sudo reboot