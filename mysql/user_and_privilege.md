# Mysql用户和授权


### 创建用户

CREATE USER 'username'@'host' IDENTIFIED BY 'password';

username:用户名；host：指定在哪个主机上可以登录，本机可用localhost，%通配所有远程主机；password：用户登录密码

### 设置权限

GRANT ALL PRIVILEGES ON  *.* TO ‘username’@‘%’ IDENTIFIED BY 'password’；

格式：grant 权限 on 库名.表名 to 用户@登录主机 identified by "用户密码"；*.*代表所有权；

@ 后面是访问的是客户端IP地址（或是 主机名） % 代表任意的客户端，如果填写 localhost 为本地访问（那此用户就不能远程访问该mysql数据库了）

### 刷新权限：FLUSH PRIVILEGES;   

