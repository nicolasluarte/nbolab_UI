#!/bin/bash

IPS="$HOME/nbolab_UI/mainUI/data/linux_scripts/raspberrypi.txt"

# NFS
parallel --tag --nonall --slf $IPS sudo apt-get update
parallel --tag --nonall --slf $IPS sudo apt-get install nfs-common

# Processing
parallel --tag --nonall --slf $IPS sudo apt-get install git

# Arduino

# Git

# neovim

# 
