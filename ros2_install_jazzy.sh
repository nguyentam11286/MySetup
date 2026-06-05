#!/bin/bash
# Apache License 2.0
# Copyright (c) 2025

name_ros_distro=jazzy 
name_ros_workspace=ros2_ws
user_name=$(whoami)

##########################################################################################
## VERSION CHECKING

echo ""
echo "[Note] Starting ROS 2 Jazzy Installation"
echo "[Note] Checking your Ubuntu version"
echo ""

# Getting version and release number of Ubuntu
version=`lsb_release -sc`
relesenum=`grep DISTRIB_DESCRIPTION /etc/*-release \
           | awk -F 'Ubuntu ' '{print $2}' | awk -F ' LTS' '{print $1}'`
echo ">>> Your Ubuntu version is: [Ubuntu $version $relesenum]"

# Checking version is focal, if yes proceed othervice quit
case $version in
  "noble" )
  ;;
  *)
    echo "[Note] ERROR: This script will only work on Ubuntu Noble (24.04)"
    exit 0
esac

echo "[Note] ROS 2 Jazzy is fully compatible with Ubuntu Noble 24.04"

echo ""
echo "PRESS [ENTER] TO CONTINUE THE INSTALLATION"
echo "IF YOU WANT TO CANCEL, PRESS [CTRL] + [C]"
read

##########################################################################################
## ROS2 JAZZY INSTALLATION

echo "[Note] Step 1: Configure your Ubuntu repositories"

locale  # check for UTF-8
sudo apt update 
sudo apt install -y locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
locale  # verify settings

sudo apt install -y software-properties-common
sudo add-apt-repository universe

echo ">>> Done: Added Ubuntu repositories"
echo "[Note] Step 2: Set up your keys"
echo "[Note] Installing curl for adding keys"

#C hecking curl is installed or not
# name=curl
# which $name > /dev/null 2>&1
# if [ $? == 0 ]; then
#    echo ">>> Curl is already installed!"
# else
#    echo ">>> Curl is not installed,Installing Curl"

echo "[Note] Checking and removing existing keys if present"

if [ -f "/etc/apt/sources.list.d/ros2.list" ]; then
    sudo rm /etc/apt/sources.list.d/ros2.list
fi

if [ -f "/usr/share/keyrings/ros-archive-keyring.gpg" ]; then
    sudo rm /usr/share/keyrings/ros-archive-keyring.gpg
fi

echo "[Note] Installing ROS 2 APT Source package"

sudo apt update 
sudo apt install -y curl openssl 

export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb" # If using Ubuntu derivates use $UBUNTU_CODENAME
sudo apt install /tmp/ros2-apt-source.deb

echo ">>> Done: Added Keys"
echo "[Note] Step 4: Updating Ubuntu package index"

sudo apt update
sudo apt -y upgrade 

echo "[Note] Step 5: Install ROS 2 Jazzy"
echo "[Note] Pick option you want to install (1 or 2)"
echo "[Note] 1. Desktop Install: (Recommended) : Everything in Desktop plus 2D/3D simulators and 2D/3D perception packages.]"
echo "[Note] 2. ROS-Base: (Bare Bones) ROS packaging, build, and communication libraries. No GUI tools.]"
read -p "[Note] Enter your install (Default is 1):" answer 

case "$answer" in
  1)
    package_type="desktop-full"
    ;;
  2)
    package_type="ros-base"
    ;;    
  * )
    package_type="desktop-full"
    ;;
esac

echo "[Note] Starting ROS installation"

sudo apt install -y ros-${name_ros_distro}-${package_type} 
sudo apt install -y ros-dev-tools

echo "[Note] Step 6: Setting ROS Environment" 
echo "[Note] This will add ROS environment to .bashrc."
echo "[Note] After adding this, you can able to access ROS commands in terminal."

source /opt/ros/${name_ros_distro}/setup.bash
printenv | grep -i ROS

echo "ROS 2 ENVIRONMENT VARIABLES"
echo ""
echo "ROS_VERSION=" $ROS_VERSION
echo "ROS_PYTHON_VERSION=" $ROS_PYTHON_VERSION
echo "ROS_DISTRO=" $ROS_DISTRO   
echo ""                
echo "PRESS [ENTER] TO CONTINUE THE INSTALLATION"
read

##########################################################################################
## ROS2 ENVIRONMENT CONFIGURATION



##########################################################################################
## ROS2 PACKAGES

sudo apt update
sudo apt-get install -y ros-${ROS_DISTRO}-turtlesim
sudo apt-get install -y '~nros-jazzy-rqt*'
#sudo apt-get install -y ros-${ROS_DISTRO}-xacro
#sudo apt-get install -y ros-${ROS_DISTRO}-ros-gz*
#sudo apt-get install -y ros-${ROS_DISTRO}-robot-localization
#sudo apt-get install -y ros-${ROS_DISTRO}-joy
#sudo apt-get install -y ros-${ROS_DISTRO}-joy-teleop
#sudo apt-get install -y ros-${ROS_DISTRO}-tf-transformations

# RViz 
sudo apt install -y ros-${ROS_DISTRO}-urdf-launch 
sudo apt install -y ros-${ROS_DISTRO}-joint-state-publisher 
sudo apt install -y ros-${ROS_DISTRO}-joint-state-publisher-gui 
sudo apt install -y ros-${ROS_DISTRO}-ur-description
sudo apt install -y ros-${ROS_DISTRO}-turtlebot4-description
sudo apt install -y ros-${ROS_DISTRO}-leo-description

# Gazebo Sim
sudo apt install -y ros-${ROS_DISTRO}-ros-gz 
sudo apt install -y ros-${ROS_DISTRO}-ros-gz-sim
sudo apt install -y ros-${ROS_DISTRO}-ros-gz-bridge
sudo apt install -y ros-${ROS_DISTRO}-ros2-control 
sudo apt install -y ros-${ROS_DISTRO}-gz-ros2-control 
sudo apt install -y ros-${ROS_DISTRO}-gz-ros2-control-demos 
sudo apt install -y ros-${ROS_DISTRO}-ros2-controllers 
sudo apt install -y ros-${ROS_DISTRO}-rqt-joint-trajectory-controller
sudo apt install -y ros-${ROS_DISTRO}-turtlebot4-simulator
sudo apt install -y ros-${ROS_DISTRO}-leo-simulator

# Webots 
sudo apt install -y ros-${ROS_DISTRO}-webots-ros2

# Nav2
sudo apt install -y ros-${ROS_DISTRO}-navigation2
sudo apt install -y ros-${ROS_DISTRO}-nav2-bringup
sudo apt install -y ros-${ROS_DISTRO}-nav2-minimal-tb*

# SLAM Toolbox
sudo apt install -y ros-${ROS_DISTRO}-slam-toolbox

# Camera
sudo apt-get install ros-${ROS_DISTRO}-usb-cam
sudo apt-get install ros-${ROS_DISTRO}-rqt-image-view
sudo apt-get install ros-${ROS_DISTRO}-camera-calibration

# Intel RealSense 
sudo apt-get install ros-${ROS_DISTRO}-librealsense2
sudo apt-get install ros-${ROS_DISTRO}-realsense2-*


##########################################################################################
## ROS2 ALIASES

echo "[Set the ROS evironment]"

sh -c "echo \" \" >> ~/.bashrc"
sh -c "echo \"alias ru='rosdep update'\" >> ~/.bashrc"
sh -c "echo \"alias r2ws='cd ~/${name_ros_workspace}'\" >> ~/.bashrc"s
sh -c "echo \"alias r2src='cd ~/${name_ros_workspace}/src'\" >> ~/.bashrc"
sh -c "echo \"alias r2lib='cd ~/${name_ros_workspace}/src/libraries'\" >> ~/.bashrc"
sh -c "echo \"alias r2tut='cd ~/${name_ros_workspace}/src/tutorials'\" >> ~/.bashrc"
sh -c "echo \"alias r2proj='cd ~/${name_ros_workspace}/src/projects'\" >> ~/.bashrc"
sh -c "echo \"alias ccb='cd ~/${name_ros_workspace} && colcon build'\" >> ~/.bashrc"
sh -c "echo \"alias ccbs='cd ~/${name_ros_workspace} && colcon build --select-package'\" >> ~/.bashrc"
sh -c "echo \"alias r2ls='source ~/${name_ros_workspace}/install/local_setup.bash'\" >> ~/.bashrc"
sh -c "echo \" \" >> ~/.bashrc"
sh -c "echo \"source /opt/ros/${name_ros_distro}/setup.bash\" >> ~/.bashrc"

source /home/$user_name/.bashrc

##########################################################################################
## ROS2 WORKSPACE
# ROS2 built tool is colcon

sudo apt install python3-colcon-common-extensions
mkdir -p ~/${name_ros_workspace}/src
cd ~/${name_ros_workspace}/src
mkdir -p libraries projects tutorials
cd ~/${name_ros_workspace}
git clone https://github.com/ros2/examples.git src/examples -b ${name_ros_distro}
colcon build --symlink-install

## ROS2 DEMO
#source /opt/ros/${name_ros_distro}/setup.bash
#ros2 run examples_rclcpp_minimal_subscriber subscriber_member_function
#source /opt/ros/${name_ros_distro}/setup.bash
#ros2 run examples_rclcpp_minimal_publisher publisher_member_function

##########################################################################################

#echo "[Complete!!!]"
#exit 