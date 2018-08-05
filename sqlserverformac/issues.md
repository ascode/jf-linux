# Mac下使用mssql server


* 在容器内创建备份文件夹
```
mkdir /var/opt/mssql/backup
```

* 拷贝sql server数据库备份文件到docker容器
```
sudo docker cp /Users/front/Downloads/beifen.bak MSSQL_1433:/var/opt/mssql/backup
```

* 运行sqlcmd到逻辑文件名称和备份内的路径的列表容器内
```
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'Neural123*()' -Q 'RESTORE FILELISTONLY FROM DISK = "/var/opt/mssql/backup/CeShi_ZT01.bak"' | tr -s ' ' | cut -d ' ' -f 1-2
```

* 连接到sqlcmd
```
/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'yourStrong(!)Password'
```

* 查看备份文件的逻辑文件名
```
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'Neural123*()' -Q "RESTORE FILELISTONLY from disk=N'/var/opt/mssql/backup/CeShi_ZT01.bak'"
```


* 恢复数据库
```
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'Neural123*()' -Q 'RESTORE DATABASE EXD4 FROM DISK = "/var/opt/mssql/backup/CeShi_ZT01.bak" WITH MOVE "CeShi_ZT01_dat" TO "/var/opt/mssql/data/EXD4.mdf", MOVE "CeShi_ZT01_log" TO "/var/opt/mssql/data/EXD4.ldf"'
```


