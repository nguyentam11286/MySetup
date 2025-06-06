## ROS ALIASES 
echo "source ~/MySetup/ros/alias.bash" >> ~/.bashrc

## ROS MELODIC INSTALLATION
source ~/MySetup/ros/melodic.sh

## ROS SETUP
# Create tutorials folder
# Install tutorial packages
cd ~/catkin_ws/src 
mkdir tutorials
sudo apt-get install ros-melodic-ros-tutorials

# Create libraries folder
cd ~/catkin_ws/src 
mkdir libraries
source ~/MySetup/ros/rplidar.sh
source ~/MySetup/ros/imu_bno055.sh
source ~/MySetup/ros/rosserial.sh
source ~/MySetup/ros/turtlebot3.sh

# Create projects folder
cd ~/catkin_ws/src 
mkdir projects
#git clone https://github.com/nguyentam11286/project01_SLAM.git

## ROS REFERENCE
# Create reference packages
#cd && mkdir catkin_rf
#cd catkin_rf
#git clone -b rosmelodic https://github.com/aniskoubaa/ros_essentials_cpp.git
#git clone https://github.com/qboticslab/mastering_ros.git

## ENV.SH
# env.sh is used to set the environment correctly on the remote side
cp ~/MySetup/ros/env.sh ~/env.sh