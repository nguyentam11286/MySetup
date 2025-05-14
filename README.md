# MySetup for Ubuntu 18.04

## System Full Setup 
Read sys/setup.sh file.
```bash
source ~/MySetup/sys/setup.sh 
```
<!-- Other command: chmod 777 /MySetup/mysetup.sh && ./MySetup/my_setup.sh -->

## System Installation
Read sys/install.sh file.
```bash
source ~/MySetup/sys/install.sh 
```

## System Configuration
Read sys/config.sh file. 
```bash
source ~/MySetup/sys/config.sh 
```

## Application Installation 
Read app/all.sh file. 
```bash
source ~/MySetup/app/all.sh 
```

## ROS Melodic Installation
Read ros/melodic.sh file. \
Read ros/README.md for ROS tutorials (E.g. rosserial).
```bash
source ~/MySetup/ros/melodic.sh
```

## TivaWare Installation
Read tivaware/sw-tm4c.sh file.
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
git push -u origin ubuntu-18.04

git commit -a -m "Update README.md"
git push -u origin ubuntu-18.04
-->

