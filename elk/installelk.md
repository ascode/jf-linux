# 安装ELK


### 安装java  
```
sudo yum install -y java
```

### Import the Elasticsearch PGP Keyedit  


We sign all of our packages with the Elasticsearch Signing Key (PGP key D88E42B4, available from https://pgp.mit.edu) with fingerprint:

4609 5ACC 8548 582C 1A26 99A9 D27D 666C D88E 42B4
Download and install t`he public signing key:
```
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
```

### Installing from the RPM repositoryedit  


Create a file called elasticsearch.repo in the /etc/yum.repos.d/ directory for RedHat based distributions, or in the /etc/zypp/repos.d/ directory for OpenSuSE based distributions, containing:

```
[elasticsearch-5.x]
name=Elasticsearch repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
```
And your repository is ready for use. You can now install Elasticsearch with one of the following commands:
```
sudo yum install elasticsearch 
sudo dnf install elasticsearch 
sudo zypper install elasticsearch 
```

### 配置  

修改配置文件:  
/etc/elasticsearch/elasticsearch.yml  

查看修改了哪些： grep '^[a-z]' elasticsearch.yml 




SysV init vs systemdedit
Elasticsearch is not started automatically after installation. How to start and stop Elasticsearch depends on whether your system uses SysV init or systemd (used by newer distributions). You can tell which is being used by running this command:

ps -p 1
Running Elasticsearch with SysV initedit
Use the chkconfig command to configure Elasticsearch to start automatically when the system boots up:

sudo chkconfig --add elasticsearch
Elasticsearch can be started and stopped using the service command:

sudo -i service elasticsearch start
sudo -i service elasticsearch stop
If Elasticsearch fails to start for any reason, it will print the reason for failure to STDOUT. Log files can be found in /var/log/elasticsearch/.

Running Elasticsearch with systemdedit
To configure Elasticsearch to start automatically when the system boots up, run the following commands:

sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
Elasticsearch can be started and stopped as follows:

sudo systemctl start elasticsearch.service
sudo systemctl stop elasticsearch.service
These commands provide no feedback as to whether Elasticsearch was started successfully or not. Instead, this information will be written in the log files located in /var/log/elasticsearch/.

By default the Elasticsearch service doesn’t log information in the systemd journal. To enable journalctl logging, the --quiet option must be removed from the ExecStart command line in the elasticsearch.service file.

When systemd logging is enabled, the logging information are available using the journalctl commands:

To tail the journal:

sudo journalctl -f
To list journal entries for the elasticsearch service:

sudo journalctl --unit elasticsearch
To list journal entries for the elasticsearch service starting from a given time:

sudo journalctl --unit elasticsearch --since  "2016-10-30 18:17:16"
Check man journalctl or https://www.freedesktop.org/software/systemd/man/journalctl.html for more command line options.


### 查看是否运行
```
curl -XGET 'localhost:9200/?pretty'
```

查询es里面的状态：  

curl -i -XGET 'http://localhost:9200/_count?pretty' -d '{"query":{"match_all":{}}}'

### 使用插件和ES交互  


##### mobz/elasticsearch-head

```
cd /usr/share/elasticsearch
bin/elasticsearch-plugin install mobz/elasticsearch-head
```

但是： for Elasticsearch 5.x: site plugins are not supported. Run as a standalone server

项目地址：https://github.com/mobz/elasticsearch-head

Running with built in server
```
git clone git://github.com/mobz/elasticsearch-head.git
cd elasticsearch-head
npm install
npm run start
open http://localhost:9100/
```


