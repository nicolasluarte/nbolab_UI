#!/bin/bash

IPS="$HOME/nbolab_UI/mainUI/data/linux_scripts/raspberrypi.txt"

#             #
# SERVER SIDE #
#             #
# Create the folder
mkdir -p $HOME/nbolab_EXPERIMENTS
# give permissions
sudo chmod 777 $HOME/nbolab_EXPERIMENTS
# setup exports
sudo bash -c 'echo "/home/nicoluarte/nbolab_EXPERIMENTS *(rw,sync,no_subtree_check)" > /etc/exports'
# make the exports
sudo exportfs -arvf
# enable and start service
sudo systemctl enable nfs-server.service
sudo systemctl start nfs-server.service

#             #
# CLIENT SIDE #
#             #
# do this with internet
# parallel --tag --nonall --slf raspberrypi.txt sudo apt-get update
# parallel --tag --nonall --slf raspberrypi.txt sudo apt-get install nfs-common
parallel --tag --nonall --slf $IPS mkdir -p /home/pi/nbolab_EXPERIMENTS
parallel --tag --nonall --slf $IPS sudo mount 192.168.50.10:/home/nicoluarte/nbolab_EXPERIMENTS 	/home/pi/nbolab_EXPERIMENTS

# setup folders
mkdir -p $HOME/nbolab_EXPERIMENTS/pi0/{preview_cam,cam_test,data_cam,data_lickometer,background}
mkdir -p $HOME/nbolab_EXPERIMENTS/pi1/{preview_cam,cam_test,data_cam,data_lickometer,background}
mkdir -p $HOME/nbolab_EXPERIMENTS/pi2/{preview_cam,cam_test,data_cam,data_lickometer,background}
mkdir -p $HOME/nbolab_EXPERIMENTS/pi3/{preview_cam,cam_test,data_cam,data_lickometer,background}
