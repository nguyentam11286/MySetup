## SYSTEM SETUP

# System aliases 
echo "source ~/MySetup/sys/alias.bash" >> ~/.bashrc

# System Settings
source ~/MySetup/sys/setting.sh

# Update repository
sudo apt-get update
sudo apt-get upgrade -y

# System installation
source ~/MySetup/sys/install.sh

# Application installation
source ~/MySetup/app/install.sh

# ROS Melodic installation
source ~/MySetup/ros/install.sh

# Source new bash setup
source ~/.bashrc
