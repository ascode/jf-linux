# nginx使用指南  

查看nginx安装路径
```
nginx -V
```

## 安装  

1. 查看gcc有没有安装
```
gcc -v
```
如果没有安装gcc,则执行安装
```
yum -y install gcc
```

2. 安装pcre、pcre-devel
```
yum install -y pcre pcre-devel
```

3. 安装openssl
```
yum install -y openssl openssl-devel
```

4. 安装zlib
```
yum install -y zlib zlib-devel
```

wget http://nginx.org/download/nginx-1.10.3.tar.gz  
tar xzf nginx-1.10.3.tar.gz  
cd nginx-1.10.3  
useradd www ; ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module  
make  
make install  


issues

nginx源码编译安装出现“make[1]: Leaving directory `/usr/local/nginx’“解决办法

如果你走到make这一步的时候只出现了一行“make[1]: Leaving directory `/usr/local/nginx-1.12.1；”提示，不用管它，继续走make install ；
然后：
1、我只需要去看/usr/local下面是否有nginx文件夹？
2、如果已经有nginx文件夹？
3、我们再去看nginx是否可以正常启动？
4、如果nginx启动也可以成功，我们再去看下网站是否可以访问，是否会出现“Welcome to nginx!”？
5、如果上面都成功了，说明你的nginx已经ok！

