# Redis  

Redis的安装也很简单，严格来说是不需要安装，解压之后直接使用。如果是使用源码安装，则需要编译源码。  

### 安装Redis  

```
$ wget http://download.redis.io/releases/redis-3.2.8.tar.gz
$ tar xzf redis-3.2.8.tar.gz
$ cd redis-3.2.8
$ make
```

### 启动Redis服务  

```
$ src/redis-server
```
建议使用nohup ./src/redis-server & 来启动Redis Server，更多用法见官网文档。


### 测试Redis是否启动  
```
$ src/redis-cli
redis> set foo bar
OK
redis> get foo
"bar"
```

