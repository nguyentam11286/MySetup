## IMU BNO055
sudo apt-get install libi2c-dev
sudo apt-get install ros-melodic-rviz-imu-plugin

cd ~/catkin_ws/src/libraries
git clone https://github.com/dheera/ros-imu-bno055.git imu_bno055
cd ~/catkin_ws
catkin_make --only-pkg-with-deps imu_bno055
cd

# Test package
#roslaunch imu_bno055 imu.launch
#rostopic echo /imu/data

# fixed frame: imu, add imu in rviz_imu_plugin, change topic to imu/data
#rviz 