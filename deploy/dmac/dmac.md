# DMac 


### 连接和登录Redis

* 没有密码

```
redis-cli
select 3    // 选择db3
```

* 有密码

```
redis-cli -a password
select 3    // 选择db3
```

### 清理数据

* 清理列表数据
```
llen 93f4d3d8fc474d63 查看list长度
ltrim 93f4d3d8fc474d63 0 0 清空list
```

* 清理Floder里面的数据
使用Another Redis Desktop Manager在貌似文件夹的图标上点击鼠标右键，选择Scan and delete whole floder，然后等待Scan完成，在右边操作区点击Delete All

可以清理的数据：
* device_log目录下面的数据（其实就是key以“device_log:”开头的数据记录）
* 设备的sn作为key的list数据

#### 可能遇到的问题

1. MISCONF Redis is configured to save RDB snapshots, but is currently not able to persist on disk. Commands that may modify the data set are disabled. Please check Redis logs for details about the error. 

在windows下使用Another Redis Desktop Manager大量清理Redis数据的时候，可能提示如上错误，此时在Redis日志中会发现提示需要增加磁盘分页文件空间。解决办法就是在Redis所在磁盘增加磁盘分页文件空间（就是windows虚拟内存空间）。可以在windows搜索框搜索“环境变量”，环境变量配置界面下面有个按钮，点开就是配置分页文件的界面。

### 关闭redis服务
```
shutdown save
```
