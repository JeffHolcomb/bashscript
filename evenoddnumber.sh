#!/bin/bash
#Evenoddnumber script
#This script will tell you if your number is odd or even
#Authors: Sarah B, Jeff H, Neethu V, Kra K, Durga G
#Date 11/17/2022
#Specials instructions: N/A
#Source: https://www.hostinger.com/tutorials/bash-script-example#18_Read_Files
read -p "Enter a number and I will check if its odd or even " mynumber
re='^[0-9]+$'
if [[ $mynumber =~ $re ]] ; then
  if [ $((mynumber%2)) -eq 0 ]; then
	echo "Your number is even"
  else
	echo "Your number is odd."
  fi
else
	echo "You must enter a digit"
fi
