CentOS7mini版本启动网卡、替换yum源

最近本人安装了一个CentOS7mini版本的虚拟机，进去之后碰到了一系列问题，因为是精简版本，所以很多软件和插件都需要自己安装，并且没有安装图形化界面，完全是命令行进行操作，目的就是为了熟悉Linux环境下的一些命令和知识。


一、启动网卡。

执行命令：

cd /etc/sysconfig/network-scripts/

然后ls一下，会发现ifcfg-ens33的一个文件。
![](http://image.bgenius.cn/jinfei/github/zn-linux/Screen%20Shot%202016-12-31%20at%203.47.51%20AM.png)
ls -lh 检查这个文件的权限
![](http://image.bgenius.cn/jinfei/github/zn-linux/Screen%20Shot%202016-12-31%20at%203.40.59%20AM.png)

vi ifcfg-ens33然后将onboot=no改成onboot=yes，保存后退出。

执行命令: ifup ifcfg-eno16777736 