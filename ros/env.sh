#!/bin/bash

# Set ROS environment
source /opt/ros/melodic/setup.bash

# If using a workspace (e.g., catkin_ws), source it
source ~/catkin_ws/devel/setup.bash

# Execute the passed command
exec "$@"