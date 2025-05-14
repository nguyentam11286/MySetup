## RPLIDAR PACKAGES
cd ~/catkin_ws/src/libraries
git clone https://github.com/Slamtec/rplidar_ros.git
cd ~/catkin_ws
catkin_make --only-pkg-with-deps rplidar_ros
cd 