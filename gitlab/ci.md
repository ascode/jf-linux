# gitlab ci  

1. 安装好gitlab  
2. 安装gitlab-runner  
```
# For Debian/Ubuntu
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.deb.sh | sudo bash

# For RHEL/CentOS
curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-ci-multi-runner/script.rpm.sh | sudo bash
```

```
# For Debian/Ubuntu
sudo apt-get install gitlab-ci-multi-runner

# For RHEL/CentOS
sudo yum install gitlab-ci-multi-runner
```

参考网址：https://docs.gitlab.com/runner/install/linux-repository.html  

3. 注册gitlab-runner  
```
sudo gitlab-ci-multi-runner register

Please enter the gitlab-ci coordinator URL (e.g. https://gitlab.com )
https://gitlab.com
Please enter the gitlab-ci token for this runner
xxx
Please enter the gitlab-ci description for this runner
my-runner
INFO[0034] fcf5c619 Registering runner... succeeded
Please enter the executor: shell, docker, docker-ssh, ssh?
docker
Please enter the Docker image (eg. ruby:2.1):
ruby:2.1
INFO[0037] Runner registered successfully. Feel free to start it, but if it's
running already the config should be automatically reloaded!
```

4. 更新gitlab-runner   
```
# For Debian/Ubuntu
sudo apt-get update
sudo apt-get install gitlab-ci-multi-runner

# For RHEL/CentOS
sudo yum update
sudo yum install gitlab-ci-multi-runner
```

5. 编写.gitlab-ci.yml  
stages:
- deploy
deploy:
  stage: deploy
  script:
    - deploy ascode sexyhub
  only:
    - master
  tags:
    - sexyhub_deploy  

如上script中使用的deploy ascode sexyhub，其中deploy是放置在gitlab-runner账号路径下的.local文件夹里面的bash文件：  
deploy:
```
#!/bin/bash
if [ $# -ne 2 ]
then
      echo "arguments error!"
      exit 1
else
      deploy_path="/data/web/$1/$2"
      if [ ! -d "$deploy_path" ]
      then
              project_path="git@gitlab.bgenius.cn:$1/$2.git"
              git clone $project_path $deploy_path
      else
              cd $deploy_path
              echo 'cd $deploy_path'
              git pull
              echo 'git pull success'
              npm install
              echo 'npm install success'
      fi
fi
```

注意：由以上文件我们可以看到这里是在bash脚本中使用git clone命令下载部署代码。那么这里就要求git clone命令不需要输入密码。  

6. git clone 免密码  
(1) 使用https  

使用https需要在~/.netrc中预先保存好账号密码：
```
machine ***.bgenius.cn
login as***
password w***
```
这种方法有一个弊端，就是明文保存账号密码。  

(2) 使用ssh  
生成ssh密钥对：  
```
ssh-keygen -t rsa -C "your_email@example.com"
```
