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