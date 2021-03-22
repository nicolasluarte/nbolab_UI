#!/bin/bash

IPS="$HOME/nbolab_UI/mainUI/data/linux_scripts/raspberrypi.txt"

# NFS
parallel --tag --nonall --slf $IPS sudo apt-get update
parallel --tag --nonall --slf $IPS sudo apt-get install nfs-common
# for opencv to work
parallel --tag --nonall --slf $IPS sudo apt-get install -y libatlas-base-dev libhdf5-dev libhdf5-serial-dev libatlas-base-dev libjasper-dev  libqtgui4  libqt4-test

# Processing
parallel --tag --nonall --slf $IPS sudo apt-get install git

# Arduino

# Git

# neovim

# 
