#!/usr/bin/bash

git status
git add .
git status

read -p "Your Commit?: " commit_name
git commit -m "${commit_name}"
git push

git status
