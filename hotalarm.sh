#!/bin/bash


showMsg=0;

while [[ 1 ]]; do

	status=$(sensors | grep "Core");

	echo "$status" | while read line; do

		line=${line#*:};
		line=${line%(*};
		line=${line%.*};
		temp=${line#*+};

		if [[ $temp -ge 70 ]]; then
			shutdown now;
			exit;
		fi

		if [ $temp -ge 60 ] && [ $showMsg -ne 1 ]; then
			notify-send "Attention surchauffe" "Température du processeur excessive $temp°C";
			showMsg=1;
		fi

		if [[ $temp -le 50 ]]; then
			showMsg=0;
		fi

	done

	sleep 5;
done
