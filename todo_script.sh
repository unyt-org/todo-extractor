#!/bin/bash
set -e
echo "Entry point of todo extraction"

if [[ "$#" != 0 ]]; then
	echo "No CLA please."
	exit 1
fi

echo "Quick check..."
lscpu
free -h 
df -h

echo "Python check..."
python --version
pip install --upgrade pip
pip install numpy
pip list

echo "Running main"
python main.py

if [[ "$?" != 0 ]]; then
	echo "main.py execution failed."
	exit 1
fi

git config list

git config --global user.name "github-actions"
git config --global user.email "github-actions@github.com"

git add README.md

if git diff --cached --quiet; then
	echo "No changes to commit."
	exit 0
else
	echo "Commit"
	git commit -m "auto update readme"
	echo "push"
	git push
fi

