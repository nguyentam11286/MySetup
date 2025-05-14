## NVIDIA SDK MANAGER
# https://developer.nvidia.com/sdk-manager

## DOWNLOAD PACKAGE
VERSION=1.85.2-12028_amd64
wget https://developer.download.nvidia.com/sdk-manager/sdkmanager_$VERSION.deb

## INSTALL DEPENDENCIES
cd ~/Downloads
sudo apt update
sudo apt install -y ./sdkmanager_*.deb

# Other commands if the above doesn't work: 
# sudo dpkg -i sdkmanager_*.deb && sudo apt-get install -f

## LAUNCH NVIDIA SDK MANAGER
#sdkmanager
#sdkmanager --ui

# Log in with your NVIDIA Developer account credentials

## FACTORY RESET JETSON NANO
# Power off the Jetson & connect it to PC via Micro-USB.
# Hold RECOVERY button → while holding it, power on the Jetson → then release RECOVERY.

# On your Ubuntu PC, check if Jetson is detected:
# lsusb
# You should see something like 0955:7f21 NVIDIA Corp.

# For Jetson Nano Development Kit
#cd ~/nvidia/nvidia_sdk/JetPack_4.6.6_Linux_JETSON_NANO_TARGETS/Linux_for_Tegra/
#sudo ./flash.sh jetson-nano-devkit mmcblk0p1

# For Jetson Nano EMMC 16GB
#cd ~/nvidia/nvidia_sdk/JetPack_4.6.6_Linux_JETSON_NANO_TARGETS/Linux_for_Tegra/
#sudo ./flash.sh jetson-nano-emmc mmcblk0p1