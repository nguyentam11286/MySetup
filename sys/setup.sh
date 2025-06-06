# System Settings
source ~/MySetup/sys/setting.sh

# Update repository
sudo apt-get update
sudo apt-get upgrade -y

# System installation
source ~/MySetup/sys/install.sh

# System aliases 
echo "source ~/MySetup/sys/alias.bash" >> ~/.bashrc

# Application installation
source ~/MySetup/app/install.sh

# ROS Melodic installation
source ~/MySetup/ros/melodic.sh

# Source new bash setup
source ~/.bashrc
