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
在貌似文件夹的图标上点击鼠标右键，选择Scan and delete whole floder，然后等待Scan完成，在右边操作区点击Delete All

可以清理的数据：
* device_log目录下面的数据（其实就是key以“device_log:”开头的数据记录）
* 设备的sn作为key的list数据

### 关闭redis服务
```
shutdown save
```
