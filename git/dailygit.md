git tag -d v2016062101 删除本地tag

git push origin --delete tag v2016062101 删除远程tag

git branch -r 查看所有远程分支

拉取远程分支并创建本地分支   
方法一：  
git checkout -b 本地分支名x origin/远程分支名x  
方法二：  
git fetch origin 远程分支名x:本地分支名x
