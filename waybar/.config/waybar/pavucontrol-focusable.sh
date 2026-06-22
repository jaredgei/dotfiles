#!/usr/bin/env bash

# Check if pavucontrol is already running
if pgrep -x "pavucontrol" > /dev/null; then
    killall pavucontrol
    exit 0
fi

# Launch pavucontrol in the background
pavucontrol &
PA_PID=$!

# Wait for pavucontrol to appear and get focused
has_focused=false
for i in {1..10}; do
    # Check if the process is still running
    if ! kill -0 $PA_PID 2>/dev/null; then
        exit 0
    fi
    
    active_class=$(hyprctl activewindow -j | jq -r '.class')
    if [ "$active_class" = "org.pulseaudio.pavucontrol" ]; then
        has_focused=true
        break
    fi
    sleep 0.1
done

# If it focused, monitor for focus loss or process exit
if [ "$has_focused" = true ]; then
    while kill -0 $PA_PID 2>/dev/null; do
        active_class=$(hyprctl activewindow -j | jq -r '.class')
        if [ "$active_class" != "org.pulseaudio.pavucontrol" ]; then
            # Lost focus! Kill it.
            kill $PA_PID 2>/dev/null
            break
        fi
        sleep 0.1
    done
fi
