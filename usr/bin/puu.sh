#!/bin/dash
puush /tmp/screenshot.png | grep --color=never http | xclip -selection clipboard 
rm /tmp/screenshot.png 
