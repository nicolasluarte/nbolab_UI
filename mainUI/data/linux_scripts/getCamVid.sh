#!/bin/bash

IPS="$HOME/nbolab_UI/mainUI/data/linux_scripts/raspberrypi.txt"

# cam preview
parallel --tag --nonall --slf $IPS 'raspivid -o /home/pi/nbolab_EXPERIMENTS/$(uname -n)/cam_test/$(uname -n).h264'
