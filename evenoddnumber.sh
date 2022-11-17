#!/bin/bash
#Evenoddnumber script
#This script will tell you if your number is odd or even
#Authors: Sarah B, Jeff H, Neethu V, Kra K, Durga G
#Date 11/17/2022
#Specials instructions: N/A
read -p "Enter a number and I will check if its odd or even " mynumber
#If the number divided by 2 has a remainder of 0 then do this, otherwise do this
if [ $((mynumber%2)) -eq 0 ]
then
echo "Your number is even"
else
echo "Your number is odd."
fi
