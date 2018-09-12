#!/bin/bash
if [ $# -ne 2 ]
then
      echo "arguments error!"
      exit 1
else
      build_path="/data/web/builddir/$1/$2/master"
      if [ ! -d "$build_path" ]
      then
              project_path="http://ascode@vosung.bgenius.cn/$1/$2.git"
              git clone $project_path $build_path
      else
              cd $build_path
              echo 'cd $build_path'
              git reset --hard
              git pull origin master
              echo 'git pull success'
              nvm use v8.11.2
              npm install
              echo 'npm install success'
                npm run innertest
                echo '生成产品成功'
                #mv ./dist/* /data/web/websitedir/$1/$2/master-site/app/
                sshpass -v -p 'Vosung123' scp -r ./dist/* deployer1@192.168.2.247:/data/web/websitedir/$1/$2/master-site/app/
                echo '移动文件到./dist/* /data/web/websitedir/$1/$2/master-site/app/成功'
      fi
fi