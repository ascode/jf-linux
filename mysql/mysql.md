
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
rm -rf /etc/my.cnf
rm -rf /var/lib/mysql/
```

curl -O https://repo.mysql.com//mysql80-community-release-el7-3.noarch.rpm

curl -O https://repo.mysql.com//mysql57-community-release-el7-10.noarch.rpm

yum install mysql -y

yum -y install mysql-community-server

