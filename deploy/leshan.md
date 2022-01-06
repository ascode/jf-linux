# 乐山谐波镜像部署

## 镜像制作和部署

更新文件

```
docker cp ./dist a5a780ec6ac0:/data
```

在容器中做好手动部署

```
docker exec -it a5a780 /bin/bash
```

测试没问题之后，然后执行如下命令得到镜像文件。

```
docker commit -a "fashiontech.top" -m "前端版本" a5a780ec6ac0  lehm:v1.27
docker save -o ~/lehm_v1_27.tar lehm:v1.27
```

在要部署的机器上载入镜像

```
docker load -i /home/docker/lehm/lehm_v1_6.tar
```

启动容器
```
docker run -d --name lehm -p 20010:80 lehm:v1.12 /bin/sh -c "/data/start.sh"
```

## 用过的命令记录

```
docker run -d --name lehm -p 20010:80 lehm:v1.5 /bin/sh -c "/usr/sbin/nginx;tail -f /var/log/nginx/error.log"

docker run -d --name lehm -p 8010:80 lehm:v1.5 /bin/sh -c "/usr/sbin/nginx;tail -f /var/log/nginx/error.log"

docker run -d --name lehm-be -p 8020:80 -p 8021:8080 lehm:v1.5 /bin/sh -c "java -jar -Dspring.config.location=/data/application.yml /data/leshan-0.0.1-SNAPSHOT.jar &;/usr/sbin/nginx;tail -f /var/log/nginx/error.log"

docker run -d --name lehm-be -p 8020:80 -p 8021:8080 lehm:v1.6 /bin/sh -c "/usr/sbin/nginx;export JAVA_HOME=/data/java/jdk1.8.0_271;export PATH=$JAVA_HOME/bin:$PATH;java -jar /data/leshan-0.0.1-SNAPSHOT.jar --spring.config.location=/data/application.yml &;tail -f /var/log/nginx/error.log"

docker run -d --name lehm-be -p 8020:80 -p 8021:8080 lehm:v1.6 /bin/sh -c "/usr/sbin/nginx;tail -f /var/log/nginx/error.log"


docker run -d --name bm-server -p 20008-20009:3000-3001 bm-server:v1.1 /bin/sh -c "ms-server.sh start"

docker cp ./Downloads/bigemap/武汉市_电子地图/ 7690737a8ebb:/usr/local/tilesets



docker exec -it 58 /bin/bash

docker-compose -f docker-compose.yml up

docker run -it -d -p 8010:80 lehm:v1.2 /bin/bash




docker run -it -d --name lehm -p 8010:80 lehm:v1.4 /bin/bash 


docker save -o ~/lehm_v1_4.tar lehm:v1.4


docker run -it -d -p 40056:80 lehm:v1.2 /bin/bash

docker commit -a "fashiontech.top" -m "前端版本" b3751c2ef11d  lehm:v1.4

docker load -i bm-server_v1_1.tar 

Maven项目打包数据库连接报错解决办法:使用下面命令跳过单元测试即可。
mvn package -Dmaven.test.skip=true


export JAVA_HOME=/Users/alston/Library/java/JavaVirtualMachines/corretto-1.8.0_265-1/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH

export JAVA_HOME=/data/java/jdk1.8.0_271
export PATH=$JAVA_HOME/bin:$PATH


java -jar -Dspring.config.location=./src/main/resources/application.yml ./target/leshan-0.0.1-SNAPSHOT.jar
java -jar -Dspring.config.location=/data/application.yml /data/leshan-0.0.1-SNAPSHOT.jar

java -jar ./target/leshan-0.0.1-SNAPSHOT.jar --spring.config.location=./src/main/resources/application.yml
java -jar ./leshan-0.0.1-SNAPSHOT.jar --spring.config.location=./application.yml 


java -jar ./target/leshan-0.0.1-SNAPSHOT.jar --soap.url="http://ascode.gicp.net:20080/PQWeb/_WebService/CustomService.asmx" --soap.leurl="http://ascode.gicp.net:20080/le/Service.asmx" --http.referer="http://ascode.gicp.net:20080/PQWeb/loginscn.html"

java -jar /data/leshan-0.0.1-SNAPSHOT.jar --spring.config.location=/data/application.yml &





vue.config.js
publicPath: process.env.NODE_ENV === "production" ? "/xbzj/" : "/",


Config/index.js
dev.proxyTable添加：
      '/xbzj-api': {
        target: 'http://localhost:8080',
        changeOrigin: true,
        pathRewrite: {
          '^/xbzj-api': '/xbzj-api'
        }
      },

build.assetsPublicPath: '/xbzj/',



dev.env.js
  VUE_APP_BASE_API: '"http://localhost:9020"'
prod.env.js
  VUE_APP_BASE_API: '"http://localhost:8080"'





现场用过的命令：

docker run -d --name lehm -p 40059:80 lehm:v1.5 /bin/sh -c "/usr/sbin/nginx;tail -f /var/log/nginx/error.log"

docker load -i /home/docker/lehm/lehm_v1_6.tar

docker run -d --name lehm-test -p 20010:80 -p 40070:8080 lehm:v1.6 /bin/sh -c "/usr/sbin/nginx;tail -f /var/log/nginx/error.log"

docker cp /home/docker/lehm/dist a40806c:/data

docker exec -it a40806c /bin/bash

docker cp ./leshan-0.0.1-SNAPSHOT.jar a40806c:/data



docker run -d --name lehm -p 20010:80 lehm:v1.12 /bin/sh -c "/data/start.sh"



docker run -d --name bm-server -p 20008-20009:3000-3001 bm-server:v1.1 /bin/sh -c "ms-server.sh start"
```