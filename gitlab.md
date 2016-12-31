## 安装GitLab Community Edition (CE)  

### 前提条件：  
1.我在自己电脑上安装了CentOS-7-x86_64-Minimal-1611.iso版本的最小化CentOS7。安装过程我并没有记录，我是使用VMWare 12在Mac电脑上装的虚拟机。为什么选择VMWare 12？因为可以在网上找到免费的序列号。  

2.最小版本CentOS缺乏必要的工具和配置，所以我先执行了本笔记中的任务：[新装CentOS7mini版本启动网卡、替换yum源](/centos7pure.md)，需要的可以参考。    

### 安装步骤：
以下摘录自[https://about.gitlab.com/downloads/#centos7](https://about.gitlab.com/downloads/#centos7)。  

Install a GitLab CE Omnibus package on  
CentOS 7 (and RedHat/Oracle/Scientific Linux 7)   
 Check if your server meets the hardware requirements. GitLab packages are built for 64bit systems. For 32bit OS, consider alternative installation methods.  

1. Install and configure the necessary dependencies  

If you install Postfix to send email please select 'Internet Site' during setup. Instead of using Postfix you can also use Sendmail or configure a custom SMTP server and configure it as an SMTP server.  

On Centos 6 and 7, the commands below will also open HTTP and SSH access in the system firewall.  

sudo yum install curl policycoreutils openssh-server openssh-clients  
sudo systemctl enable sshd  
sudo systemctl start sshd  
sudo yum install postfix  
sudo systemctl enable postfix  
sudo systemctl start postfix  
sudo firewall-cmd --permanent --add-service=http  
sudo systemctl reload firewalld  
2. Add the GitLab package server and install the package  

curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash  
sudo yum install gitlab-ce  
If you are not comfortable installing the repository through a piped script, you can find the entire script here and select and download the package manually and install using  

curl -LJO https://packages.gitlab.com/gitlab/gitlab-ce/packages/el/7/gitlab-ce-XXX.rpm/download  
rpm -i gitlab-ce-XXX.rpm  
3. Configure and start GitLab  

sudo gitlab-ctl reconfigure  
4. Browse to the hostname and login  

On your first visit, you'll be redirected to a password reset screen to provide the password for the initial administrator account. Enter your desired password and you'll be redirected back to the login screen.  

The default account's username is root. Provide the password you created earlier and login. After login you can change the username if you wish.  

### 结果和遇到的问题
本次安装过程很顺利，没有遇到什么问题，但是我的虚拟机安装在Mac外置机械式移动硬盘上，下载东西的时候也是直接下载在这个硬盘上，还有一小部分软件直接在这个硬盘上启动。当有下载或者启动这个硬盘上的程序的时候，我的gitlab运行那叫一个慢。。。穷啊，没钱单独配置系统给gitlab用。  
一半的时候能够通过几十秒的等待出现正常界面，如图：
![](http://image.bgenius.cn/jinfei/github/zn-linux/Screen%20Shot%202017-01-01%20at%202.38.01%20AM.png)  

另外一半的时候出现的是这样的界面：  
![](http://image.bgenius.cn/jinfei/github/zn-linux/Screen%20Shot%202017-01-01%20at%202.44.19%20AM.png)


