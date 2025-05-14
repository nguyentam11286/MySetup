# ROS Tutorials

## rosserial_arduino
Open Arduino IDE \
In File -> Examples -> ros_lib -> Blink \
In Tools -> Board -> Select Arduino Uno -> Upload code
```bash
roscore
rosrun rosserial_python serial_node.py /dev/ttyUSB0
```
\
Publish message to /toggle_led topic to toggle state of LED.
```bash
rostopic pub /toggle_led std_msgs/Empty --once
```

## rosserial_tivac
Open Energia IDE \
In File -> Examples -> ros_lib -> rgb -> Upload code \
In Tools -> Board -> Board Manager -> Install TivaC package  \
After installation complete, select TM4C123GXL (80MHz) -> Upload code
```bash 
roscore
sudo chmod 777 /dev/ttyACM0
rosrun rosserial_python serial_node.py /dev/ttyACM0
```
\
Publish message to /led topic to change color of LED.
```bash
rostopic pub /led std_msgs/ColorRGBA 1.0 0.0 0.0 0.25
rostopic pub /led std_msgs/ColorRGBA 0.0 1.0 0.0 0.50
rostopic pub /led std_msgs/ColorRGBA 0.0 0.0 1.0 0.75
rostopic pub /led std_msgs/ColorRGBA "{r: 1.0, g: 0.0, b: 1.0, a: 1.0}"
rostopic pub /led std_msgs/ColorRGBA "{r: 0.0, g: 1.0, b: 1.0, a: 1.0}"
rostopic pub /led std_msgs/ColorRGBA "{r: 1.0, g: 1.0, b: 0.0, a: 1.0}"
'''