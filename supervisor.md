# 安装和使用Supervisor

#### 安装python包管理工具
```
yum install python-setuptools
```

#### 安装Supervisor
```
easy_install supervisor
```

#### 创建配置文件目录
```
mkdir /etc/supervisor
```

#### 创建配置文件
```
echo_supervisord_conf > /etc/supervisor/supervisord.conf
```

#### 启动supervisor
```
supervisord
```

#### 常用命令
```
supervisord // 启动supervisor
supervisord -c /etc/supervisor/supervisord.conf // 使用指定的配置文件启动supervisor(此时默认开启了所有服务)
supervisorctl reload // 重新启动
supervisorctl update // 重新载入配置文件
supervisorctl shutdown // 关闭supervisord
supervisorctl clear // 进程名 清空进程日志
supervisorctl // 进入到交互模式下。使用help查看所有命令。
supervisorctl status // 查看进程
supervisorctl start xxxx // 启动某个进程
supervisorctl stop xxxx // 停止某个进程
supervisorctl restart xxxx // 重启某个进程
supervisorctl start|stop|restart + all 表示启动，关闭，重启所有进程。
```
#### 关闭supervisor
supervisorctl stop all先关闭supervisor服务  
之后再关闭supervisord服务  
kill -9 pid  

#### 一个supervisor进程的配置
```
[program:DockMonitorService]
directory=/opt/bin/dock-show
command=/opt/bin/dock-show/dock service dock_monitor -c /opt/bin/dock-show/conf.toml
autostart=true
autorestart=true
stderr_logfile=/opt/logs/dock_monitor_stderr.log
stdout_logfile=/opt/logs/dock_monitor_stdout.log
#user=test
```