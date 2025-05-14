# System settings
# Settings -> Brightness & Lock -> Turn screen off: Never, Lock: OFF

# System update repository
sudo apt-get update
sudo apt-get upgrade -y

# System installation
source ~/MySetup/sys/install.sh

# System configuration
source ~/MySetup/sys/config.sh

# System aliases 
echo "source ~/MySetup/sys/alias.bash" >> ~/.bashrc

# Application installation
source ~/MySetup/app/all.sh

# ROS Melodic installation
source ~/MySetup/ros/melodic.sh

# Source new bash setup
source ~/.bashrc
