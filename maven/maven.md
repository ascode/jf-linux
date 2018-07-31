
## 学习maven的使用

### 安装maven

到官网下载并解压到自己指定的目录

### 配置JAVA_HOME


### 配置MAVEN_HOME

```
export PATH=/Users/jinfei/Tools/apache-maven-3.5.3/bin:$PATH
```

### 配置本地仓库

```
<!-- localRepository
   | The path to the local repository maven will use to store artifacts.
   |
   | Default: ${user.home}/.m2/repository
    <localRepository>/path/to/local/repo</localRepository>
  -->
```

### 配置镜像

默认Demo如下：

```
<mirrors>
    <!-- mirror
     | Specifies a repository mirror site to use instead of a given repository. The repository that
     | this mirror serves has an ID that matches the mirrorOf element of this mirror. IDs are used
     | for inheritance and direct lookup purposes, and must be unique across the set of mirrors.
     |
    <mirror>
      <id>mirrorId</id>
      <mirrorOf>repositoryId</mirrorOf>
      <name>Human Readable Name for this Mirror.</name>
      <url>http://my.repository.com/repo/path</url>
    </mirror>
     
-->
</mirrors>
```

在mirrors中加入如下配置节，使用阿里的maven镜像

```
<mirror>
        <id>nexus-aliyun</id>
        <mirrorOf>*</mirrorOf>
        <name>Nexus aliyun</name>
        <url>http://maven.aliyun.com/nexus/content/groups/public</url>
    </mirror> 
```

### 获取常用maven插件

```
mvn help:system
```