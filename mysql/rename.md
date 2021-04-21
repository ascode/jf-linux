# MySQL库改名、表改名

数据库中的库或表在开发环境下可能需要改名，关于MySQL的改名步骤如下：

### 1、备份数据库,备份后就可以安心的去改名了，如果操作错误还可以及时恢复

mysqldump -R -uroot -p 数据库名称> xxx.sql

### 2、表改名

rename table database.oldtable to database.newtable

例子：

rename table house.record to house.bookrecord;

### 3、库改名

create  database  newdatabase;

rename table olddatabase.table1 to newdatabase.table1;

rename table olddatabase.table2 to newdatabase.table2;

rename table olddatabase.table3 to newdatabase.table3;

drop database olddatabase;

### 4、检查是否改名成功，可以查看一下对应库下的表以及表中的部分内容

例子：

create database newhouse;

rename table house.admin TO newhouse.admin;

rename table house.confirm TO newhouse.confirm;

rename table house.contacts TO newhouse.contact;

rename table house.record to newhouse.bookrecord;

drop database hosue;