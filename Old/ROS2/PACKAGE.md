## OWN PACKAGE
ROS offical website: https://docs.ros.org/en/humble/Tutorials.html

# SOURCE ROS2 ENVIRONMENT
Source the main ROS2 workspace (underlay).
>> source /opt/ros/humble/setup.bash

# ROS2 WORKSPACE
A workspace is a directory containing ROS2 packages.
Create a new directory for new workspace (overlay).
>> mkdir -p ~/ros2_ws/src && cd ~/ros2_ws/src

Clone sample repo, check out the branch that targets your installed ROS 2 distro.
The ros_tutorials repository contains the turtlesim package.
The other packages in this repository are not built because they contain a COLCON_IGNORE file.
>> git clone https://github.com/ros/ros_tutorials.git -b humble

Before building the workspace, you need to resolve the package dependencies. 
Packages declare their dependencies in the package.xml file.
>> cd ~/ros2_ws && rosdep install -i --from-path src --rosdistro humble -y

# BUILD WORKSPACE
Build your packages using the command:
>> cd ~/ros2_ws && colcon build
>> source install/local_setup.bash
>> ros2 run turtlesim turtlesim_node

# ROS2 PACKAGE
An organizational unit for your ROS 2 code.
>> cd ~/ros2_ws/src

ros2 pkg create --build-type ament_cmake --license Apache-2.0 [package_name]
use the argument --node-name which creates a simple Hello World type executable in the package.
>> ros2 pkg create --build-type ament_cmake --license Apache-2.0 --node-name my_node my_package

Build your packages:
>> cd ~/ros2_ws && colcon build

To build only the my_package package.
>> cd ~/ros2_ws && colcon build --packages-select my_package

To use your new package and executable, source your main ROS 2 installation.
Inside the ros2_ws directory, run the following command to source your workspace.
>> source install/local_setup.bash

To run the executable:
>> ros2 run my_package my_node


