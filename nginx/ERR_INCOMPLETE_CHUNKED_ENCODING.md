# 解决：NET::ERR_INCOMPLETE_CHUNKED_ENCODING 200 (OK)

## 问题

今天发生微信小程序突然有部分接口获取数据失败，经测试，基本都是数据量大的接口会报这个错误。经一番检测，原来磁盘剩余空间为0。清理磁盘空间后恢复。

问题虽然解决了，但我还是搬一下网上对这个问题的总结。


## 原因及解决方案：

常见的原因有如下几种情况：

1、nginx的缓冲区（Proxy Buffer）设置较小

修改配置如下：
```
proxy_buffer_size 1024k;
proxy_buffers 16 1024k;
proxy_busy_buffers_size 2048k;
proxy_temp_file_write_size 2048k;
```

2、nginx的临时目录（/proxy_temp）过大或没有权限写入缓存文件

当代理文件大小超过配置的proxy_temp_file_write_size值时，nginx会将文件写入到临时目录下（默认为/proxy_temp）。

如果nginx中/proxy_temp过大或者没有写权限，缓存文件就写不进去了。

* 直接删除Nginx缓存文件；
```
# rm -rf  /usr/local/nginx/proxy_temp
```

* 设置Nginx的缓存过期时间；  
* 调整/proxy_temp权限为配置nginx的那个用户；  
```
chown -R www:www /usr/local/nginx/proxy_temp
```

3、磁盘空间不够

删掉磁盘一些日志 文件，释放下空间。
