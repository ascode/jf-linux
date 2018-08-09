# mysql 定时任务job

```
#查看当前是否已开启事件调度器
show variables like 'event_scheduler';

#要想保证能够执行event事件，就必须保证定时器是开启状态，默认为关闭状态
set global event_scheduler =1;
#或者set GLOBAL event_scheduler = ON;

# 选择库
use TRAVEL_CARD_UAT;

# 如果原来存在该名字的任务计划则先删除
drop event if exists SetEVToInvalidStatus_AtNight_0100;

delimiter $$
 # 每天晚上01:00
create event SetEVToInvalidStatus_AtNight_0100  
#on schedule every 1 DAY   starts timestamp '2017-04-24 10:00:00'
# 测试使用 1 hour
on schedule every 1 hour starts timestamp '2017-04-24 10:00:10'
do
begin
    start transaction;
    set @timenow=now(); #开始事务
    # 表1
    update tb_ev_stocks set FSTATUS=3 where FSTATUS=0 and FVALIDENDDATE < @timenow ;  
    # 表2
    update tb_ev_stock_details set FSTATUS=3 where FSTATUS=0 and FVALIDENDDATE < @timenow ;
    commit;  #提交事务

end  $$
delimiter ;

# 停止
ALTER EVENT SetEVToInvalidStatus_AtNight_0100 DISABLE;
# 开启
alter event SetEVToInvalidStatus_AtNight_0100 enable;

# 查看状态
select * from mysql.event
```

注意：真实的开发环境中，会遇到mysql服务重启或者断电的情况，此时则会出现事件调度器被关闭的情况，所有事件都不在起作用，要想解决这个办法，则需要在mysql.ini文件中加入event_scheduler = ON; 的语句

创建事件语法：

```
CREATE EVENT [IF NOT EXISTS] event_name  
ON SCHEDULE schedule  
[ON COMPLETION [NOT] PRESERVE]  
[ENABLE | DISABLE]  
[COMMENT 'comment']  
DO sql_statement;  
  
schedule:  
AT TIMESTAMP [+ INTERVAL INTERVAL]  
| EVERY INTERVAL [STARTS TIMESTAMP] [ENDS TIMESTAMP]  
  
INTERVAL:  
quantity {YEAR | QUARTER | MONTH | DAY | HOUR | MINUTE |  
            WEEK | SECOND | YEAR_MONTH | DAY_HOUR | DAY_MINUTE |  
            DAY_SECOND | HOUR_MINUTE | HOUR_SECOND | MINUTE_SECOND}  
```

修改事件语法：
```
ALTER EVENT event_name  
[ON SCHEDULE schedule]  
[RENAME TO new_event_name]  
[ON COMPLETION [NOT] PRESERVE]  
[COMMENT 'comment']  
[ENABLE | DISABLE]  
[DO sql_statement] 
```
