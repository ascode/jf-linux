# 安装consul

#### 下载consul
curl -O https://releases.hashicorp.com/consul/1.9.0/consul_1.9.0_linux_amd64.zip

可以用迅雷下载consul,下载完成之后传到服务器上
```
scp ./consul_1.9.0_linux_amd64.zip root@10.211.55.6:~
```

#### 安装zip压缩工具
yum install -y unzip zip

#### 解压
unzip consul_1.9.0_linux_amd64.zip

