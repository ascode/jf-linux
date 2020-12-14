# 在苹果电脑上安装mariadb  
brew info mariadb  查看mariadb的介绍信息，查看版本信息，连接的命令以及启动的命令  
brew install mariadb  安装mariadb  
mysql.server start  临时启动mariadb  
brew services start mariadb  现在启动，并且在登陆的时候重启  
mysqladmin -u root password  修改root账号的密码  
mysql -u root -p 使用用户名密码连接mariadb  

