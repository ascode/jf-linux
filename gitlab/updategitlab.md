# 配置gitlab的更新

其实很简单，只需要安装上更新源，然后yum update -y就可以更新了。

gitlab_gitlab-ce.repo
~~~
[gitlab_gitlab-ce]
name=gitlab_gitlab-ce
baseurl=https://packages.gitlab.com/gitlab/gitlab-ce/el/7/$basearch
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packages.gitlab.com/gitlab/gitlab-ce/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300

[gitlab_gitlab-ce-source]
name=gitlab_gitlab-ce-source
baseurl=https://packages.gitlab.com/gitlab/gitlab-ce/el/7/SRPMS
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packages.gitlab.com/gitlab/gitlab-ce/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300
~~~

runner_gitlab-ci-multi-runner.repo 
~~~
[runner_gitlab-ci-multi-runner]
name=runner_gitlab-ci-multi-runner
baseurl=https://packages.gitlab.com/runner/gitlab-ci-multi-runner/el/7/$basearch
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packages.gitlab.com/runner/gitlab-ci-multi-runner/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300

[runner_gitlab-ci-multi-runner-source]
name=runner_gitlab-ci-multi-runner-source
baseurl=https://packages.gitlab.com/runner/gitlab-ci-multi-runner/el/7/SRPMS
repo_gpgcheck=1
gpgcheck=0
enabled=1
gpgkey=https://packages.gitlab.com/runner/gitlab-ci-multi-runner/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300
~~~

