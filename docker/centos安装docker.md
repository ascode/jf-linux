


安装Docker CE版本的容器引擎
不管是在 Ubuntu 或 CentOS 都只需要执行该指令就会自动安装最新版 Docker。
```
curl -fsSL https://get.docker.com/ | sh
```

官网给出的安装是这样的：

```
$ curl -fsSL https://get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh
```

启动docker

systemctl enable docker && systemctl start docker