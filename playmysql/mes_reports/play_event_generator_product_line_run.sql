# 业务
# 模拟产线生产过程
use mes_reports;
#查看当前是否已开启事件调度器
show variables like 'event_scheduler';

#要想保证能够执行event事件，就必须保证定时器是开启状态，默认为关闭状态
set global event_scheduler =1;
#或者set GLOBAL event_scheduler = ON;

# 选择库
use mes_reports;

# 如果原来存在该名字的任务计划则先删除
drop event if exists event_generator_user;


# 模拟每隔1秒钟采集一次数据
delimiter $$
create event IF NOT EXISTS event_generator_line_run
on schedule every 1 Second starts timestamp '2018-08-09 00:00:00'
do
# TODO:模拟开机自检
# TODO:模拟开机预热
# TODO:模拟采集生产速度微分记录
# TODO:模拟采集生产效率微分记录
# TODO:模拟设备1例行自动清理
# TODO:模拟设备2例行自动清理
# TODO:模拟设备3条件自动清理
# TODO:模拟设备4例行自动清理
# TODO:模拟设备1例行冷却
# TODO:模拟设备2例行冷却
# TODO:模拟设备3条件冷却
# TODO:模拟设备4条件冷却
# TODO:模拟停机_保养
# TODO:模拟停机_维修
# TODO:模拟停机_等待
# TODO:模拟停机_清洗
# TODO:模拟停机_消毒
# TODO:模拟停机_自检
# TODO:模拟停机_故障

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