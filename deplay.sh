#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

msg="rebuilding site `date`"
if [ $# -eq 1 ]
then msg="$1"
fi

cd public
rm -r $(ls)
cd ..

hugo 

cd public
git add -A
git commit -m "$msg"
git push origin master
cd ../
