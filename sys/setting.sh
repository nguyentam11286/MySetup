# Disable Lock Screen
gsettings set org.gnome.desktop.screensaver lock-enabled false

# Power -> Power Saving -> Blank screen -> Never
gsettings set org.gnome.desktop.session idle-delay 0

# Power -> Suspend -> Automatic suspend -> Off
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'

# Keyboard Shortcut -> Move to workspace above, Move to workspace below
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Ctrl><Alt>Up']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Ctrl><Alt>Down']"

# Hide desktop icons
gsettings set org.gnome.desktop.background show-desktop-icons false

# Minimize windows
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'





