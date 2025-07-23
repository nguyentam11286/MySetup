 
## ROS2 SETUP
ROS offical website: https://docs.ros.org/en/humble/Tutorials.html

# CONFIGURING ENVIRONMENT
Source setuo file to access ROS 2 commands, find or use ROS 2 packages.
>> echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

Check environment variables
>> printenv | grep -i ROS

Set a unique integer for your group of ROS 2 nodes (if need)
>> echo "export ROS_DOMAIN_ID=<your_domain_id>" >> ~/.bashrc

To limit ROS 2 communication to localhost only (helpful in classroom)
>> echo "export ROS_LOCALHOST_ONLY=1" >> ~/.bashrc

# ROS2 WORKSPACE
ros2_ws workspace will be an overlay on top of the existing ROS 2 installation (underlay).
Create a directory (ros2_ws) to contain our workspace.
>> mkdir -p ~/ros2_ws/src && cd ~/ros2_ws
>> git clone https://github.com/ros2/examples src/examples -b humble

# COLCON
colcon is an iteration on the ROS build tools.
colcon supports multiple build types like cmake (recommend ament_cmake & ament_python).

>> sudo apt install python3-colcon-common-extensions

ament_cmake do not support the concept of the devel.
colcon supports the option --symlink-install 
Allows the installed files to be changed by changing the files in the source space.
>> cd ~/ros2_ws && colcon build --symlink-install

To run tests for the packages we just built.
>> colcon test

# SOURCE THE ENVIRONMENT
The building output (executable, libraries) will be in the install directory.
colcon generates a bash file in the install directory to set up environment.
These file will add all requirement elements to your path and library paths.
>> source install/setup.bash

# DEMO PUBLISHER-SUBSCRIBER
>> ros2 run examples_rclcpp_minimal_subscriber subscriber_member_function
>> ros2 run examples_rclcpp_minimal_publisher publisher_member_function


















