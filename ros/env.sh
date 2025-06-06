#!/bin/bash

# Set ROS environment
source /opt/ros/melodic/setup.bash

# If using a workspace (e.g., catkin_ws), source it
source ~/catkin_ws/devel/setup.bash

# Set ROS Master URI to itself (Jetson)
export ROS_MASTER_URI=http://192.168.68.100:11311

# Set Jetson's own IP address
export ROS_HOSTNAME=192.168.1.100  # Replace with Jetson's actual IP address