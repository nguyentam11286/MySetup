# Network (Run ifconfig to check the IP address)
sudo apt-get install net-tools

# Bluetooth
sudo apt-get install python-bluez
sudo apt-get install blueman

# Graphical configuration tool that allows you to 
# customize and fine-tune the GNOME desktop environment
sudo apt-get install gnome-tweaks gnome-shell-extensions

# System themes
# [Noobslab Maia] Open Tweak -> Themes 
# Applications: Adwaita-dark, Icons: Maia-Green
sudo add-apt-repository ppa:noobslab/icons
sudo apt-get update
sudo apt-get install ultimate-maia-icons

# Interactive system-monitoring tool in Ubuntu 
# Shows real-time information about:
# - CPU usage (per core)
# - RAM and swap usage
# - Running processes
# - Uptime
# - Load averages
sudo apt install htop
