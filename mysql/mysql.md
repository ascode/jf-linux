
卸载mariadb

#### 查看是否安装了mariadb
```
rpm -qa|grep mariadb
```

#### 卸载mariadb
```
yum remove mariadb
```

#### 查看mariadb遗留文件
```
ls /etc/my.cnf
ll /var/lib/mysql/
```

#### 删除遗留文件
```
rm /etc/my.cnf
rm -rf /etc/my.cnf.d
rm -rf /var/lib/mysql/
```

#### 下载mysql8.0
```
curl -O https://repo.mysql.com//mysql80-community-release-el7-3.noarch.rpm
```

#### 下载mysql5.7
```
curl -O https://repo.mysql.com//mysql57-community-release-el7-10.noarch.rpm
```

#### 安装mysql工具包
```
yum install mysql -y
```

#### 安装mysql服务器
```
yum -y install mysql-community-server
```

#### 启动数据库服务
```
systemctl start  mysqld.service
```

#### 查看Mysql运行状态
```
systemctl status mysqld.service
```

#### 找到mysql的初始临时密码
此时MySQL已经开始正常运行，不过要想进入MySQL还得先找出此时root用户的密码，通过如下命令可以在日志文件中找出密码：
```
grep "password" /var/log/mysqld.log
```

#### 登录数据库
```
mysql -uroot -p
```

#### 修改密码
此时不能做任何事情，因为MySQL默认必须修改密码之后才能操作数据库，如下命令修改密码
```
ALTER USER 'root'@'localhost' IDENTIFIED BY 'new password';
```

#### 退出数据库客户端连接
```
exit
```
