# java spring boot项目部署-上

1.编写sh脚本，便于服务器上管理工程：

```
#!/bin/bash

source /etc/profile
PROG_NAME=$0
ACTION=$1

usage() {
    echo "Usage: $PROG_NAME {start|stop|restart|status|tailf}"
    exit 1;
}

# colors
red='\e[0;31m'
green='\e[0;32m'
yellow='\e[0;33m'
reset='\e[0m'

echoRed() { echo -e "${red}$1${reset}"; }
echoGreen() { echo -e "${green}$1${reset}"; }
echoYellow() { echo -e "${yellow}$1${reset}"; }

APP_HOME=$(cd $(dirname $0)/..; pwd)
app=${project.build.finalName}.${project.packaging}
cd $APP_HOME
mkdir -p logs

pidfile=logs/app.pid
logfile=logs/start.`date +%F`.log
JAVA_OPTS="${java_opts}"

bakdir=/data/ops/packages/app_bak/${project.build.finalName}
bakfile=$bakdir/${project.build.finalName}`date +%F`.${project.packaging}

function check_pid() {
    if [ -f $pidfile ];then
        pid=`cat $pidfile`
        if [ -n $pid ]; then
            running=`ps -p $pid|grep -v "PID TTY" |wc -l`
            return $running
        fi
    fi
    return 0
}

function start() {
    check_pid
    running=$?
    if [ $running -gt 0 ];then
        echoGreen "$app now is running already, pid=`cat $pidfile`"
        return 1
    fi

        nohup java -jar $JAVA_OPTS $app >> ${logfile} 2>&1 & pid=$!
  
    echoGreen "$app starting "
    for e in $(seq 10); do
        echo -n " $e"
        sleep 1
    done
    echo $pid > $pidfile
    check_pid
    running=$?
    if [ $running -gt 0 ];then
        echoGreen " ,pid=`cat $pidfile`"
        return 1
    else
        echoRed ",started fail!!!"
    fi
}

function stop() {
    pid=`cat $pidfile`
    kill -9 $pid
    echoRed "$app stoped..."
}

function restart() {
    stop
    sleep 1
    start
}

function backup(){

  if [ ! -x $bakdir ];then
    mkdir -p $bakdir

  fi

  if [ ! -f $bakfile ];then
        cp $app $bakfile
        echo $bakfile backup finish
  else
        echo $bakfile is already backup

  fi
}

function rollback(){

  if [ ! -f $bakfile ];then
        echo $bakfile backup not found
  else
        rm -f $app
        cp $bakfile $app
        echo $app rollback finish

  fi

}

function tailf() {
        tail -f $APP_HOME/$logfile
}

function status() {
    check_pid
    running=$?
    if [ $running -gt 0 ];then
        echoGreen "$app now is running, pid=`cat $pidfile`"
    else
        echoYellow "$app is stoped"
    fi
}

function main {
   RETVAL=0
   case "$1" in
      start)
         start
         ;;
      stop)
         stop
         ;;
      restart)
         restart
         ;;
      tailf)
         tailf
         ;;
      status)
         status
         ;;
      backup)
         backup
         ;;
      rollback)
         rollback
         ;;
      *)
         usage
         ;;
      esac
   exit $RETVAL
}

main $1
```


文件中包含多个站位符，可以借助spring filter打包时进行填充，如将sh起名为app.sh放置于maven格式项目的src/main/bin目录下则在pom文件中可添加如下配置,如：

```
 <profiles>
        <!--开发默认环境-->
        <profile>
            <id>dev</id>
            <activation>
                <activeByDefault>true</activeByDefault>
            </activation>
            <properties>
                <profileActive>dev</profileActive>
                <java_opts>-server -Xms512m -Xmx512m -XX:NewSize=128m -XX:MaxNewSize=128m -Xss256k</java_opts>
                <bakcupdir>/data/ops/packages/app_bak</bakcupdir>
            </properties>
        </profile>
        <!--生产环境-->
        <profile>
            <id>product</id>
            <properties>
                <profileActive>product</profileActive>
                <java_opts>-server -Xms2048m -Xmx2048m -XX:NewSize=256m -XX:MaxNewSize=256m -Xss256k</java_opts>
                <bakcupdir>/data/ops/packages/app_bak</bakcupdir>
            </properties>
        </profile>

    </profiles>

    <build>
        <finalName>liam-service</finalName>
        <resources>
            <resource>
                <directory>src/main/resources</directory>
                <filtering>true</filtering>
            </resource>
            <resource>
                <directory>src/main/resources/keys/*</directory>
                <includes>
                    <include>webank_keystore.jks</include>
                    <include>webank_truststore.jks</include>
                </includes>
                <filtering>false</filtering>
            </resource>
            <!--也就是此处配置上maven打包需要进行配置的文件-->
            <resource>
                <directory>src/main/bin</directory>
                <targetPath>${project.build.directory}/bin</targetPath>
                <filtering>true</filtering>
            </resource>
        </resources>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <version>1.5.6.RELEASE</version>
                <configuration>
                    <!--fork:  如果没有该项配置，肯呢个devtools不会起作用，即应用不会restart-->
                    <fork>true</fork>
                </configuration>
                <executions>
                    <execution>
                        <goals>
                            <!-- 用于打包jar -->
                            <goal>repackage</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.5.1</version>
                <configuration>
                    <source>${jdk.version}</source>
                    <target>${jdk.version}</target>
                    <encoding>UTF-8</encoding>
                </configuration>
            </plugin>
        </plugins>
        <pluginManagement>
            <plugins>
                <plugin>
                    <artifactId>maven-resources-plugin</artifactId>
                    <configuration>
                        <encoding>utf-8</encoding>
                        <useDefaultDelimiters>true</useDefaultDelimiters>
                        <nonFilteredFileExtensions>
                            <!--防止maven该表证书内的内容-->
                            <nonFilteredFileExtension>p12</nonFilteredFileExtension>
                            <nonFilteredFileExtension>jks</nonFilteredFileExtension>
                        </nonFilteredFileExtensions>
                    </configuration>
                </plugin>
            </plugins>
        </pluginManagement>
    </build>
```


如此将包打好后扔于服务器上，就很方便了：

```
ssh "chmod +x /data/ops/app/liam-service/bin/app.sh"
ssh "/data/ops/app/liam-service/bin/app.sh backup"
ssh "/data/ops/app/liam-service/bin/app.sh stop"
ssh "/data/ops/app/liam-service/bin/app.sh start"
```

当然借助jenkens的话会很方便~