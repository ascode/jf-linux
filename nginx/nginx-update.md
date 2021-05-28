# centos8 yum 升级nginx

添加nginx yum源

Nginx官网提供了三个类型的版本  
Mainline version：Mainline 是 Nginx 目前主力在做的版本，可以说是开发版  
Stable version：最新稳定版，生产环境上建议使用的版本  
Legacy versions：遗留的老版本的稳定版  
```
vi /etc/yum.repos.d/nginx.repo
```

使用mainline最新版本的repo

```
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://mirrors.ustc.edu.cn/nginx/mainline/centos/$releasever/$basearch/
gpgcheck=0
enabled=1
module_hotfixes=true
```

安装稳定版时可单独配置（[nginx-stable]）

yum 更新

```
yum update
```

查看nginx版本

nginx -v

