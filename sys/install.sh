# NETWORK
# Run ifconfig to check the IP address
sudo apt-get install net-tools

# BLUETOOTH
sudo apt-get install python-bluez
sudo apt-get install blueman

## TWEAK
# Graphical configuration tool that allows you to 
# customize and fine-tune the GNOME desktop environment
sudo apt-get install gnome-tweaks gnome-shell-extensions

## SYSTEM THEMES
# [Noobslab Maia] Open Tweak -> Themes 
# Applications: Adwaita-dark, Icons: Maia-Green
sudo add-apt-repository ppa:noobslab/icons
sudo apt-get update
sudo apt-get install ultimate-maia-icons

# SYSTEM MONITOR
# Interactive system-monitoring tool in Ubuntu 
# Shows real-time information about:
# - CPU usage (per core)
# - RAM and swap usage
# - Running processes
# - Uptime
# - Load averages
sudo apt install htop
