

### sql server
启动容器
```
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Neural123*()' -e 'MSSQL_PID=Enterprise' -p 1433:1433 -d microsoft/mssql-server-linux:latest
```

<!-- ```
docker run -v /Users/jinfei/Laboratory/DockerShare/MSSqlServer/mssql/data:/var/opt/mssql/data -u 0 -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Neural123*()' -e 'MSSQL_PID=Enterprise' -p 1433:1433 -d microsoft/mssql-server-linux:latest
``` -->

查看容器里面的文件
```
docker exec -it f61 ls /
```

```
docker exec -it <container_id|container_name> /opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P <your_password>
```

找到数据库存放的路径
```
docker exec -it f61 find / -name '新建的数据库名*'
```
通过如上的查找，找到了sql server默认安装的数据库文件路径为：/var/opt/mssql

### OrientDB
```
$ docker run -d --name orientdb -p 2424:2424 -p 2480:2480 \
    -v <config_path>:/orientdb/config \
    -v <databases_path>:/orientdb/databases \
    -v <backup_path>:/orientdb/backup \
    -e ORIENTDB_ROOT_PASSWORD=rootpwd \
    -e ORIENTDB_NODE_NAME=odb1 \
    orientdb /orientdb/bin/server.sh  -Ddistributed=true
```