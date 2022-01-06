# 美宸时科运维手册 

本手册试用于参与武汉美宸时科科技有限公司提供的软件系统的运维、实施人员试用。如有疑问，请扫码联系公司客服。

## 部署说明书
* [场内物流收货道口电子屏显示系统部署说明](/deploy/dock.md)
* [乐山谐波镜像部署](./deploy/leshan/leshan.md)

## 技术参考
* [命令集合](/command.md)  
* [讲解](/explication.md)  
* [使用vi编辑器](/vicommand.md)  
* [需要熟悉的文件或者文件夹](folderinlinux.md)  
* [shell 编程](/shell.md)  
* [不是天天用就会忘记的命令](/usuallyforget.md)
* [如何生成CA证书](/cert/ca.md)
* [安装和使用Supervisor](/supervisor.md)
* [nginx使用指南](/nginx/nginx.md)
* [nginx平滑升级](/nginx/nginx-update.md)
* [新装CentOS7mini版本启动网卡、替换yum源](/centos7pure.md)  
* [安装GitLab Community Edition (CE)](/gitlab.md)  
* [在mac上安装mariadb](/task/install-mariadb-in-mac.md)  
* [centos下安装Tomcat](java/tomcat.md)  
* [centos下安装Redis和初步使用](redis/installredis.md)  
* [centos下安装ELK](elk/installelk.md)  
* [centos下安装Mariadb](mysql/aboutinstall.md) (centos7下mariadb 官方文档中的yum安装方法)
* [一个搭建openstack的环境](openstack/first.md)
* [Postgresql安装和简单使用](postgresql/psqlsetupandsimpleuse.md)
* [玩转CentOS7mini版本](/centos7pure.md)
* [CentOS常用命令](/command.md)
* [linux压缩解压](/zip.md)
* [Linux各种开机自动运行](linux/linux_on_start.md)
* [CentOS7修改SSH端口](linux/ssh_port.md)
* [IPv6](ipv6/ipv6dns.md)
* [IPv6操作](ipv6/ipv6opt.md)
* [CentOS 7 安装 JAVA环境（JDK 1.8）](./java/java-setup-on-centos.md)

## Issues  
* [主机HostKey值改变导致SSH连接发出警告](/issues/SPOOFINGDetected)  
* [centos7下mariadb 首次安装的问题，修改密码及忘记密码处理方法](mysql/aboutinstall.md)
* [CentOS系统安装内核时提示/boot分区空间不足问题的解决方法](linux/bootsizenotenough.md)  
* [CentOS网络相关问题集锦](/network/networkissue.md)

## Linux下的开发团队相关工具  
* [mattermost](tools/mattermost.md)  
* [nvm](nodejs/nvm.md)  
* [gitlab ci](gitlab/ci.md)
* [禅道](./zentao/transfer.md)
* [安装jenkins](./jenkins/install.md)

## npm
* [package.json中 npm依赖包版本前的符号的意义](./npm/preversionsymbolfornpm.md)

## Docker
* etcd
    [etcd](./etcd/etcd-index.md)

[powerdesigner数据库分析](./powerdesigner/powerdesigner-db.md)

## java
* [java spring boot项目部署-上](./java/springboot-deploy.md)
* [Mac OS X下安装和配置Maven](./java/maven-config.md)

## mysql
* [mysql 定时任务job](./mysql/mysqljob.md)
* [Mysql用户和授权](./mysql/user_and_privilege.md)

## 场景
* [秒杀](./case_architecture/second-quick-buy.md)

## windows工具

[Win7小马激活工具](http://xz.fengcv.cn/soft/214389.html?wordId=313484894049)

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


