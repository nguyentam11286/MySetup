#!/bin/bash
# Apache License 2.0
# Copyright (c) 2025

################################################################################################
## ROS 2 OFFICIAL 

# https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html
# https://docs.ros.org/en/humble/Tutorials/Beginner-CLI-Tools/Configuring-ROS2-Environment.html
# https://docs.ros.org/en/humble/Tutorials/Beginner-Client-Libraries/Colcon-Tutorial.html

################################################################################################
## VERSION CHECKING

echo ""
echo "[Note] Target OS version  >>> Ubuntu 22.04.x (Jammy Jellyfish)"
echo "[Note] Target ROS version >>> ROS Humble Hawksbill"
echo "[Note] ROS 2 workspace   >>> $HOME/ros2_ws"
echo ""
echo "PRESS [ENTER] TO CONTINUE THE INSTALLATION"
echo "IF YOU WANT TO CANCEL, PRESS [CTRL] + [C]"
read

################################################################################################
## ROS2 INSTALLATION

echo "[Set the target OS, ROS version and name of catkin workspace]"
name_os_version=${name_os_version:="jammy"}
name_ros_version=${name_ros_version:="humble"}
name_catkin_workspace=${name_catkin_workspace:="catkin_ws"}

locale  
sudo apt update && sudo apt install locales 
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
locale  

sudo apt install software-properties-common
sudo add-apt-repository universe

sudo apt update && sudo apt install -y curl 
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb"
sudo apt install /tmp/ros2-apt-source.deb

sudo apt update && sudo apt upgrade
sudo apt install -y ros-humble-desktop  
sudo apt install -y ros-humble-ros-base 
sudo apt install -y ros-dev-tools 

source /opt/ros/humble/setup.bash
printenv | grep -i ROS

echo "ROS 2 ENVIRONMENT VARIABLES"
echo ""
echo "ROS_VERSION=" $ROS_VERSION
echo "ROS_PYTHON_VERSION=" $ROS_PYTHON_VERSION
echo "ROS_DISTRO=" $ROS_DISTRO   
echo ""                
echo "PRESS [ENTER] TO CONTINUE THE INSTALLATION"
read

## ROS2 UNINSTALLATION
#sudo apt remove ~nros-humble-* && sudo apt autoremove
#sudo apt remove ros2-apt-source
#sudo apt update
#sudo apt autoremove
#sudo apt upgrade # Consider upgrading for packages previously shadowed.

## ROS2 DEMO
#source /opt/ros/humble/setup.bash
#ros2 run demo_nodes_cpp listener
#source /opt/ros/humble/setup.bash
#ros2 run demo_nodes_cpp talker

################################################################################################
## ROS2 ENVIRONMENT CONFIGURATION

#echo "export ROS_DOMAIN_ID=<000001>" >> ~/.bashrc
#echo "export ROS_LOCALHOST_ONLY=1" >> ~/.bashrc

################################################################################################
## ROS2 PACKAGES

sudo apt update
sudo apt-get install -y ros-humble-turtlesim
sudo apt-get install -y '~nros-humble-rqt*'
#sudo apt-get install -y ros-humble-ros2-control 
#sudo apt-get install -y ros-humble-ros2-controllers
#sudo apt-get install -y ros-humble-xacro
#sudo apt-get install -y ros-humble-ros-gz*
#sudo apt-get install -y ros-humble-*-ros2-control
#sudo apt-get install -y ros-humble-joint-state-publisher-gui
#sudo apt-get install -y ros-humble-robot-localization
#sudo apt-get install -y ros-humble-joy
#sudo apt-get install -y ros-humble-joy-teleop
#sudo apt-get install -y ros-humble-tf-transformations

################################################################################################
## ROS2 ALIASES

echo "[Set the ROS evironment]"
sh -c "echo \" \" >> ~/.bashrc"
sh -c "echo \"export NAME_ROS2_WORKSPACE='ros2_ws'\" >> ~/.bashrc"
sh -c "echo \"export NAME_ROS2_VERSION='humble'\" >> ~/.bashrc"
sh -c "echo \" \" >> ~/.bashrc"
sh -c "echo \"alias ru='rosdep update'\" >> ~/.bashrc"
sh -c "echo \"alias r2ws='cd ~/\\\$NAME_ROS2_WORKSPACE'\" >> ~/.bashrc"s
sh -c "echo \"alias r2src='cd ~/\\\$NAME_ROS2_WORKSPACE/src'\" >> ~/.bashrc"
sh -c "echo \"alias r2lib='cd ~/\\\$NAME_ROS2_WORKSPACE/src/libraries'\" >> ~/.bashrc"
sh -c "echo \"alias r2tut='cd ~/\\\$NAME_ROS2_WORKSPACE/src/tutorials'\" >> ~/.bashrc"
sh -c "echo \"alias r2proj='cd ~/\\\$NAME_ROS2_WORKSPACE/src/projects'\" >> ~/.bashrc"
sh -c "echo \"alias ccb='cd ~/\\\$NAME_ROS2_WORKSPACE && colcon build'\" >> ~/.bashrc"
sh -c "echo \"alias ccbs='cd ~/\\\$NAME_ROS2_WORKSPACE && colcon build --select-package'\" >> ~/.bashrc"
sh -c "echo \"alias r2ls='source ~/\\\$NAME_ROS2_WORKSPACE/install/local_setup.bash'\" >> ~/.bashrc"
sh -c "echo \" \" >> ~/.bashrc"
sh -c "echo \"source /opt/ros/\\\$NAME_ROS2_VERSION/setup.bash\" >> ~/.bashrc"
source ~/.bashrc

################################################################################################
## ROS2 WORKSPACE
# ROS2 built tool is colcon

sudo apt install python3-colcon-common-extensions
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws
git clone https://github.com/ros2/examples.git src/examples -b humble
colcon build --symlink-install

## ROS2 DEMO
#source /opt/ros/humble/setup.bash
#ros2 run examples_rclcpp_minimal_subscriber subscriber_member_function
#source /opt/ros/humble/setup.bash
#ros2 run examples_rclcpp_minimal_publisher publisher_member_function

################################################################################################

echo "[Complete!!!]"
#exit 
