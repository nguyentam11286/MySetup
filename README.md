# MySetup for Ubuntu 18.04

## System All Setup
Read sys/setup.sh file first
```bash
source ~/MySetup/sys/setup.sh 
```
<!-- Other command: chmod 777 /MySetup/mysetup.sh && ./MySetup/my_setup.sh -->

## System Installation
Read sys/install.sh file 
```bash
source ~/MySetup/sys/install.sh 
```

## System Settings
Read sys/setting.sh file 
```bash
source ~/MySetup/sys/setting.sh 
```

## System Aliases
Read sys/alias.bash file 
```bash
echo "source ~/MySetup/sys/alias.bash" >> ~/.bashrc
```

# Application Installation 
Read app/all.sh file 
```bash
source ~/MySetup/app/all.sh 
```

## ROS Melodic Installation
Read ros/melodic.sh file \
Read test.md for ROS testing (E.g. rosserial)
```bash
source ~/MySetup/ros/melodic.sh
```

## TivaWare Installation
Read tivaware/sw-tm4c.sh file 
```bash
source ~/MySetup/tivaware/sw-tm4c.sh
```
<!-- 
## GITHUB
cd ~/MySetup
git init
git add .
git status
git commit -m "MySetup for Ubuntu 18.04"
git branch -M ubuntu-18.04
git branch
git remote add origin git@github.com:ngCuyentam11286/MySetup.git
git push -u origin ubuntu18.04

git commit -a -m "Update README.md"
git push -u origin ubuntu18.04
-->

