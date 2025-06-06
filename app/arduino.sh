## ARDUINO IDE
sudo apt update 
sudo apt-get install arduino
sudo usermod -aG dialout $USER
mkdir Arduino/libraries

# Remember to change Arduino reference folder to home/Arduino
# Reboot the system so the group change takes effect
#sudo reboot