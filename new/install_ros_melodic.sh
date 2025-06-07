#!/bin/bash
# Apache License 2.0
# Copyright (c) 2025

##################################################################################################
# VERSION CHECKING

echo ""
echo "[Note] Target OS version  >>> Ubuntu 18.04.x (Bionic Beaver)"
echo "[Note] Target ROS version >>> ROS Melodic Morenia"
echo "[Note] Catkin workspace   >>> $HOME/catkin_ws"
echo ""
echo "PRESS [ENTER] TO CONTINUE THE INSTALLATION"
echo "IF YOU WANT TO CANCEL, PRESS [CTRL] + [C]"
read

##################################################################################################
# ROS MELODIC INSTALLATION

echo "[Set the target OS, ROS version and name of catkin workspace]"
name_os_version=${name_os_version:="bionic"}
name_ros_version=${name_ros_version:="melodic"}
name_catkin_workspace=${name_catkin_workspace:="catkin_ws"}

echo "[Update the package lists]"
sudo apt update -y

echo "[Install build environment, the chrony, ntpdate and set the ntpdate]"
sudo apt install -y chrony ntpdate curl build-essential
sudo ntpdate ntp.ubuntu.com

echo "[Add the ROS repository]"
if [ ! -e /etc/apt/sources.list.d/ros-latest.list ]; then
  sudo sh -c "echo \"deb http://packages.ros.org/ros/ubuntu ${name_os_version} main\" > /etc/apt/sources.list.d/ros-latest.list"
fi

echo "[Download the ROS keys]"
roskey=`apt-key list | grep "Open Robotics"`
if [ -z "$roskey" ]; then
  curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
fi

echo "[Check the ROS keys]"
roskey=`apt-key list | grep "Open Robotics"`
if [ -n "$roskey" ]; then
  echo "[ROS key exists in the list]"
else
  echo "[Failed to receive the ROS key, aborts the installation]"
  exit 0
fi

echo "[Update the package lists]"
sudo apt update -y

echo "[Install the ros-desktop-full and all rqt plugins]"
sudo apt install -y ros-$name_ros_version-desktop-full ros-$name_ros_version-rqt-*

echo "[Environment setup and getting rosinstall]"
source /opt/ros/$name_ros_version/setup.sh
sudo apt install -y python-rosinstall python-rosinstall-generator python-wstool build-essential git

echo "[Install rosdep]"
sudo apt install python-rosdep

echo "[Initialize rosdep and Update]"
sudo sh -c "rosdep init"
rosdep update
rosdep --version

echo "[Make the catkin workspace and test the catkin_make]"
mkdir -p $HOME/$name_catkin_workspace/src
cd $HOME/$name_catkin_workspace/src
catkin_init_workspace
cd $HOME/$name_catkin_workspace
catkin_make

##################################################################################################
# ROS PACKAGE INSTALLATION

# sudo apt-get install ros-melodic-rosserial ros-melodic-rosserial-arduino
# sudo apt-get install ros-melodic-ros-tutorials

cd $HOME/$name_catkin_workspace/src 
mkdir libraries tutorials projects

cd $HOME/$name_catkin_workspace/src/libraries
git clone https://github.com/Slamtec/rplidar_ros.git
git clone https://github.com/dheera/ros-imu-bno055.git imu_bno055
git clone https://github.com/pcdangio/ros-driver_mpu9250.git driver_mpu9250
git clone https://github.com/pcdangio/ros-sensor_msgs_ext.git sensor_msgs_ext
cd ~/catkin_ws
catkin_make --only-pkg-with-deps rplidar_ros imu_bno055 driver_mpu9250 sensor_msgs_ext
cd -

# cd $HOME/$name_catkin_workspace/src/projects
# git clone https://github.com/nguyentam11286/project01_SLAM.git
# cd ~/catkin_ws
# catkin_make --only-pkg-with-deps slam_robot slam_robot_description slam_robot_odometry slam_robot_teleoperation slam_robot_navigation
# cd -

# cp ~/MySetup/ros/env.sh ~/env.sh

##################################################################################################
# ROS ENVIRONMENT VARIABLES

echo "[Set the ROS evironment]"
sh -c "echo \"alias ru='rosdep update'\" >> ~/.bashrc"
sh -c "echo \"alias cw='cd ~/$name_catkin_workspace'\" >> ~/.bashrc"
sh -c "echo \"alias cs='cd ~/$name_catkin_workspace/src'\" >> ~/.bashrc"
sh -c "echo \"alias cm='cd ~/$name_catkin_workspace && catkin_make && cd -'\" >> ~/.bashrc"

sh -c "echo \"source /opt/ros/$name_ros_version/setup.bash\" >> ~/.bashrc"
sh -c "echo \"source ~/$name_catkin_workspace/devel/setup.bash\" >> ~/.bashrc"

sh -c "echo \"export ROS_MASTER_URI=http://localhost:11311\" >> ~/.bashrc"
sh -c "echo \"export ROS_HOSTNAME=localhost\" >> ~/.bashrc"

source $HOME/.bashrc

echo "ROS_DISTRO=" $ROS_DISTRO
echo "ROS_PACKAGE_PATH=" $ROS_PACKAGE_PATH

##################################################################################################

echo "[Complete!!!]"
exit 0