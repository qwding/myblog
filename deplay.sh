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

cd public
rm -rf $(ls)
cd .. 

hugo 

cp CNAME public/CNAME

cd public
git add -A
git commit -m "$msg"
git push origin master
cd ../myblog