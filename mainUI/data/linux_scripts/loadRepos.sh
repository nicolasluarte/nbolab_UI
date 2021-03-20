#!/bin/sh

# requires GNU parallel

PIPATH="$HOME/nbolab_UI/mainUI/data/linux_scripts/raspberrypi.txt"

parallel --tag --nonall --slf $PIPATH rm -rf nbolab_*
parallel --tag --nonall --slf $PIPATH git clone https://github.com/nicolasluarte/nbolab_UI.git
parallel --tag --nonall --slf $PIPATH git clone https://github.com/nicolasluarte/nbolab_LICKOMETER.git
parallel --tag --nonall --slf $PIPATH git clone https://github.com/nicolasluarte/nbolab_FED.git
parallel --tag --nonall --slf $PIPATH git clone https://github.com/nicolasluarte/nbolab_track.git
