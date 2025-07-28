#!/bin/bash

# Wait for GNOME to fully start
sleep 5	

# Open Files & Terminal			
nautilus &            		
terminator &

# Wait for windows to open    		
sleep 2				

# Move Files & Terminal to workspace 1
wmctrl -r "Files" -t 0		
wmctrl -r "Terminator" -t 0

# Get screen size
SCREEN_WIDTH=$(xdotool getdisplaygeometry | awk '{print $1}')
SCREEN_HEIGHT=$(xdotool getdisplaygeometry | awk '{print $2}')
HALF_WIDTH=$((SCREEN_WIDTH / 2))

# Get window name and id
#for id in $(xdotool search --onlyvisible --name ".*"); do
#  class=$(xprop -id $id | grep "WM_CLASS" | awk -F '"' '{print $2}')
#  name=$(xdotool getwindowname $id)
#  echo "$id - $class - $name"
#done
# wmctrl -l

# Position Files & Terminal
# OPTION 1: wmctrl -r "Window Name" -e <gravity>,<X>,<Y>,<Width>,<Height>
#wmctrl -r "Home" -e 0,0,0,785,534
#wmctrl -r "parallels@ubuntu: ~" -e 0,0,495,790,550

# OPTION 2: xdotool search --name "Terminal Window Title" windowmove X Y windowsize WIDTH HEIGHT
#xdotool windowmove 52428807 100 200 windowsize 52428807 800 600
FILE_ID=$(xdotool search --onlyvisible --class "nautilus" | head -n 1)
TERMINATOR_ID=$(xdotool search --onlyvisible --class "terminator" | head -n 1)
if [ -n "$FILE_ID" ]; then
    xdotool windowmove $FILE_ID 0 0
    xdotool windowsize $FILE_ID 785 534
fi
if [ -n "$TERMINATOR_ID" ]; then
    xdotool windowmove $TERMINATOR_ID 0 515
    xdotool windowsize $TERMINATOR_ID 735 445
fi

# Wait for a little bit    		
sleep 2	

# Open VSCode in Workspace 2
code &
sleep 2

# Move to workspace 2
wmctrl -r "Visual Studio Code" -t 1  
sleep 2 

# Fullscreen
xdotool search --name "Visual Studio Code" windowactivate --sync windowsize %@ 100% 100%
