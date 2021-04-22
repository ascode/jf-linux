## git如何删除远程tag？

分为两步:

1. 删除本地tag
```
git tag -d tag-name
```

2. 删除远程tag
```
git push origin :refs/tags/tag-name
```