# ipv6操作

* ping6   
```
输入命令格式：
ping6 +空格+ipv6地址+%+接口设备
例子：
ping6  2409:8a4c:1437:9351:c9f4:38d8:a04c:1fc1
ping6  2409:8a4c:1437:9351:c9f4:38d8:a04c:1fc1%eth0
```

* telnet  
```
telnet -6 2409:8a4c:1437:9351:c9f4:38d8:a04c:1fc1 80
telnet 2409:8a4c:1437:9351:c9f4:38d8:a04c:1fc1 80
```


* netstat  
显示路由选择表中的ipv6路由
```
netstat -A inet6 –rn
```

* traceroute6  
路径跟踪并发现到目的网络的MTU值
```
traceroute6 2409:8a4c:1437:9351:c9f4:38d8:a04c:1fc1
```