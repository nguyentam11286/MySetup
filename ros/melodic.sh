## OFFICIAL WEBSTIE: 
# http://wiki.ros.org/melodic/Installation/Ubuntu

## ROS ALIASES 
echo "source ~/MySetup/ros/alias.bash" >> ~/.bashrc

## ROS MELODIC INSTALLATION
# Setup source.list
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

# Setup keys
sudo apt install curl 
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -

# Install ROS
sudo apt update
sudo apt install ros-melodic-desktop-full
apt search ros-melodic

# Setup environment
echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc
source ~/.bashrc

# Dependencies for building packages
sudo apt install python-rosdep python-rosinstall 
sudo apt install python-rosinstall-generator 
sudo apt install python-wstool 
sudo apt install build-essential

# Install rosdep tool
sudo apt install python-rosdep
sudo rosdep init
rosdep update

# Check ROS version
rosversion -d
rosdep --version
echo $ROS_DISTRO

## ROS WORKSPACE
# Create catkin workspace and build workspace
cd 
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
catkin_init_workspace
cd ~/catkin_ws
catkin_make
echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc
source ~/.bashrc

# Check environment variable
echo $ROS_PACKAGE_PATH

# Create libraries folder
cd ~/catkin_ws/src 
mkdir libraries

# Create projects folder
cd ~/catkin_ws/src 
mkdir projects

# Create tutorials folder
# Install tutorial packages
cd ~/catkin_ws/src 
mkdir tutorials
sudo apt-get install ros-melodic-ros-tutorials

## ROS REFERENCE
# Create reference packages
cd && mkdir catkin_rf
cd catkin_rf
git clone -b ros-melodic https://github.com/aniskoubaa/ros_essentials_cpp.git
#git clone https://github.com/qboticslab/mastering_ros.git

## ROS SERIAL
# **********************************************************************
# Install rosserial_arduino and rosserial_tivaC only
#sudo apt-get install ros-melodic-rosserial
#sudo apt-get install ros-melodic-rosserial-arduino
#cd ~/catkin_ws/src/libraries
#git clone https://github.com/vmatos/rosserial_tivac.git
#cd ~/catkin_ws 
#catkin_make --only-pkg-with-deps rosserial_tivac

# Remove rosserial_arduino and rosserial_tivaC 
#sudo apt-get remove ros-melodic-rosserial ros-melodic-rosserial-arduino
#sudo apt-get autoremove
# **********************************************************************

# Install all rosserial packages from source
# https://github.com/ros-drivers/rosserial/tree/melodic-devel
cd ~/catkin_ws/src/libraries
git clone -b melodic-devel https://github.com/ros-drivers/rosserial.git 
cd ~/catkin_ws
catkin_make
catkin_make --only-pkg-with-deps rosserial_arduino
catkin_make --only-pkg-with-deps rosserial_tivac

# Prepare rosserial libraries for Arduino 
cd ~/Arduino/libraries
rm -rf ros_lib
rosrun rosserial_arduino make_libraries.py .

# Prepare rosserial libraries for Energia
cd ~/Energia/libraries
rm -rf ros_lib
rosrun rosserial_tivac make_libraries_energia .

# **********************************************************************
# Remove rosserial packages from source
#cd ~/catkin_ws/src/libraries 
#rm -rf rosserial
#cd ~/catkin_ws
#catkin_make clean
#rm -rf build/ devel/
#catkin_make
#source ~/.bashrc
# **********************************************************************

## ROS LIBRARIES
source ~/MySetup/ros/turtlebot3.sh
source ~/MySetup/ros/rplidar.sh