# zn-linux  
linux study note for newbie. If you are a newbie, you can follow it to start. If you are a adept you should find some new change for centos or you can teach me some, and thank you. contact:[http://xiaoyouping.club](http://xiaoyouping.club) or 可以加qq群讨论：23592723

## 参考
* [命令集合](/command.md)  
* [讲解](/explication.md)  
* [vi命令](/vicommand.md)  
* [需要熟悉的文件或者文件夹](folderinlinux.md)  
* [shell 编程](/shell.md)  
* [不是天天用就会忘记的命令](/usuallyforget.md)

## 任务列表
* [新装CentOS7mini版本启动网卡、替换yum源](/centos7pure.md)  
* [安装GitLab Community Edition (CE)](/gitlab.md)  
* [在mac上安装mariadb](/task/install-mariadb-in-mac.md)  
* [centos下安装Tomcat](java/tomcat.md)  
* [centos下安装Redis](redis/installredis.md)  
* [centos下安装ELK](elk/installelk.md)  
* [一个搭建openstack的环境](openstack/first.md)

## Issues  
* [主机HostKey值改变导致SSH连接发出警告](/issues/SPOOFINGDetected)  
* [centos7下mariadb 首次安装的问题，修改密码及忘记密码处理方法](mysql/aboutinstall.md)
* [CentOS系统安装内核时提示/boot分区空间不足问题的解决方法](linux/bootsizenotenough.md)  

## Linux下的开发团队相关工具  
* [mattermost](tools/mattermost.md)  
* [nvm](nodejs/nvm.md)  
* [gitlab ci](gitlab/ci.md)

## 简单任务
### 添加用户
    useradd -d /home/newuser newuser 添加用户，并指定用户文件夹路径  
    passwd username 给这个用户设置密码  
    mkdir -p /home/newuser 给新用户创建用户目录  
    chown newuser:newuser /home/newuser 将拥有者改成新用户本身  

### 原理

Linux下如何创建新用户通常情况下，处于安全考虑，一般都给自己创建一个普通用户，而不直接使用root用户，因为权限大了，误操作就容易带来无法弥补的损失。Linux系统中，只有root用户有创建其他用户的权限。
基本步骤如下：  
1. 用户的主目录和用户名  
2. 显式设定密码  
3. 使用root账户创建新用户的主目录
4. Linux系统需要主目录的拥有者必须是用户本身，因此，使用root创建主目录以后，还需将拥有者更换成新用户本身  


```
git push -u origin master
```