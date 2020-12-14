# Tomcat  

在centos上安装Tomcat，只需要下载tar.gz包，解压就可以直接用。使用方法就是运行bin目录下面的startup.sh或者shutdown.sh  

但是在使用Tomcat之前需要配置jdk环境。根据最近一次安装的经验，其实只需要配置JRE_HOME环境变量，并在/etc/profile里面配置好就行了。  

Tomcat默认测试页面是http://127.0.0.1:8080/ 

另外还可以在Tomcat配置文件中配置环境变量：  
在apache-tomcat-8.0.26/bin/setclasspath.sh中添加一下内容
```
export JAVA_HOME=/usr/java/jdk1.8.0_60  
export JRE_HOME=/usr/java/jdk1.8.0_60/jre    
export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH    
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
```

后期注意一下Tomcat性能优化  