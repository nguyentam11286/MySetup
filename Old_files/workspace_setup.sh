#!/bin/bash

# Wait for GNOME to fully start
sleep 5	

# Open Files, Terminator & Visual Studio Code	
code &
nautilus &            		
terminator -T "Terminator" -l layout_4 &
terminator -T "Communication" -l layout_6 &

# Wait for windows to open    		
sleep 5

# Get screen size
SCREEN_WIDTH=$(xdotool getdisplaygeometry | awk '{print $1}')
SCREEN_HEIGHT=$(xdotool getdisplaygeometry | awk '{print $2}')
SMALL_WIDTH=$((SCREEN_WIDTH / 2))
SMALL_HEIGHT=$((SCREEN_HEIGHT / 2))

# Wait some time  
sleep 2

# Get window name and id
#for id in $(xdotool search --onlyvisible --name ".*"); do
#  class=$(xprop -id $id | grep "WM_CLASS" | awk -F '"' '{print $2}')
#  name=$(xdotool getwindowname $id)
#  echo "$id - $class - $name"
#done
#wmctrl -l

# Position Files & Terminal
# OPTION 1: 
# wmctrl -r "Window Name" -e <gravity>,<X>,<Y>,<Width>,<Height>
#wmctrl -r "Home" -e 0,0,0,785,534
#wmctrl -r "parallels@ubuntu: ~" -e 0,0,495,790,550

# OPTION 2: 
# xdotool search --name "Terminal Window Title" windowmove X Y windowsize WIDTH HEIGHT
#xdotool windowmove 39845892 -17 -25 windowsize 39845892 950 665
#xdotool windowmove 10485767 0 0 windowsize 10485767 1728 1080
#xdotool windowmove 56623108 0 0 windowsize 56623108 1728 1080

# OPTION 3: 
CODE_ID=$(xdotool search --onlyvisible --class "code" | head -n 1)
FILE_ID=$(xdotool search --onlyvisible --class "nautilus" | head -n 1)
TERM4_ID=$(xdotool search --onlyvisible --name "Terminator" | head -n 1)
TERM6_ID=$(xdotool search --onlyvisible --name "Communication" | head -n 1)

if [ -n "$CODE_ID" ]; then
    xdotool windowmove $CODE_ID 0 0
    #xdotool windowsize $CODE_ID 950 1050
    xdotool windowsize $CODE_ID $SCREEN_WIDTH $SCREEN_HEIGHT
    wmctrl -i -r $CODE_ID -t 0	
fi
sleep 2
if [ -n "$FILE_ID" ]; then
    xdotool windowmove $FILE_ID -100 -100
    #xdotool windowsize $FILE_ID 850 605
    xdotool windowsize $FILE_ID $((SMALL_WIDTH + 190)) $((SMALL_HEIGHT + 230))	
    wmctrl -i -r $FILE_ID -t 1 
    wmctrl -i -r $FILE_ID -b add,above
fi
sleep 2
if [ -n "$TERM4_ID" ]; then
    #xdotool windowmove $TERM4_ID 0 520
    #xdotool windowsize $TERM4_ID 726 515
    xdotool windowmove $TERM4_ID 0 0
    xdotool windowsize $TERM4_ID $SCREEN_WIDTH $SCREEN_HEIGHT
    wmctrl -i -r $TERM4_ID -t 1	
fi
sleep 2
if [ -n "$TERM6_ID" ]; then
    #xdotool windowmove $TERM6_ID 0 520
    #xdotool windowsize $TERM6_ID 726 515
    xdotool windowmove $TERM6_ID 0 0
    xdotool windowsize $TERM6_ID $SCREEN_WIDTH $SCREEN_HEIGHT	
    wmctrl -i -r $TERM6_ID -t 2
fi