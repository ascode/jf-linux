#!/bin/bash

export JAVA_HOME=/data/java/jdk1.8.0_271
export PATH=$JAVA_HOME/bin:$PATH
source /etc/profile
/usr/sbin/nginx
java -jar /data/leshan-0.0.1-SNAPSHOT.jar &
tail -f /var/log/nginx/error.log