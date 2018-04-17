目录
* [etcd静态配置部署]()


1、什么是 etcd

etcd 是 CoreOS 团队于 2013 年 6 月发起的开源项目，它的目标是构建一个高可用的分布式键值（key-value）数据库，基于 Go 语言实现。我们知道，在分布式系统中，各种服务的配置信息的管理分享，服务的发现是一个很基本同时也是很重要的问题。CoreOS 项目就希望基于 etcd 来解决这一问题。

etcd 目前在 github.com/coreos/etcd 进行维护。

受到 Apache ZooKeeper 项目和 doozer 项目的启发，etcd 在设计的时候重点考虑了下面四个要素：

* 简单：支持 REST 风格的 HTTP+JSON API
* 安全：支持 HTTPS 方式的访问
* 快速：支持并发 1k/s 的写操作
* 可靠：支持分布式结构，基于 Raft 的一致性算法

注：Apache ZooKeeper 是一套知名的分布式系统中进行同步和一致性管理的工具。 注：doozer 则是一个一致性分布式数据库。 注：Raft 是一套通过选举主节点来实现分布式系统一致性的算法，相比于大名鼎鼎的 Paxos 算法，它的过程更容易被人理解，由 Stanford 大学的 Diego Ongaro 和 John Ousterhout 提出。更多细节可以参考 raftconsensus.github.io。

一般情况下，用户使用 etcd 可以在多个节点上启动多个实例，并添加它们为一个集群。同一个集群中的 etcd 实例将会 保持彼此信息的一致性。

2、安装

## 准备服务器
```
etcd211:192.168.137.211 centos7
etcd212:192.168.137.212 centos7
etcd213:192.168.137.213 centos7
```
在每个服务器上需要打开端口：2380,2379
```
firewall-cmd --add-port=2380/tcp --permanent
firewall-cmd --add-port=2379/tcp --permanent
firewall-cmd --reload
```

同步服务器时钟：
```
yum -y install ntp
ntpdate pool.ntp.org
systemctl start ntpd
systemctl enable ntpd
```

## 安装
yum install etcd -y

## 静态配置
### 修改配置文件
* etcd.conf: /etc/etcd/etcd.conf
* etcd.service: /usr/lib/systemd/system/etcd.service

/etc/etcd/etcd.conf
```
[Member]
#ETCD_CORS=""
ETCD_DATA_DIR="/var/lib/etcd/etcd211"
#ETCD_WAL_DIR=""
ETCD_LISTEN_PEER_URLS="http://192.168.137.211:2380"
ETCD_LISTEN_CLIENT_URLS="http://192.168.137.211:2379,http://127.0.0.1:2379"
#ETCD_MAX_SNAPSHOTS="5"
#ETCD_MAX_WALS="5"
ETCD_NAME="etcd211"
#ETCD_SNAPSHOT_COUNT="100000"
#ETCD_HEARTBEAT_INTERVAL="100"
#ETCD_ELECTION_TIMEOUT="1000"
#ETCD_QUOTA_BACKEND_BYTES="0"
#ETCD_MAX_REQUEST_BYTES="1572864"
#ETCD_GRPC_KEEPALIVE_MIN_TIME="5s"
#ETCD_GRPC_KEEPALIVE_INTERVAL="2h0m0s"
#ETCD_GRPC_KEEPALIVE_TIMEOUT="20s"
#
[Clustering]
ETCD_INITIAL_ADVERTISE_PEER_URLS="http://192.168.137.211:2380"
ETCD_ADVERTISE_CLIENT_URLS="http://192.168.137.211:2379"
#ETCD_DISCOVERY=""
#ETCD_DISCOVERY_FALLBACK="proxy"
#ETCD_DISCOVERY_PROXY=""
#ETCD_DISCOVERY_SRV=""
ETCD_INITIAL_CLUSTER="etcd211=http://192.168.137.211:2380,etcd212=http://192.168.137.212:2380,etcd213=http://192.168.137.213:2380"
ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster-1"
ETCD_INITIAL_CLUSTER_STATE="new"
#ETCD_STRICT_RECONFIG_CHECK="true"
#ETCD_ENABLE_V2="true"
```
/usr/lib/systemd/system/etcd.service
```
[Unit]
Description=Etcd Server
After=network.target
After=network-online.target
Wants=network-online.target

[Service]
Type=notify
WorkingDirectory=/var/lib/etcd/
EnvironmentFile=-/etc/etcd/etcd.conf
User=etcd
# set GOMAXPROCS to number of processors
ExecStart=/bin/bash -c "GOMAXPROCS=$(nproc) /usr/bin/etcd --name=\"${ETCD_NAME}\" --data-dir=\"${ETCD_DATA_DIR}\" --listen-client-urls=\"${ETCD_LISTEN_CLIENT_URLS}\" --listen-peer-urls=\"${ETCD_LISTEN_PEER_URLS}\" --advertise-client-urls=\"${ETCD_ADVERTISE_CLIENT_URLS}\" --initial-advertise-peer-urls=\"${ETCD_INITIAL_ADVERTISE_PEER_URLS}\" --initial-cluster-token=\"${ETCD_INITIAL_CLUSTER_TOKEN}\" --initial-cluster=\"${ETCD_INITIAL_CLUSTER}\" --initial-cluster-state=\"${ETCD_INITIAL_CLUSTER_STATE}\" "
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
```

## 启动
注意如果启动之后不能机器不能加入集群，请检查以下项目：
1. 清空/var/lib/etcd文件夹，因为data文件夹必须在第一次启动的时候自己创建。
2. 要加入集群的几个机器etcd配置中ETCD_INITIAL_CLUSTER_TOKEN必须相同。

启动命令
```
systemctl daemon-reload #修改了etcd.service之后需要执行这个命令
systemctl start
systemctl enable
```

## 测试
在211服务器上输入
```
etcdctl set name "jinfei"
jinfei
```
在212服务器上执行
```
etcdctl get name
jinfei
```
说明已经跨服务器同步数据，安装成功。

3、使用 etcdctl

etcdctl 支持如下的命令，大体上分为数据库操作和非数据库操作两类，后面将分别进行解释。
### 数据库操作

#### set
指定某个键的值。例如
```
$ etcdctl set /testdir/testkey "Hello world"
Hello world
```
支持的选项包括：
```
--ttl '0'            该键值的超时时间（单位为秒），不配置（默认为 0）则永不超时
--swap-with-value value 若该键现在的值是 value，则进行设置操作
--swap-with-index '0'    若该键现在的索引值是指定索引，则进行设置操作
```

#### get
获取指定键的值。例如
```
$ etcdctl set testkey hello
hello
$ etcdctl update testkey world
world
```
当键不存在时，则会报错。例如
```
$ etcdctl get testkey2
Error:  100: Key not found (/testkey2) [1]
```
支持的选项为
```
--sort    对结果进行排序
--consistent 将请求发给主节点，保证获取内容的一致性
```

#### update
当键存在时，更新值内容。例如
```
$ etcdctl set testkey hello
hello
$ etcdctl update testkey world
world
```
当键不存在时，则会报错。例如
```
$ etcdctl update testkey2 world
Error:  100: Key not found (/testkey2) [1]
```
支持的选项为
```
--ttl '0'    超时时间（单位为秒），不配置（默认为 0）则永不超时
```


### 非数据库操作
#### backup
备份 etcd 的数据。

支持的选项包括
```
--data-dir         etcd 的数据目录
--backup-dir     备份到指定路径
```


参考：

http://www.dockerinfo.net/etcd%E9%A1%B9%E7%9B%AE%E4%BB%8B%E7%BB%8D
