# Linux各种开机自动运行

### 一、centos7 设置 防火墙 开机自启
CentOS 7.0默认使用的是firewall作为防火墙，之前版本是使用iptables。 

1.设置firewall开机启动
```
systemctl enable firewalld
```

2.禁止firewall开机启动
```
systemctl disable firewalld
```

### 二、Linux CentOS7 Consul 开机自启动 Systemd服务
1、路径/usr/lib/systemd/system/，新建一个service命名为，consul.service
```
[Unit]
Description=consul
After=network.target
    
[Service]
ExecStart=/usr/local/consul/start.sh
KillSignal=SIGTERM
    
[Install]
WantedBy=multi-user.target
```

2、编辑/usr/local/consul/start.sh，注意LF格式

```
/usr/bin/consul agent -server -node=192.168.3.33 -data-dir=/usr/local/consul/data/ -config-dir=/usr/local/consul/config/ -log-file=/usr/local/consul/log/consul_log-$(date +%Y-%m-%d--%H-%M) -bind=192.168.3.33 -join=192.168.3.33
```

3、执行命令

运行
```
# systemctl start consul
```

开机运行
```
# systemctl start consul
```

4、如果重新加载配置文件，则直接运行consul reload即可，consul leave同理

### 三、Centos 开机自动启动 supervisor
1.在目录/usr/lib/systemd/system/ 新建文件supervisord.service

2.添加配置内容：
```
[Unit] 
Description=Supervisor daemon

[Service] 
Type=forking 
ExecStart=/usr/bin/supervisord -c /etc/supervisord.conf 
ExecStop=/usr/bin/supervisorctl shutdown 
ExecReload=/usr/bin/supervisorctl reload 
KillMode=process 
Restart=on-failure 
RestartSec=42s  # 开机42后启动

[Install] 
WantedBy=multi-user.target
```

3.设置自动启动服务 systemctl enable supervisord

4.验证一下是否为开机启动 systemctl is-enabled supervisord

5.启动服务 systemctl start supervisord

### 四、centos 7下的nginx设置开机自动启动

centos 7以上是用Systemd进行系统初始化的，Systemd 是 Linux 系统中最新的初始化系统（init），它主要的设计目标是克服 sysvinit 固有的缺点，提高系统的启动速度。关于Systemd的详情介绍在这里。  

Systemd服务文件以.service结尾，比如现在要建立nginx为开机启动，如果用yum install命令安装的，yum命令会自动创建nginx.service文件，直接用命令：  
systemcel enable nginx.service  

设置开机启动即可。  
在这里我是用源码编译安装的，所以要手动创建nginx.service服务文件。  
开机没有登陆情况下就能运行的程序，存在系统服务（system）里，即：  
/lib/systemd/system/  

1. 在系统服务目录里创建nginx.service文件
vi /lib/systemd/system/nginx.service
nginx.service内容如下：
```
[Unit]
Description=nginx
After=network.target
 
[Service]
Type=forking
ExecStart=/usr/local/nginx/sbin/nginx
ExecReload=/usr/local/nginx/sbin/nginx -s reload
ExecStop=/usr/local/nginx/sbin/nginx -s quit
PrivateTmp=true
 
[Install]
WantedBy=multi-user.target
```

```
Description:描述服务  
After:描述服务类别  
[Service]服务运行参数的设置  
Type=forking是后台运行的形式  
ExecStart为服务的具体运行命令
ExecReload为重启命令
ExecStop为停止命令
PrivateTmp=True表示给服务分配独立的临时空间
注意：[Service]的启动、重启、停止命令全部要求使用绝对路径
[Install]运行级别下服务安装的相关设置，可设置为多用户，即系统运行级别为3
```

2. 设置开机启动
```
systemctl enable nginx.service
```
自此，重新centos后，nginx就自动启动了

nginx其他命令
```
systemctl start nginx.service　（启动nginx服务）
systemctl stop nginx.service　（停止nginx服务）
systemctl enable nginx.service （设置开机自启动）
systemctl disable nginx.service （停止开机自启动）
systemctl status nginx.service （查看服务当前状态）
systemctl restart nginx.service　（重新启动服务）
systemctl list-units --type=service （查看所有已启动的服务
```