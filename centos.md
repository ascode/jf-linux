##Centos 安装 NodeJS

####准备命令：
yum -y install gcc make gcc-c++ openssl-devel wget
####下载源码及解压：
wget https://nodejs.org/dist/v4.2.4/node-v4.2.4.tar.gz
tar -zvxf node-v4.2.4.tar.gz
cd node-v4.2.4
####编译及安装：
make && make install
####验证是否安装配置成功：
node -v