#!/bin/bash

###########################################################
#### This script listens to the command "bye" #############
######## if its between 5pm to 12 am ######################
########## send report & shutdown #########################
#1. Do vnstat -d and store in var
reciever="thiyagarajanravi22@gmail.com"
today="$(date '+%d-%m-%Y') -report"
result=$(vnstat -d)
root_loc="/home/hadoop-thiyagu/network_status"
echo "$result" > $root_loc/reports/"$today.txt"

#2 Do store the image
vnstati -s -o $root_loc/visualizer/"$today.png"

#3 Lets send report if it is between 5pm to 12 am
time_now=`date +"%H%M%S"`
checkout_start="170000"
checkout_end="240000"

if [ $time_now -ge $checkout_start ] && [ $time_now -le $checkout_end ]
then
	mutt -s "$today" $reciever < $root_loc/reports/"$today.txt" -a $root_loc/visualizer/"$today.png"
	echo "report sent"
fi

###always trigger shutdown when listens to bye

#4 schedule shutdown after 2 minutes
shutdown +2
