
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

#### Mysql数据库设置
```
systemctl start  mysqld.service
```

#### 查看Mysql运行状态
```
systemctl status mysqld.service
```