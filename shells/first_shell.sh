#!/bin/bash
echo -e "\033[35m this is the first shell command exercise \033[0m"
mkdir -p /tmp/20161028
echo -e  "\033[32m hello,world \033[0m"
a=www.xiaoyouping.club
echo $a
echo www.xiaoyouping.club
LAMP="httpd httpd-devel php php-devel mysql mysql-server mysql-devel"
yum install $LAMP
