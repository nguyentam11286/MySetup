# ROSSERIAL_ARDUINO
Test: Open Arduino -> Examples -> ros_lib -> Blink -> Upload code
>> roscore
>> rosrun rosserial_python serial_node.py /dev/ttyUSB0
>> rostopic pub /toggle_led std_msgs/Empty --once

# ROSSERIAL_ARDUINO
Open Energia -> Tools -> Board -> Board Manager -> Install TivaC package
Test: Open Energia -> Examples -> ros_lib -> rgb -> Upload code
>> roscore
>> sudo chmod 777 /dev/ttyACM0
>> rosrun rosserial_python serial_node.py /dev/ttyACM0
>> rostopic pub /led std_msgs/ColorRGBA 1.0 0.0 0.0 0.25
>> rostopic pub /led std_msgs/ColorRGBA 0.0 1.0 0.0 0.50
>> rostopic pub /led std_msgs/ColorRGBA 0.0 0.0 1.0 0.75
>> rostopic pub /led std_msgs/ColorRGBA "{r: 1.0, g: 0.0, b: 1.0, a: 1.0}"
>> rostopic pub /led std_msgs/ColorRGBA "{r: 0.0, g: 1.0, b: 1.0, a: 1.0}"
>> rostopic pub /led std_msgs/ColorRGBA "{r: 1.0, g: 1.0, b: 0.0, a: 1.0}"