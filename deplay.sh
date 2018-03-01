#!/bin/bash

set -e 
echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

msg="rebuilding site `date`"
if [ $# -eq 1 ]
then msg="$1"
fi

git add -A
git commit -m "$msg"
git push origin master


echo -e "\033[0;32mDelete public folder and generate new files...\033[0m"
cd public
rm -rf $(ls)
cd .. 

hugo 


cd public
# 记得将public目录的仓库设置为 qwding.github.io

echo -e "\033[0;32mCommit new html files...\033[0m"
git add -A
git commit -m "$msg"
git push origin master
cd ..
