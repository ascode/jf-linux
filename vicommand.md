## vi 命令  
/  查找  
/shanghai  查找shanghai段文字，可以按下n查找下一个,N查找上一个    
x 删除光标后面的一个字符  
dd 删除一行  
2dd 删除两行  
3dd 删除三行  
u 返回相当于很多软件里面的Ctrl+z  
U 撤销当前所有编辑  
GG 跳转到最后一行  
gg 跳转到第一行  
shift+4 跳到行末  
shift+^ 跳到行首  
yy 复制一行  
2yy 复制两行  
p 粘贴  
yG 光标行复制到末尾行  
ygg 光标行复制到首行  
dG 删除光标行末尾行  
dgg 删除光标行到首行  
o 在光标行下面插入一行并进入编辑模式  
O 在光标行上面长如一行并进入编辑模式  
dw 删除一个单词  
a 在光标所在字符后面插入  
A 在行尾插入  
:%s/jinfei/liping/  将jifnei替换成liping（斜杠可以换成#或者@）  
:4,5s/jifnei/liping/  将第四和第五行的jinfei替换成liping  
:%s/jinfei/liping/g  将全部的jifnei替换成liping  
:1s/jinfei/liping/1  将第一个出现的jifnei替换成liping
:%s/http:\/\/www.baidu.com\//abc/ 将全部的http://www.baidu.com替换成abc。这里可以使用#或者@避免转义:%s#http://www.baidu.com/#abc#  
:%s/\.$/beijing/ 将结尾的.符号替换成beijing  
:%s/^my/you/ 将my开头的my替换成you  
:set nu 显示行号  
:set nonu 隐藏行号  
:402s/index.html/index.php/g 将402行的index.html换成index.php  
/^DirectoryIndex/s/index.html/index.php/g 找到DirectoryIndex开头的行，然后开始查找index.html然后替换成index.php  
  


  