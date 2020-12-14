# 业务
# 定时添加用户，模拟用户注册

#查看当前是否已开启事件调度器
show variables like 'event_scheduler';

#要想保证能够执行event事件，就必须保证定时器是开启状态，默认为关闭状态
set global event_scheduler =1;
#或者set GLOBAL event_scheduler = ON;

# 选择库
use pconnect;
SELECT * FROM dm_usr_users;

# 如果原来存在该名字的任务计划则先删除
drop event if exists event_generator_user;


# 每隔5秒钟
delimiter $$
create event IF NOT EXISTS event_generator_user
on schedule every 5 Second starts timestamp '2018-08-09 00:00:00'
do
begin
	start transaction;
	set @timenow=now();
    set @maxid = (select max(id) from dm_usr_users);
    set @firstname = concat('飞', @maxid) ;
    set @lastname = concat('金',@maxid);
    set @year = round(1955 + rand()*1000000000%60);
    set @month = round(rand()*1000000000%11) + 1;
    set @day = round(rand()*1000000000%27) + 1;
    set @born_date = concat(@year,'-',@month,'-',@day);
    insert into dm_usr_users (first_name, last_name, born_date, source)  values(@firstname,@lastname,@born_date,'generator');
	commit;
end $$
delimiter ;

# 停止
ALTER EVENT event_generator_user DISABLE;
# 开启
alter event event_generator_user enable;

# 查看状态
select * from mysql.event


# 注意：真实的开发环境中，会遇到mysql服务重启或者断电的情况，此时则会出现事件调度器被关闭的情况，所有事件都不在起作用，要想解决这个办法，则需要在mysql.ini文件中加入event_scheduler = ON; 的语句


select count(*) from dm_usr_users;

select * from dm_usr_users order by id desc limit 5;