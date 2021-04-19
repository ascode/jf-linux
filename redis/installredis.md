# Redis  

Redis的安装也很简单，严格来说是不需要安装，解压之后直接使用。如果是使用源码安装，则需要编译源码。  

### 安装Redis  

```
$ wget http://download.redis.io/releases/redis-3.2.8.tar.gz
$ tar xzf redis-3.2.8.tar.gz
$ cd redis-3.2.8
$ make
```

### 创建存储redis文件目录
```
mkdir -p /usr/local/redis
```

### 进入src目录，复制redis-server redis-cli到新建立的文件夹
```
cp ./redis-server /usr/local/redis/
cp ./redis-cli /usr/local/redis/
```

### 复制redis的配置文件
```
cd ..
cp redis.conf /usr/local/redis/
```

### 编辑配置文件
```
cd /usr/local/redis/
vim redis.conf
```
将daemonize 后面的no改为yes后台运行 

### 添加开机启动服务
```
vim /etc/systemd/system/redis-server.service
```

```
[Unit]
Description=The redis-server Process Manager
After=syslog.target network.target

[Service]
Type=forking
ExecStart=/data/redis/redis-server /data/redis/redis.conf
ExecReload=/bin/kill -USR2 $MAINPID
ExecStop=/data/redis/redis-cli shutdown

[Install]
WantedBy=multi-user.target
```

### 设置开机启动
```
1 systemctl daemon-reload
2 systemctl start redis-server.service
3 systemctl enable redis-server.service
```

### 检查是否安装成功

```
ps -ef |grep redis
```

### 创建redis命令软连接
```
ln -s /usr/local/redis/redis-cli /usr/bin/redis
```

### 测试Redis是否启动  
```
$ redis
redis> set foo bar
OK
redis> get foo
"bar"
```

### 设置访问密码
1、初始化Redis密码：
   在配置文件中有个参数： requirepass  这个就是配置redis访问密码的参数；
   ```
   比如 requirepass test123；
   ```

2、不重启Redis设置密码：

在配置文件中配置requirepass的密码（当redis重启时密码依然有效）。
```
redis 127.0.0.1:6379> config set requirepass test123
```

```
redis 127.0.0.1:6379> config get requirepass
 (error) ERR operation not permitted
```

```
redis 127.0.0.1:6379> auth test123
 OK
```

再次查询：
```
 redis 127.0.0.1:6379> config get requirepass
   1) "requirepass"
   2) "test123"
```

PS：如果配置文件中没添加密码 那么redis重启后，密码失效；

3、登陆有密码的Redis：

在登录的时候的时候输入密码： 
```
redis-cli -p 6379 -a test123
```

先登陆后验证：
```
redis-cli -p 6379
   redis 127.0.0.1:6379> auth test123
   OK
```

#### 如果要远程连接redis
1.找到redis.conf文件
2.找到bind 127.0.0.1 默认是打开的;  注释 bind 127.0.0.1 换成 bind 0.0.0.0
3.重启redis服务


AUTH命令跟其他redis命令一样，是没有加密的；阻止不了攻击者在网络上窃取你的密码；

认证层的目标是提供多一层的保护。如果防火墙或者用来保护redis的系统防御外部攻击失败的话，外部用户如果没有通过密码认证还是无法访问redis的。

