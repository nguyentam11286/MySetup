## TURTLESIM TUTORIALS
ROS offical website: https://docs.ros.org/en/humble/Tutorials.html

# INTRODUCTION
Turtlesim is a lightweight simulator.

# INSTALLATION
>> sudo apt update && sudo apt install ros-humble-turtlesim
>> ros2 pkg executables turtlesim

# DEMO NODES
>> ros2 run turtlesim turtlesim_node
>> ros2 run turtlesim turtle_teleop_key

# ROS2 TOOLS
>> ros2 node list
>> ros2 topic list
>> ros2 service list
>> ros2 action list

# ROS2 NODES
Node responsible for a single, modular purpose.
>> ros2 run turtlesim turtlesim_node --ros-args --remap __node:=my_turtle
>> ros2 node list

Return a list of subscribers, publishers, services, actions interact with node.
>> ros2 node info /my_turtle
>> ros2 node info /teleop_turtle

# ROS2 TOPICS
Topics are based on publisher-subscriber model for node communication.
>> ros2 topic list
>> ros2 topic list -t
>> ros2 topic echo /turtle1/pose
>> ros2 topic echo /turtle1/cmd_vel
>> ros2 topic info /turtle1/cmd_vel
>> ros2 interface show geometry_msgs/msg/Twist

Publish data to a topic: ros2 topic pub [topic_name] [msg_type] '[args]'
--once: publish one, -w 2: wait for two matching subscriptions
>> ros2 topic pub --once -w 2 /turtle1/cmd_vel geometry_msgs/msg/Twist "{linear: {x: 2.0, y: 0.0, z: 0.0}, angular: {x: 0.0, y: 0.0, z: 1.8}}"

With no command-line options, ros2 topic pub publishes the command in a steady stream at 1 Hz.
>> ros2 topic pub /turtle1/cmd_vel geometry_msgs/msg/Twist "{linear: {x: 2.0, y: 0.0, z: 0.0}, angular: {x: 0.0, y: 0.0, z: 1.8}}"

Publishing messages with timestamps (automatically fill them with the current time).
>> ros2 topic pub /pose geometry_msgs/msg/PoseStamped '{header: "auto", pose: {position: {x: 1.0, y: 2.0, z: 3.0}}}'

If the message does not use a full header, but just has a field with type.
>> ros2 topic pub /reference sensor_msgs/msg/TimeReference '{header: "auto", time_ref: "now", source: "dumy"}'

>> ros2 topic hz /turtle1/pose
>> ros2 topic bw /turtle1/pose

List of available topics of a given type
>> ros2 topic find geometry_msgs/msg/Twist

# ROS2 SERVICES
Services are based on a call-and-response model for node communication.
>> ros2 service list
>> ros2 service list -t
>> ros2 service type /clear

List of available services of a given type
>> ros2 service find std_srvs/srv/Empty
>> ros2 interface show std_srvs/srv/Empty
>> ros2 interface show turtlesim/srv/Spawn
>> ros2 service call /clear std_srvs/srv/Empty
>> ros2 service call /spawn turtlesim/srv/Spawn "{x: 2, y: 2, theta: 0.2, name: ''}"

# ROS2 PARAMETERS
A parameter is a configuration value of a node. 
>> ros2 param list
>> ros2 param get /turtlesim background_g
>> ros2 param set /turtlesim background_r 150
>> ros2 param dump /turtlesim > turtlesim.yaml
>> ros2 param load /turtlesim turtlesim.yaml

To start the node using your saved parameter values
>> ros2 run turtlesim turtlesim_node --ros-args --params-file turtlesim.yaml

# ROS2 ACTIONS
Action is similar to services, except actions can be canceled. 
Consist of three parts: a goal, feedback, and a result.
>> ros2 action list
>> ros2 action list -t

List of actions a node provides.
>> ros2 node info /turtlesim
>> ros2 node info /teleop_turtle
>> ros2 action info /turtle1/rotate_absolute

The structure of the action type.
>> ros2 interface show turtlesim/action/RotateAbsolute

Send an action goal: ros2 action send_goal [action_name] [action_type] [values]
>> ros2 action send_goal /turtle1/rotate_absolute turtlesim/action/RotateAbsolute "{theta: 1.57}"

To see the feedback of this goal, add --feedback.
>> ros2 action send_goal /turtle1/rotate_absolute turtlesim/action/RotateAbsolute "{theta: -1.57}" --feedback

# RQT
rqt is a graphical user interface (GUI) tool for ROS 2.
>> sudo apt update && sudo apt install '~nros-humble-rqt*'
>> rqt  
[Plugins | Services | Service Caller]
[Service: /turtle1/set_pen, r: 255, g: 0, b: 0, width: 5, off: 0, Call]
[Service: /spawn, x: 1.0, y: 1.0, z: 1.0, name: 'turtle2', Call]
>> ros2 run turtlesim turtle_teleop_key --ros-args --remap turtle1/cmd_vel:=turtle2/cmd_vel

# RQT_GRAPH
rqt_graph visualize the changing & connections between nodes and topics.
>> rqt_graph

# RQT_CONSOLE
Collect log messages over time, view them closely and in a more organized manner, 
filter them, save them and even reload the saved files to introspect at a different time.
>> ros2 run rqt_console rqt_console
>> ros2 topic pub -r 1 /turtle1/cmd_vel geometry_msgs/msg/Twist "{linear: {x: 2.0, y: 0.0, z: 0.0}, angular: {x: 0.0,y: 0.0,z: 0.0}}"

ROS 2’s logger levels: Fatal > Error > Warn > Info > Debug
To set default logger level for a node.
>> ros2 run turtlesim turtlesim_node --ros-args --log-level WARN

# ROS2 LAUNCH
The launch file here is written in Python, but you can also use XML and YAML.
>> ros2 launch turtlesim multisim.launch.py
>> ros2 topic pub  /turtlesim1/turtle1/cmd_vel geometry_msgs/msg/Twist "{linear: {x: 2.0, y: 0.0, z: 0.0}, angular: {x: 0.0, y: 0.0, z: 1.8}}"
>> ros2 topic pub  /turtlesim2/turtle1/cmd_vel geometry_msgs/msg/Twist "{linear: {x: 2.0, y: 0.0, z: 0.0}, angular: {x: 0.0, y: 0.0, z: -1.8}}"

# ROS2 BAG
Record data published on topics in your system and saves it in a database.
>> mkdir bag_files && cd bag_files
>> ros2 topic list

To record the data published to a topic: ros2 bag record [topic_name]
Generate rosbag2_year_month_day-hour_minute_second.bag and a metadata.yaml
>> ros2 bag record /turtle1/cmd_vel

To record multiple topics with a bag file name 'subset'.
>> ros2 bag record -o subset /turtle1/cmd_vel /turtle1/pose

To see recording details: ros2 bag info [bag_file_name]
>> ros2 bag info subset

>> ros2 bag play subset
>> ros2 topic hz /turtle1/pose


























