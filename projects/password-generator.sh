#!/usr/bin/bash

#simple password generator

echo "Welcome to simple password generator"

read -p "For which account you have to generate the password (i.e. Instagram, Snapchat, Google...) : " app_name
read -p "Please enter the length of the password (i.e. 6,8,12...) : " pass_length

for i in $( seq 1 ); do
	password=$(openssl rand -base64 48 | cut -c1-$pass_length)
	echo "$password"
done

echo "$app_name - $password - $pass_length" >> ~/Documents/Study/scripting/password.txt
chmod 700 ~/Documents/password.txt
