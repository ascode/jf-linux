# CentOS6.3 重启后/etc/resolv.conf 被还原解决办法

今天一台服务器上不了网，设置了nameserver，重启后/etc/resolv.conf文件就被自动还原了，最后发现是被Network Manager修改了。
## 解决方法：
1.停止Network Manager服务
service NetworkManager stop
重启网络服务
/etc/init.d/network restart

2.彻底废掉Network Manager
chkconfig NetworkManager off

3.修改网卡配置
vi /etc/sysconfig/network-scripts/ifcfg-eth0

DEVICE="eth0"  //指出设备名称
BOOTPROTO="tatic"  //获取ip类型 dhcp或static DHCP动态分配或静态设置  
HWADDR="00:22:15:3A:F4:7E"  //MAC地址
BROADCAST=192.168.1.255  //广播地址
IPADDR=192.168.1.4  //ip地址
NETMASK=255.255.255.0  //子网掩码
GATEWAY=192.168.1.3  //网关
NM_CONTROLLED="no"  //是否允许Network Manager管理，当然NO啦！废掉Network Manager了都！
ONBOOT="yes"//系统启动的时候网络接口是否有效
TYPE="Ethernet"//网络类型
现在再编辑 /etc/resolv.conf 添加要使用DNS,以Google为例：
nameserver 8.8.8.8
nameserver 8.8.4.4
保存并重启网络服务即可
service network restart