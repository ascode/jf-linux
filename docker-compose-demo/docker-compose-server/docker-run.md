docker run --detach --publish 18080:8080 cptactionhank/atlassian-jira:latest


## 运行mariadb

docker run  --restart always --name mariadb1 -p 3306:3306 -v D:/DockerShare/MariaDB/conf:/etc/mysql -v D:/DockerShare/MariaDB/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=Vosung123 -d mariadb