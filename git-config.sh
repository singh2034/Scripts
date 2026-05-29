!#/usr/bin/bash

sudo apt update && sudo apt upgrade -y
sudo apt install git -y && git -v

git config --global user.name "singh2034" 
git config --global user.email "singhaayush2034@gmail.com"

ssh-keygen -t ed25519 -C "singhaayush2034@gmail.com"

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

cat ~/.ssh/id_ed25519.pub

