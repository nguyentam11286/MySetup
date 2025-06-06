## ROSSERIAl 
# Install rosserial_arduino binary and rosserial_tivaC from source
sudo apt-get install ros-melodic-rosserial ros-melodic-rosserial-arduino
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
#cd ~/catkin_ws/src/libraries
#git clone -b melodic-devel https://github.com/ros-drivers/rosserial.git 
#cd ~/catkin_ws
#catkin_make
#catkin_make --only-pkg-with-deps rosserial_arduino
#catkin_make --only-pkg-with-deps rosserial_tivac

# Prepare rosserial libraries for Arduino 
#cd ~/Arduino/libraries
#rm -rf ros_lib
#rosrun rosserial_arduino make_libraries.py .

# Prepare rosserial libraries for Energia
#cd ~/Energia/libraries
#rm -rf ros_lib
#rosrun rosserial_tivac make_libraries_energia .

# Remove rosserial packages from source
#cd ~/catkin_ws/src/libraries 
#rm -rf rosserial
#cd ~/catkin_ws
#catkin_make clean
#rm -rf build/ devel/
#catkin_make
#source ~/.bashrc