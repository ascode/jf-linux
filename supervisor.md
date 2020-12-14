安装Supervisor

#### 安装python包管理工具
yum install python-setuptools

#### 安装Supervisor
easy_install supervisor

#### 创建配置文件目录
mkdir /etc/supervisor

#### 创建配置文件
echo_supervisord_conf > /etc/supervisor/supervisord.conf

#### 启动supervisor
supervisord