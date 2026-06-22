#!/usr/bin/env bash

# Stop other wallpaper daemons
killall linux-wallpaperengine 2>/dev/null

# Set your Wallpaper ID
WP_ID="3317551372"

# Option A: Span one single wallpaper across both screens (stretched)
linux-wallpaperengine --silent --layer background --screen-span DP-2,DP-3 --bg "$WP_ID" --scaling fill &

# Option B: Run separate/duplicate copies on each screen (uncomment this and comment out Option A to use)
# linux-wallpaperengine --silent --layer background --screen-root DP-2 --bg "$WP_ID" --screen-root DP-3 --bg "$WP_ID" &
