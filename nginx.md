# nginx  

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
