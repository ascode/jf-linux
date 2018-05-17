
### OrientDB

* 说明

If you have Docker installed in your computer, this is the easiest way to run OrientDB. From the command line type:

```
$ docker run -d --name orientdb -p 2424:2424 -p 2480:2480
   -e ORIENTDB_ROOT_PASSWORD=root orientdb:latest
```
Where instead of "root", type the root's password you want to use.

* 网址

https://orientdb.com/docs/last/Tutorial-Installation.html