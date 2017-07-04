# centos7下mariadb 官方文档中的yum安装方法

https://mariadb.com/kb/en/mariadb/yum/

# centos7下mariadb 首次修改密码及忘记密码处理方法 

### 首次修改密码  
#### 第一种  
>mysqladmin -u root -p[oldpass] password newpass  
注意oldpass(老密码)可选，如果root默认密码为空，则不需要输入  
如果需要更改老密码，请注意老密码与-p之间不要有空格，否则会报错，另外password和newpass(新密码)之间以空格分隔。  
#### 第二种  
初始化数据库
/usr/local/mysql/bin/mysql_secure_installation                yum安装是在/usr/bin/mysql_secure_installation  
之后开始初始化  
依次看提示    

### 创建用户  
//创建用户
mysql> insert into mysql.user(Host,User,Password) values("localhost","admin",password("admin"));  
//刷新系统权限表  
mysql>flush privileges;  
这样就创建了一个名为：admin  密码为：admin  的用户。  

### 创建数据库(在root权限下)  
create database mydb;  
//授权admin用户拥有mydb数据库的所有权限。  
>grant all privileges on mydb.* to admin@localhost identified by 'admin';  
//刷新系统权限表  
mysql>flush privileges;  

### 删除用户。  
@>mysql -u root -p  
@>密码  
mysql>DELETE FROM user WHERE User="admin" and Host="localhost";  
mysql>flush privileges;  
//删除用户的数据库  
mysql>drop database mydb;  

### 修改指定用户密码。  
@>mysql -u root -p  
@>密码  
mysql>update mysql.user set password=password('新密码') where User="admin" and Host="localhost";  
MySQL>flush privileges;  

### 忘掉密码  
systemctl stop mariadb ==>停止mariadb数据库  
mysqld_safe --skip-grant-table   &   ==>进入单机模式  
mysql  
use mysql;==>进入mysql库  
update user set password=password(新密码) where user='root' and host='localhost';==>设置新密码  
flush privileges;==>刷新  
新开窗口 mysqladmin -uroot -p shutdown ==>新密码测试关掉数据库，成功关闭就证明修改成功  
systemctl restart mariadb ==>重启服务  
skip_name_resolve = ON  
#### 第二种方法  
 vim /etc/my.cnf  
[mysqld]  
skip-grant-tables              添加这一行，然后保存，重启服务，，mysql可以直接进去修改了。同上。  