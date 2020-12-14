### 大小写敏感

1、linux下mysql安装完后是默认：区分表名的大小写，不区分列名的大小写；

2、用root帐号登录后，在/etc/my.cnf 中的[mysqld]后添加添加lower_case_table_names=1，重启MYSQL服务，这时已设置成功：不区分表名的大小写；

```
ower_case_table_names参数详解：
lower_case_table_names = 0
其中 0：区分大小写，1：不区分大小写
MySQL在Linux下数据库名、表名、列名、别名大小写规则是这样的：
　　 1、数据库名与表名是严格区分大小写的；
　　 2、表的别名是严格区分大小写的；
　　 3、列名与列的别名在所有的情况下均是忽略大小写的；
　　 4、变量名也是严格区分大小写的；
MySQL在Windows下都不区分大小写。
3、如果想在查询时区分字段值的大小写，则：字段值需要设置BINARY属性，设置的方法有多种：
A、创建时设置：
CREATE TABLE T(
A VARCHAR(10) BINARY
);
```