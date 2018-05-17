# CentOS系统安装内核时提示/boot分区空间不足问题的解决方法  


*这篇文章主要介绍了CentOS系统安装内核时提示/boot分区空间不足问题的解决方法,不过在此还是建议用户在分区时尽量留给boot足够的磁盘空间,需要的朋友可以参考下*


今天登录服务器，准备使用 yum 安装一个软件，习惯性的先 yum update 一下，结果最后出现如下错误:
```

...
Transaction check error:
installing package kernel-3.10.0-327.4.5.el7.x86_64 needs 20MB on the /boot filesystem
Error Summary
-------------
Disk Requirements:
At least 20MB more space needed on the /boot filesystem.
```

看提示是要安装新的 Linux 内核包，但 /boot 文件系统空间不足 20MB。所以更新失败了。
好吧，那就看看 /boot 下面到底还有多少空间。


```
> df -H /boot
Filesystem Size Used Avail Use% Mounted on
/dev/sda1 247M 237M 10M 96% /boot
```

嗯，只有 10M 了，电脑是不会撒谎的。怎么办呢，/boot 文件系统是很重要的，弄不好系统就挂了，我可不想出现这样的结局，明天可是周六。
网上搜索了一番，原来可以尝试删除旧的内核包来达到清理空间的目的。 (文章地址)
先看看有没有旧的内核包:

```
> rpm -qa|grep kernel
kernel-3.10.0-229.14.1.el7.x86_64
kernel-3.10.0-229.11.1.el7.x86_64
kernel-devel-3.10.0-229.11.1.el7.x86_64
kernel-3.10.0-327.4.4.el7.x86_64
kernel-devel-3.10.0-327.4.4.el7.x86_64
kernel-devel-3.10.0-229.14.1.el7.x86_64
kernel-headers-3.10.0-327.4.4.el7.x86_64
kernel-3.10.0-229.el7.x86_64
kernel-tools-libs-3.10.0-327.4.4.el7.x86_64
kernel-tools-3.10.0-327.4.4.el7.x86_64
```

嗯，有的，那就好。不过开始之前，我还要确认一下当前系统用的是哪个，删错了可不好。

```
> uname -a
Linux ... 3.10.0-229.14.1.el7.x86_64 #1 ... GNU/Linux
```

看样子我只要不动 3.10.0-229.14.1 就个版本可以了。我决定删 3.10.0-229.11.1 这个版本。

```
> sudo rpm -e kernel-3.10.0-229.11.1.el7.x86_64 kernel-devel-3.10.0-229.11.1.el7.x86_64
```

然后再看看 /boot 文件系统的可用大小。

```
> df -H /boot
Filesystem Size Used Avail Use% Mounted on
/dev/sda1 247M 190M 57M 78% /boot
```

有 57M 了，足够了。再次执行 sudo yum update，更新新的内核包成功。