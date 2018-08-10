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
drop event if exists event_generator_product_line_run;
delimiter $$
create event IF NOT EXISTS event_generator_product_line_run
on schedule every 3 Second starts timestamp '2018-08-09 00:00:00'
do
# TODO:模拟开机自检
# TODO:模拟开机预热
# TODO:模拟采集生产速度微分记录				[*]
# TODO:模拟采集生产效率微分记录				[*]
# TODO:1.模拟设备1例行自动清理
# TODO:2.模拟设备2例行自动清理
# TODO:3.模拟设备3条件自动清理
# TODO:4.模拟设备4例行自动清理
# TODO:5.模拟设备1例行冷却
# TODO:6.模拟设备2例行冷却
# TODO:7.模拟设备3条件冷却
# TODO:8.模拟设备4条件冷却
# TODO:9.模拟停机_保养
# TODO:10.模拟停机_维修
# TODO:11.模拟停机_等待								[*]
# TODO:12.模拟停机_清洗
# TODO:13.模拟停机_消毒
# TODO:14.模拟停机_自检
# TODO:15.模拟停机_故障								[*]
# TODO:16.模拟停机_自动重启
BEGIN
		start transaction;
        # 判断
        set @state=round(rand()*1000000000%17);
        set @speed = 0;
        set @speedforrate = 0;
        
		-- set @timenow=now();
-- 		set @maxid = (select max(id) from dm_usr_users);
-- 		set @firstname = concat('飞', @maxid) ;
-- 		set @lastname = concat('金',@maxid);
-- 		set @year = round(1955 + rand()*1000000000%60);
-- 		set @month = round(rand()*1000000000%11) + 1;
-- 		set @day = round(rand()*1000000000%27) + 1;
-- 		set @born_date = concat(@year,'-',@month,'-',@day);
        case when @state = 1 then
				set @speed = round(80000 + rand()*1000000000%10000);
                set @speedforrate = @speed;
			when @state = 2 then
				set @speed = round(80000 + rand()*1000000000%10000);
                set @speedforrate = @speed;
			when @state = 3 then
				set @speed = round(80000 + rand()*1000000000%10000);
                set @speedforrate = @speed;
			when @state = 4 then
				set @speed = round(80000 + rand()*1000000000%10000);
                set @speedforrate = @speed;
			when @state = 5 then
				set @speed = round(80000 + rand()*1000000000%10000);
                set @speedforrate = @speed;
			when @state = 6 then
				set @speed = round(80000 + rand()*1000000000%10000);
                set @speedforrate = @speed;
			when @state = 7 then
				set @speed = round(80000 + rand()*1000000000%10000);
                set @speedforrate = @speed;
			when @state = 8 then
				set @speed = round(80000 + rand()*1000000000%10000);
                set @speedforrate = @speed;
			when @state = 9 then
				set @speed = round(80000 + rand()*1000000000%10000);
                set @speedforrate = @speed;
			when @state = 10 then
				set @speed = round(80000 + rand()*1000000000%10000);
                set @speedforrate = @speed;
			when @state = 11 then
				set @speed = round(50000 + rand()*1000000000%10000);
                set @speedforrate = round(50000 + rand()*1000000000%10000)*0.8;
                set @sleeptmp11 = rand()*1000000%20;
                select sleep(@sleeptmp11);
                set @machinecode = (select machine_code from machine where id = (select round(1+rand()*1000000000%4)));
				insert into machine_stop_record_processed(device_code, stop_reason, stop_start_time, stop_end_time)
                values (@machinecode, '模拟停机_等待',date_sub(now(), interval @sleeptmp11 second),now());
			when @state = 12 then
				set @speed = round(80000 + rand()*1000000000%10000);
                set @speedforrate = @speed;
			when @state = 13 then
				set @speed = round(80000 + rand()*1000000000%10000);
                set @speedforrate = @speed;
			when @state = 14 then
				set @speed = round(80000 + rand()*1000000000%10000);
                set @speedforrate = @speed;
			when @state = 15 then
				set @speed = round(10 + rand()*1000000000%10000);
                set @speedforrate = @speed;
                set @sleeptmp = rand()*1000000%10;
                set @fault_code = round(rand()*1000000%10);
                select sleep(@sleeptmp);
                insert into machine_fault_record_processed(fault_code, fault_desc, fault_reason, fault_start_time, fault_end_time) 
                values(concat('ERR_00',@fault_code),concat('ERR_00',@fault_code),concat('ERR_00',@fault_code),date_sub(now(), interval @sleeptmp second),now());
			when @state = 16 then
				set @speed = round(80000 + rand()*1000000000%10000);
                set @speedforrate = @speed;
		else
				set @speed = round(80000 + rand()*1000000000%10000);
                set @speedforrate = @speed;
		end case;
        
        
        # 生产速度的微分记录
        insert into procreative_speed_differential_record(speed, picking_time, product_line_id, product_line_code, prd_product_line_name) 
        values (@speed,now(),1,'line1','Depalletiser');
        
        set @tmp_decide_speedforrate = rand();
        while (@tmp_decide_speedforrate> 0.5 and @tmp_decide_speedforrate < 0.9)
        do
        #生产效率的微分记录
        if (@speedforrate < 0.5) then
        set @speedforrate = 0.5;
        end if;
        insert into product_line_efficiency_differential_record (picking_time, rate, product_line_id, product_line_code, product_line_name)
        values (now(),@speedforrate/100000,1,'line1','Depalletiser');
        end while;
        
		#insert into dm_usr_users (first_name, last_name, born_date, source)  values(@firstname,@lastname,@born_date,'generator');
		commit;
end $$




# 停止
ALTER EVENT event_generator_user DISABLE;
# 开启
alter event event_generator_user enable;

# 查看状态
select * from mysql.event


# 注意：真实的开发环境中，会遇到mysql服务重启或者断电的情况，此时则会出现事件调度器被关闭的情况，所有事件都不在起作用，要想解决这个办法，则需要在mysql.ini文件中加入event_scheduler = ON; 的语句


select count(*) from dm_usr_users;

select * from dm_usr_users order by id desc limit 5;