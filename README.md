# SYSTEM ALL SETUP 
Note: Read setup.sh file first
>> source ~/MySetup/sys/setup.sh 
<!-- Other command: chmod 777 /MySetup/mysetup.sh && ./MySetup/my_setup.sh -->

# SYSTEM INSTALLATION
Note: Read install.sh file 
>> source ~/MySetup/sys/install.sh 

# SYSTEM SETTINGS
Note: Read setting.sh file 
>> source ~/MySetup/sys/setting.sh 

# SYSTEM ALIASES
Note: Read alias.bash file 
>> echo "source ~/MySetup/sys/alias.bash" >> ~/.bashrc

# APPLICATION INSTALLATION (ALL)
Note: Read all.sh file 
>> source ~/MySetup/app/all.sh 

## ROS MELODIC INSTALLATION
Note: Read melodic.sh file 
Note: Read test.md for ROS testing (E.g. rosserial)
>> source ~/MySetup/ros/melodic.sh

## TIVAWARE INSTALLATION
Note: Read tivaware.sh file 
>> source ~/MySetup/tivaware/sw-tm4c.sh