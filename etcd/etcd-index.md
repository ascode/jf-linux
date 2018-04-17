目录
* [etcd静态配置部署]()

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
