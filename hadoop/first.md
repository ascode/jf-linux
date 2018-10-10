# 安装虚拟机

配置虚拟机

关闭防火墙
禁用selinux
修改主机名
配置host，使本机的ip指向本机的主机名
重启机器

配置ssh免密码登录
先尝试一下：ssh 192.168.199.232
ssh-keygen -t rsa
ssh-copy-id 192.168.199.232
然后测试一下：ssh 192.168.199.232

先创建几个目录
cd /home
mkdir tools #放jar包
mkdir softwares #放软件
mkdir data #放测试数据

在tools目录安装jdk环境
先看看系统有没有安装java环境
rpm -qa|grep jdk
rpm -qa|grep java

<!-- 使用文件上传下载插件：lrzsz
安装lrzsz
yum install -y lrzsz -->

上传scp ./jdk-8u181-linux-x64.tar.gz hadoop@192.168.199.232:~
解压 tar -zxvf jdk-8u181-linux-x64.tar.gz -C ../softwares/

配置环境变量
vi /etc/profile

export JAVA_HOME=/home/softwares/jdk1.8.0_181
export PATH=$PATH:$JAVA_HOME/bin

生效新配置
source /etc/profile

看看是否安装成功
java -version