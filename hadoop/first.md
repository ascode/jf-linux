# 安装虚拟机

配置虚拟机

关闭防火墙

禁用selinux
```
/etc/sysconfig/selinux
```

修改主机名:
```
hostnamectl set-hostname hadoop
```

配置hosts，使本机的ip指向本机的主机名
```
/etc/hosts
```
重启机器
注意：使用vi编辑的时候可以直接按o新增下一行并进入编辑状态

配置ssh免密码登录
先尝试一下：ssh 192.168.199.232
ssh-keygen -t rsa
ssh-copy-id 192.168.199.232
然后测试一下：ssh 192.168.199.232

先创建几个目录
cd /home
mkdir tools #放jar包
mkdir softwares #放软件
mkdir data #放测试数据

Required Software

Required software for Linux include:

Java™ must be installed. Recommended Java versions are described at HadoopJavaVersions.

ssh must be installed and sshd must be running to use the Hadoop scripts that manage remote Hadoop daemons.


在tools目录安装jdk环境
先看看系统有没有安装java环境
rpm -qa|grep jdk
rpm -qa|grep java

安装jdk
上传scp ./jdk-8u181-linux-x64.tar.gz hadoop@192.168.199.232:~
解压 tar -zxvf jdk-8u181-linux-x64.tar.gz -C ../softwares/

配置环境变量
vi /etc/profile

export JAVA_HOME=/home/softwares/jdk1.8.0_181
export PATH=$PATH:$JAVA_HOME/bin

生效新配置
source /etc/profile

看看是否安装成功
java -version

Installing Software

If your cluster doesn’t have the requisite software you will need to install it.

For example on Ubuntu Linux:

  $ sudo apt-get install ssh
  $ sudo apt-get install rsync

Download

To get a Hadoop distribution, download a recent stable release from one of the Apache Download [Mirrors](http://www.apache.org/dyn/closer.cgi/hadoop/common/).



解压hadoop
```
tar -zxvf ~/hadoop-3.1.1.tar.gz -C ./
```


查看JAVA_HOME配置
```
echo $JAVA_HOME
```


Prepare to Start the Hadoop Cluster

Unpack the downloaded Hadoop distribution. In the distribution, edit the file etc/hadoop/hadoop-env.sh to define some parameters as follows:

  # set to the root of your Java installation
  export JAVA_HOME=/usr/java/latest

Try the following command:

  $ bin/hadoop



Now you are ready to start your Hadoop cluster in one of the three supported modes:

Local (Standalone) Mode
Pseudo-Distributed Mode
Fully-Distributed Mode


Pseudo-Distributed Operation

Hadoop can also be run on a single-node in a pseudo-distributed mode where each Hadoop daemon runs in a separate Java process.

Configuration

Use the following:

etc/hadoop/core-site.xml:
```
<configuration>
    <property>
        <!-- 主要指明了namenode的通讯地址 -->
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:8020</value> <!-- 默认是9000，在hadoop1的时候只支持9000，在hadoop2开始可以支持8020，当然也可以是9000 -->
    </property>
    <!-- 另外再etc/hadoop/core-site.xml中配置临时目录，因为这个临时目录在/tmp/hadoop-${user.name}路径下，在linux系统中大家都知道，/tmp目录下的内容会自动隔一段时间清理 -->
    <property>
        <name>hadoop.tmp.dir</name>
        <value>/hadoop_bag/tools/hadoop-3.1.1/data/tmp</value>
    </property>
</configuration>
```
etc/hadoop/hdfs-site.xml:
```
<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
</configuration>
```


查看core-site.xml的配置说明：http://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-common/core-default.xml

查看hdfs-site.xml的配置说明：http://hadoop.apache.org/docs/stable/hadoop-project-dist/hadoop-hdfs/hdfs-default.xml

执行安装：

The following instructions are to run a MapReduce job locally. If you want to execute a job on YARN, see YARN on Single Node.

1. Format the filesystem:

  $ bin/hdfs namenode -format

2. Start NameNode daemon and DataNode daemon:

  $ sbin/start-dfs.sh

报错：
```
Exception in thread "main" java.lang.UnsupportedClassVersionError: org/apache/hadoop/hdfs/server/namenode/NameNode : Unsupported major.minor version 52.0
```
解决方案：

换jdk版本

报错：
```
[root@hadoop sbin]# ./start-dfs.sh 
Starting namenodes on [hadoop]
ERROR: Attempting to operate on hdfs namenode as root
ERROR: but there is no HDFS_NAMENODE_USER defined. Aborting operation.
Starting datanodes
ERROR: Attempting to operate on hdfs datanode as root
ERROR: but there is no HDFS_DATANODE_USER defined. Aborting operation.
Starting secondary namenodes [hadoop]
ERROR: Attempting to operate on hdfs secondarynamenode as root
ERROR: but there is no HDFS_SECONDARYNAMENODE_USER defined. Aborting operation.
```
解决方案

（缺少用户定义而造成的）因此编辑启动和关闭

$ vim sbin/start-dfs.sh
$ vim sbin/stop-dfs.sh

顶部空白处

HDFS_DATANODE_USER=root
HADOOP_SECURE_DN_USER=hdfs
HDFS_NAMENODE_USER=root
HDFS_SECONDARYNAMENODE_USER=root

启动完之后使用jps命令查看启动的节点
```
jps
```

The hadoop daemon log output is written to the $HADOOP_LOG_DIR directory (defaults to $HADOOP_HOME/logs).

3. Browse the web interface for the NameNode; by default it is available at:

NameNode - http://localhost:50070/


异常：
使用jps查看，namenode、secondard namenode、datanode、jps都启动了，防火墙也关了，但是远程使用ip就是不能访问50070，经过尝试在集群节点能够访问http://localhost:50070

解决：
经过查看日志，发现
vi hadoop-root-datanode-hadoop.log
```
2018-10-15 09:11:57,040 INFO org.apache.hadoop.ipc.Client: Retrying connect to server: hadoop/127.0.0.1:8020. Already tried 0 time(s); retry policy is RetryUpToMaximumCountWithFixedSleep(maxRetries=10, sleepTime=1000 MILLISECONDS)
```
datanode日志显示连接8020失败，进行如下查看：
```
[root@hadoop logs]# hostname -i
127.0.0.1 192.168.199.117

[root@hadoop logs]# ping hadoop
PING hadoop (127.0.0.1) 56(84) bytes of data.
```
原来是hosts里面配置了两个ip指向hadoop机器名，所以导致默认识别未127.0.0.1，由此得到结论就是服务并没有绑定到外部网卡ip上。所以去掉127.0.0.1到hadoop的绑定即可。


4. Make the HDFS directories required to execute MapReduce jobs:

  $ bin/hdfs dfs -mkdir /user
  $ bin/hdfs dfs -mkdir /user/<username>

5. Copy the input files into the distributed filesystem:

  $ bin/hdfs dfs -put etc/hadoop input



安装Yarn

1. Configure parameters as follows:etc/hadoop/mapred-site.xml:
```
<configuration>
    <property>
        <name>mapreduce.framework.name</name>
        <value>yarn</value>
    </property>
</configuration>
```
etc/hadoop/yarn-site.xml:
```
<configuration>
    <property>
        <name>yarn.nodemanager.aux-services</name>
        <value>mapreduce_shuffle</value>
    </property>
</configuration>
```
2. Start ResourceManager daemon and NodeManager daemon:
```
  $ sbin/start-yarn.sh
```
3. Browse the web interface for the ResourceManager; by default it is available at:

ResourceManager - http://localhost:8088/
4. Run a MapReduce job.

5. When you’re done, stop the daemons with:

  $ sbin/stop-yarn.sh

运行
```
[root@hadoop hadoop-3.1.1]# sbin/start-yarn.sh 
Starting resourcemanager
ERROR: Attempting to operate on yarn resourcemanager as root
ERROR: but there is no YARN_RESOURCEMANAGER_USER defined. Aborting operation.
Starting nodemanagers
ERROR: Attempting to operate on yarn nodemanager as root
ERROR: but there is no YARN_NODEMANAGER_USER defined. Aborting operation.
```
解决

在sbin/start-yarn.sh 文件中加上如下部分
```
YARN_RESOURCEMANAGER_USER=root
YARN_NODEMANAGER_USER=root
```

