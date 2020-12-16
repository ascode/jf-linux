# 道口电子屏显示系统部署说明书

#### 一、前提条件
1. 操作系统可用windows或者linux较新或者最新版本。
1. nginx1.16.1或以上
2. supervisor3.4.0或以上
3. mysql5.7或以上
4. consul1.5.1或以上

安装前提条件中的中间件，请参考如下网址：  
https://gitee.com/mcsk-open-source/maintain-memory

**提示：您可以将前后端程序放到同一个目录下面进行部署，也可以分开部署。以下按照分开部署进行举例。**

#### 二、前端部署和配置（nginx网站配置）

##### 2.1 拷贝程序
前端程序是在一个名为dist的目录下面，假设我们将程序拷贝到
/usr/share/nginx/html/dock-show-f/dist目录

在/usr/share/nginx/html/dock-show-f/dist目录下新建export目录，导出的excel文件会临时存放在这个目录

##### 2.2 文件说明
服务端程序主要包括两个程序：
* 业务服务
* 文件上传服务

|文件或文件夹| 说明 |
| --- | --- |
| /usr/share/nginx/html/dock-show-f/dist | 前端程序（网站）根目录 |
| /usr/share/nginx/html/dock-show-f/dist/export | 导出的Excel存放的目录（导出excel的时候，后端应用程序会将excel文件存放到这个目录供下载使用） |

##### 2.3 nginx配置
nginx配置文件一般是/etc/nginx/nginx.conf，在修改配置前建议将nginx.conf文件进行备份：
```bash
cd /etc/nginx/
cp ./nginx.conf ./nginx.conf.bak
```

可以使用分割配置文件的方式，需要在nginx.conf文件中开启配置部分文件的目录，在nginx.conf中使用如下配置，代表nginx的配置文件由/etc/nginx/nginx.conf文件和/etc/nginx/conf.d/*.conf目录下面的所有conf结尾的文件共同构成：
```bash
include /etc/nginx/conf.d/*.conf;
```

新建/etc/nginx/conf.d/dock-show-f.conf文件，内容示例如下：
```bash
 server {
        listen       80;
        listen       [::]:80;
        server_name dock.bgenius.cn;
        root         /usr/share/nginx/html/dock-show-f/dist;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
            index index.html;
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
}
```

修改完成配置后，测试nginx配置语法是否正确：
```bash
nginx -t
```

##### 2.4 启动nginx
如果还未启动nginx，则使用如下命令进行启动
```bash
nginx
```

如果修改了nginx配置文件，加载最新配置
```bash
nginx -s reload
```

到此完成了前端网站的配置


#### 三、服务端程序部署和配置

##### 3.1 拷贝程序
例如拷贝到如下路径
```bash
/opt/bin/dock-show
```
需要拷贝的程序有
* /opt/bin/dock-show/conf.toml
* /opt/bin/dock-show/dock
* /opt/bin/dock-show/upload/conf.toml
* /opt/bin/dock-show/upload/upload

新建文件夹/opt/bin/dock-show/uploadfiles，导入的excel文件会临时存放在这个目录

##### 3.2 文件说明
服务端程序主要包括两个程序：
* 业务服务
* 文件上传服务

|文件或文件夹| 说明 |
| --- | --- |
| /opt/bin/dock-show/conf.toml | 业务服务的配置文件 |
| /opt/bin/dock-show/dock | 业务服务程序 |
| /opt/bin/dock-show/upload/conf.toml | 上传服务的配置文件 |
| /opt/bin/dock-show/upload/upload | 上传程序服务 |
| /opt/bin/dock-show/uploadfiles | 上传目录 |

##### 3.3 应用配置
应用配置一般分为：
* 前端程序配置
* 后端程序配置

###### 3.3.1 前端程序配置
本应用前端应用程序本身无需配置

###### 3.3.2 后端应用程序配置
* 业务应用服务（dock）配置：  
配置文件名为conf.toml，本例子中我们放置在/opt/bin/dock-show/conf.toml
```bash
[ln_port]
dock_monitor = 28853
dock_monitor_web = 28854

[mysql]
user = "******"  // 需根据实际情况修改
pwd = "******"  // 需根据实际情况修改
addr = "**"  // 需根据实际情况修改
r_timeout = "5s"
w_timeout = "5s"
idle_conn = 8
open_conn = 32

[mysqldb]
db_name_dock    = "dock"  // 需根据实际情况修改
db_name_task_center = "task_center"
db_name_raw_data    = "raw_data"

[export_data]
doc_path = "/usr/share/nginx/html/dock-show-f/dist/export"  // 这里配置为前端网站根目录下面的export目录

```

* 文件上传服务（upload）配置：  
配置文件名称为conf.toml，本例子中我们放置在/opt/bin/dock-show/upload/conf.toml
```bash
[ln_port]
normal_upload_web = 28855  // 需根据实际情况修改

[mysql]
user = "***"
pwd = "******"
addr = "********:3306" 
r_timeout = "5s"
w_timeout = "5s"
idle_conn = 8
open_conn = 32

[url]
home = "https://***/merchant/home"
```

* nginx配置
```
 server {

        listen       80;
        listen       [::]:80;
        server_name  api-dock.bgenius.cn;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location /dock.DockMonitor {
            proxy_pass   http://127.0.0.1:28854;
        }

        location /dock.DockMonitorUpload {
            proxy_pass   http://127.0.0.1:28855;
        }

        error_page 404 /404.html;
            location = /40x.html {
        }

        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }
}
```

##### 3.4 中间件配置
后端应用程序使用到的中间件包括：
* 数据库mysql
* 服务数据中心consul
* 应用进程管理工具Supervisor

##### 3.4.1 数据库mysql配置
mysql数据库只需要进行常规配置即可，将数据库的登录用户名和密码做好记录。

##### 3.4.2 consul配置
consul无需配置，使用的时候只需要用如下命令启动即可
```bash
.nohup /consul agent --dev &
```

##### 3.4.3 Supervisor配置
Supervisor管理的应用进程配置信息一般放在如下目录：
```bash
/etc/supervisord.d
```
在/etc/supervisord.d目录中新建两个进程配置文件dock_show.ini、dock_show_upload.ini

dock_show.ini文件内容：
```bash
[program:DockMonitorService]
directory=/opt/bin/dock-show
command=/opt/bin/dock-show/dock service dock_monitor -c /opt/bin/dock-show/conf.toml
autostart=true
autorestart=false
stderr_logfile=/opt/logs/dock_monitor_stderr.log
stdout_logfile=/opt/logs/dock_monitor_stdout.log
#user=test
```

dock_show_upload.ini文件内容：
```bash
[program:DockMonitorUploadService]
directory=/opt/bin/dock-show/upload
command=/opt/bin/dock-show/upload/upload service upload -c /opt/bin/dock-show/upload/conf.toml
autostart=true
autorestart=false
stderr_logfile=/opt/logs/dock_monitor_upload_stderr.log
stdout_logfile=/opt/logs/dock_monitor_upload_stdout.log
#user=test
```

注意：配置文件中包含的目录一定得先创建，否则运行会报错

supervisor的启动和运行，详见：[https://gitee.com/mcsk-open-source/maintain-memory/blob/master/supervisor.md](https://gitee.com/mcsk-open-source/maintain-memory/blob/master/supervisor.md)

#### 四、建立数据库
可以使用MysqlWorkbench导入备份文件的方式建立数据库，默认数据库名称就叫dock

#### 五、启动应用
应用启动包括：
1. 运行环境就绪
2. 前端网站程序启动
3. 后端服务程序启动

##### 5.1 运行环境就绪
1. nginx安装并配置
2. supervisor安装并配置
3. mysql安装并配置
4. consul安装（在服务器上存在即可）

##### 5.2 前端网站程序启动
前端网站程序启动，实际上就是网站部署，只需要在nginx中配置好网站即可，前述"前端部署和配置"章节完成后，启动nginx即启动了前端应用程序。

##### 5.3后端服务程序启动

后端应用程序在配置好supervisor之后，启动很简单。
supervisor启动之后，后端服务程序就已经启动。

查看后端应用程序运行状态：
```bash
supervisorctl status
```