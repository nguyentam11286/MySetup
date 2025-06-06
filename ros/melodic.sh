## OFFICIAL WEBSTIE: 
# http://wiki.ros.org/melodic/Installation/Ubuntu

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