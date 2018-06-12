## git push 到Total 2406 (delta 379), reused 0 (delta 0)就不动了

### 尝试1
因为提交的文件过大造成的错误；尝试修改一下postBuffer的参数：
```
git config –global http.postBuffer 52428800
```

### 尝试2
windows的git工具，甭管是gui还是command tool，统统是基于msysgit的。而msysgit在实现上，有一点儿小瑕疵，查了万千资料，发现这个问题，由于开源的贡献者们太少太忙太不容易，耽误了4年没解决。据说是对什么side-bind-64bit的支持不好导致的。what the hell! 谁晓得那是个啥。。。

搜遍了各种solution，有牛人在server端修改git的binary文件，据说可以糊弄过关。但我不是在linux里面搭建的git server，而是mac；也没在binary文件里面找到那个要修改的string。

最后终于发现开源大牛们给出了一个解决办法（为毛早没发现啊，足足两天啊。。。），在msysgit的最新版本1.9.4里，可以通过一个设置来摆平：

在git的config里面添加：
```
git config --global sendpack.sideband false
```