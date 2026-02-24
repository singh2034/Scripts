#!/usr/bin/bash
# NOTE :- -eq or anything like that are for numbers comparision for string comparision we use real symbols like = or like this

read -p "Enter a number : " mynum

if [ $mynum -eq 200 ]; then
	echo "Condition is True"
else
	echo "Condition is False"	
fi
