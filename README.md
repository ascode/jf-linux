# zn-linux
linux note

## 简单任务
### 添加用户
useradd -d /home/newuser newuser 添加用户，并指定用户文件夹路径  
passwd username 给这个用户设置密码  
mkdir -p /home/newuser 给新用户创建用户目录  
chown newuser:newuser /home/newuser 将拥有者改成新用户本身  
