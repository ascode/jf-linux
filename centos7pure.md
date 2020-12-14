
## CentOS7mini版本启动网卡、替换yum源

最近本人安装了一个CentOS7mini版本的虚拟机，进去之后碰到了一系列问题，因为是精简版本，所以很多软件和插件都需要自己安装，并且没有安装图形化界面，完全是命令行进行操作，目的就是为了熟悉Linux环境下的一些命令和知识。


### 一、启动网卡  
跟网络设置相关的文件有两个：  
/etc/sysconfig/network-scripts/ifcfg-ens33  配置ip地址等网卡信息  
/etc/resolv.conf  配置DNS服务器地址信息  
#### /etc/sysconfig/network-scripts/ifcfg-ens33文件配置项  
TYPE=Ethernet  
BOOTPROTO=static    
DEFROUTE=yes  
PEERDNS=yes  
PEERROUTES=yes  
IPV4_FAILURE_FATAL=no  
IPV6INIT=yes  
IPV6_AUTOCONF=yes  
IPV6_DEFROUTE=yes  
IPV6_PEERDNS=yes  
IPV6_PEERROUTES=yes  
IPV6_FAILURE_FATAL=no  
NAME=eno1677736  
UUID=62318d04-fb4b-4d5a-8cb7-8a7ad55b3c85  
DEVICE=eno16777736  
ONBOOT=yes  
IPADDR=192.168.1.102  
NETMASK=255.255.255.0  
GATEWAY=192.168.1.1  

#### /etc/resolv.conf配置项  
nameserver 8.8.8.8  

刚安装的CentOS7mini版本，启动系统后网卡并没有启动，我做了如下操作：
执行命令：

cd /etc/sysconfig/network-scripts/

然后ls一下，会发现ifcfg-ens33的一个文件。
![](http://image.bgenius.cn/jinfei/github/zn-linux/Screen%20Shot%202016-12-31%20at%203.47.51%20AM.png)
ls -lh 检查这个文件的权限
![](http://image.bgenius.cn/jinfei/github/zn-linux/Screen%20Shot%202016-12-31%20at%203.40.59%20AM.png)
su 切换超级用户  
vi ifcfg-ens33然后将onboot=no改成onboot=yes，保存后退出。

执行命令: ifup ifcfg-ens33

ping xiaoyouping.club 网络连接成功
![](http://image.bgenius.cn/jinfei/github/zn-linux/Screen%20Shot%202016-12-31%20at%203.59.29%20AM.png)


### 二、安装net-tools  

启动网卡之后，接着执行，ifconfig命令，然后终端会提示 -bash:ifconfig:command not found。也就是说不认识这个ifconfig。在此我们需要安装net-tools软件。

执行以下命令: yum -y install net-tools

安装成功之后再执行ifconfig命令，就会看到本机的网络配置信息.


### 三、替换yum源  

在此我们用163的yum源替换本机的原始yum源，在国内比较好的，速度比较快的yum源有163、souhu等等，这里我使用的是163的yum源。

首先执行rpm -qa | grep wget命令，发现没有安装wget，那么首先安装这个wget。

执行命令安装wget： yum -y install wget

安装成功之后cd到yum源的目录：/etc/yum.repos.d/

然后备份目录下的yum源文件：mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup

下载163yum源之前，我们先访问下163的开源镜像网站：http://mirrors.163.com
![](http://image.bgenius.cn/jinfei/github/zn-linux/20160309105825741.png)

点击centos使用帮助，进入163yum源。
![](http://bgimage.oss-cn-qingdao.aliyuncs.com/jinfei/github/zn-linux/20160309105943743.png)

然后通过命令下载Centos7的yum源。

wget http://mirrors.163.com/.help/CentOS7-Base-163.repo
下载完成之后，执行命令重新命名163的yum源：mv CentOS7-Base-163.repo CentOS-Base.repo

运行以下命令生成缓存，完成163yum源的替换。

yum clean all
yum makecache


