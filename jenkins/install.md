

- 安装完了之后出现如下提示

~~~
INFO: 

*************************************************************
*************************************************************
*************************************************************

Jenkins initial setup is required. An admin user has been created and a password generated.
Please use the following password to proceed to installation:

ebd8f2970c344abe8e1f3de1cba4db61

This may also be found at: /root/.jenkins/secrets/initialAdminPassword

*************************************************************
*************************************************************
*************************************************************

Sep 07, 2017 10:16:12 AM hudson.model.UpdateSite updateData
INFO: Obtained the latest update center data file for UpdateSource default
Sep 07, 2017 10:16:12 AM hudson.WebAppMain$3 run
INFO: Jenkins is fully up and running
~~~

- 运行jenkins

Run java -jar jenkins.war --httpPort=8080