#!/usr/bin/bash

echo "Calculator in Linux Terminal"

echo " "
read -p "Enter Number 1 : " num1

echo " "
read -p "Enter Operator (+, -, x, /) : " opr

echo " "
read -p "Enter Number 2 : " num2

#Addition
if [ "$opr" = "+" ]; then
	result=$((num1 + num2))
	echo "$num1 $opr $num2 = $result"
fi

#Subtraction
if [ "$opr" = "-" ]; then
	result=$((num1 - num2))
	echo "$num1 $opr $num2 = $result"
fi

#Multiplication
if [ "$opr" = "x" ] || [ "$opr" = "*" ]; then
	result=$((num1 * num2))
	echo "$num1 $opr $num2 = $result"
fi

#Division
if [ "$opr" = "/" ]; then
	result=$((num1 / num2))
	echo "$num1 $opr $num2 = $result"
fi
