docker 运行命令示范:
docker run --detach \
    --hostname gitlab.example.com \
    --publish 443:443 --publish 80:80 --publish 22:22 \
    --name gitlab \
    --restart always \
    --volume /srv/gitlab/config:/etc/gitlab \
    --volume /srv/gitlab/logs:/var/log/gitlab \
    --volume /srv/gitlab/data:/var/opt/gitlab \
    gitlab/gitlab-ce:latest


docker run --detach --publish 3443:443 --publish 380:80 --publish 322:22 --name gitlab-ce --restart always --volume /d/gitlabcedata/config:/etc/gitlab --volume /d/gitlabcedata/logs:/var/log/gitlab --volume /d/gitlabcedata/data:/var/opt/gitlab      gitlab/gitlab-ce:latest
