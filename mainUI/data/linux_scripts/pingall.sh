#!/bin/bash

cat $HOME/nbolab_UI/mainUI/data/ip.txt | while read output
do
	ping -c 1 "$output" > /dev/null
	if [ $? -eq 0 ]; then
		printf "1\n"
	else
		printf "0\n"
	fi
done  | paste -sd "," > tmp

mv tmp $HOME/nbolab_UI/mainUI/data/pingCheck.csv
