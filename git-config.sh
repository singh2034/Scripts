!#/usr/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt install git -y && git -v

git config --global user.name "username" 
git config --global user.email "email"

ssh-keygen -t ed25519 -C "email"

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

cat ~/.ssh/id_ed25519.pub

