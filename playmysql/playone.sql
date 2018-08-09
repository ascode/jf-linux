# 主报表：全年龄段特征（年龄段分布比例，内容分类比例，学习总次数，购买比例，产品使用比例分布）

# 年龄段钻取： 选中年龄段的共有特征（单段学习时长，内容分类比例，学习总次数，购买比例，产品使用比例分布）



SELECT id_user,study_duration FROM dm_usr_study_record 

select * from dm_usr_users order by id desc limit 5;

select * from dm_usr_users limit 50;


# 准备数据
# 清理出生日期默认值，全部用随机数据
drop procedure if exists  proc_update_dm_usr_users_born_date;

CREATE PROCEDURE `proc_update_dm_usr_users_born_date` ()
BEGIN
declare year int;
declare month int;
declare day int;
declare born_date varchar(50);
declare start_id int default 1;
set start_id = 1;

WHILE (start_id < 1300)
do
set year = round(1955 + rand()*1000000000%60);
set month = round(rand()*1000000000%11)+1;
set day = round(rand()*1000000000%27)+1;
set born_date = concat(year,'-',month,'-',day);
UPDATE dm_usr_users set born_date = born_date WHERE id = start_id;
set start_id = start_id + 1;
end while;
END

call proc_update_dm_usr_users_born_date();