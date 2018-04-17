# 配置一个nodejs的服务器  


curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash  安装nvm  
source ~/.bash_profile  
nvm install v6.10.3  
npm install -g pm2  
yum install nginx  



## 升级nginx到最新版  
···
Pre-Built Packages for Stable version

To set up the yum repository for RHEL/CentOS, create the file named /etc/yum.repos.d/nginx.repo with the following contents:

[nginx]  
name=nginx repo  
baseurl=http://nginx.org/packages/OS/OSRELEASE/$basearch/
gpgcheck=0
enabled=1
Replace “OS” with “rhel” or “centos”, depending on the distribution used, and “OSRELEASE” with “6” or “7”, for 6.x or 7.x versions, respectively.
···

