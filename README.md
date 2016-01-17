# zn-linux
linux note

## 简单任务
### 添加用户
useradd -d /home/newuser newuser 添加用户，并指定用户文件夹路径  
passwd username 给这个用户设置密码  
mkdir -p /home/newuser 给新用户创建用户目录  
chown newuser:newuser /home/newuser 将拥有者改成新用户本身  

### 原理
Linux下如何创建新用户通常情况下，处于安全考虑，一般都给自己创建一个普通用户，而不直接使用root用户，因为权限大了，误操作就容易带来无法弥补的损失。Linux系统中，只有root用户有创建其他用户的权限。
基本步骤如下：  
1. 用户的主目录和用户名  
2. 显式设定密码  
3. 使用root账户创建新用户的主目录
4. Linux系统需要主目录的拥有者必须是用户本身，因此，使用root创建主目录以后，还需将拥有者更换成新用户本身  