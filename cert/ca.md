# 如何生成CA证书


http://blog.csdn.net/fyang2007/article/details/6180361

http://blog.sina.com.cn/s/blog_4fd50c390101891c.html

一般情况下，如果能找到可用的证书，就可以直接使用，只不过会因证书的某些信息不正确或与部署证书的主机不匹配而导致浏览器提示证书无效，但这并不影响使用。

需要手工生成证书的情况有：

- 找不到可用的证书
- 需要配置双向SSL，但缺少客户端证书
需要对证书作特别的定制
首先，无论是在Linux下还是在Windows下的Cygwin中，进行下面的操作前都须确认已安装OpenSSL软件包。

1. 创建根证书密钥文件(自己做CA)root.key：

openssl genrsa -des3 -out root.key

输出内容为：

[lenin@archer ~]$ openssl genrsa -des3 -out root.key 
Generating RSA private key, 512 bit long modulus 
……………..++++++++++++ 
..++++++++++++ 
e is 65537 (0×10001) 
Enter pass phrase for root.key: ← 输入一个新密码 
Verifying – Enter pass phrase for root.key: ← 重新输入一遍密码

2. 创建根证书的申请文件root.csr：

openssl req -new -key root.key -out root.csr

输出内容为：

[lenin@archer ~]$ openssl req -new -key root.key -out root.csr 
Enter pass phrase for root.key: ← 输入前面创建的密码 
You are about to be asked to enter information that will be incorporated 
into your certificate request. 
What you are about to enter is what is called a Distinguished Name or a DN. 
There are quite a few fields but you can leave some blank 
For some fields there will be a default value, 
If you enter ‘.’, the field will be left blank. 
—– 
Country Name (2 letter code) [AU]:CN ← 国家代号，中国输入CN 
State or Province Name (full name) [Some-State]:BeiJing ← 省的全名，拼音 
Locality Name (eg, city) []:BeiJing ← 市的全名，拼音 
Organization Name (eg, company) [Internet Widgits Pty Ltd]:MyCompany Corp. ← 公司英文名 
Organizational Unit Name (eg, section) []: ← 可以不输入 
Common Name (eg, YOUR name) []: ← 此时不输入 
Email Address []:admin@mycompany.com ← 电子邮箱，可随意填

Please enter the following ‘extra’ attributes 
to be sent with your certificate request 
A challenge password []: ← 可以不输入 
An optional company name []: ← 可以不输入

3. 创建一个自当前日期起为期十年的根证书root.crt：

openssl x509 -req -days 3650 -sha1 -extensions v3_ca -signkey root.key -in root.req -out root.crt

输出内容为：

[lenin@archer ~]$ openssl x509 -req -days 3650 -sha1 -extensions v3_ca -signkey root.key -in root.csr -out root.crt 
Signature ok 
subject=/C=CN/ST=BeiJing/L=BeiJing/O=MyCompany Corp./emailAddress=admin@mycompany.com 
Getting Private key 
Enter pass phrase for root.key: ← 输入前面创建的密码

4. 创建服务器证书密钥server.key：

openssl genrsa -des3 -out server.key 2048

输出内容为：

[lenin@archer ~]$ openssl genrsa -out server.key 2048 
Generating RSA private key, 2048 bit long modulus 
….+++ 
…………………………………………..+++ 
e is 65537 (0×10001)

运行时会提示输入密码,此密码用于加密key文件(参数des3便是指加密算法,当然也可以选用其他你认为安全的算法.),以后每当需读取此文件(通过openssl提供的命令或API)都需输入口令.如果觉得不方便,也可以去除这个口令,但一定要采取其他的保护措施! 
去除key文件口令的命令: 
openssl rsa -in server.key -out server.key

5.创建服务器证书的申请文件server.csr：

openssl req -new -key server.key -out server.csr

输出内容为：

[lenin@archer ~]$ openssl req -new -key server.key -out server.req 
You are about to be asked to enter information that will be incorporated 
into your certificate request. 
What you are about to enter is what is called a Distinguished Name or a DN. 
There are quite a few fields but you can leave some blank 
For some fields there will be a default value, 
If you enter ‘.’, the field will be left blank. 
—– 
Country Name (2 letter code) [AU]:CN ← 国家名称，中国输入CN 
State or Province Name (full name) [Some-State]:BeiJing ← 省名，拼音 
Locality Name (eg, city) []:BeiJing ← 市名，拼音 
Organization Name (eg, company) [Internet Widgits Pty Ltd]:MyCompany Corp. ← 公司英文名 
Organizational Unit Name (eg, section) []: ← 可以不输入 
Common Name (eg, YOUR name) []:www.mycompany.com ← 服务器主机名，若填写不正确，浏览器会报告证书无效，但并不影响使用 
Email Address []:admin@mycompany.com ← 电子邮箱，可随便填

Please enter the following ‘extra’ attributes 
to be sent with your certificate request 
A challenge password []: ← 可以不输入 
An optional company name []: ← 可以不输入

6. 创建自当前日期起有效期为期两年的服务器证书server.crt：

openssl x509 -req -days 730 -sha1 -extensions v3_req -CA root.crt -CAkey root.key -CAserial root.srl -CAcreateserial -in server.csr -out server.crt

输出内容为：

[lenin@archer ~]$ openssl x509 -req -days 730 -sha1 -extensions v3_req -CA root.crt -CAkey root.key -CAcreateserial -in server.csr -out server.crt 
Signature ok 
subject=/C=CN/ST=BeiJing/L=BeiJing/O=MyCompany Corp./CN=www.mycompany.com/emailAddress=admin@mycompany.com 
Getting CA Private Key 
Enter pass phrase for root.key: ← 输入前面创建的密码

7. 创建客户端证书密钥文件client.key：

openssl genrsa -des3 -out client.key 2048

输出内容为：

[lenin@archer ~]$ openssl genrsa -des3 -out client.key 2048 
Generating RSA private key, 2048 bit long modulus 
……………………………………………………………………………..+++ 
……………………………………………………………………………………………………….+++ 
e is 65537 (0×10001) 
Enter pass phrase for client.key: ← 输入一个新密码 
Verifying – Enter pass phrase for client.key: ← 重新输入一遍密码

8. 创建客户端证书的申请文件client.csr：

openssl req -new -key client.key -out client.csr

输出内容为：

[lenin@archer ~]$ openssl req -new -key client.key -out client.csr 
Enter pass phrase for client.key: ← 输入上一步中创建的密码 
You are about to be asked to enter information that will be incorporated 
into your certificate request. 
What you are about to enter is what is called a Distinguished Name or a DN. 
There are quite a few fields but you can leave some blank 
For some fields there will be a default value, 
If you enter ‘.’, the field will be left blank. 
—– 
Country Name (2 letter code) [AU]:CN ← 国家名称，中国输入CN 
State or Province Name (full name) [Some-State]:BeiJing ← 省名称，拼音 
Locality Name (eg, city) []:BeiJing ← 市名称，拼音 
Organization Name (eg, company) [Internet Widgits Pty Ltd]:MyCompany Corp. ← 公司英文名 
Organizational Unit Name (eg, section) []: ← 可以不填 
Common Name (eg, YOUR name) []:Lenin ← 自己的英文名，可以随便填 
Email Address []:admin@mycompany.com ← 电子邮箱，可以随便填

Please enter the following ‘extra’ attributes 
to be sent with your certificate request 
A challenge password []: ← 可以不填 
An optional company name []: ← 可以不填

9. 创建一个自当前日期起有效期为两年的客户端证书client.crt：

openssl x509 -req -days 730 -sha1 -extensions v3_req -CA root.crt -CAkey root.key -CAserial root.srl -CAcreateserial -in client.csr -out client.crt

输出内容为：

[lenin@archer ~]$ openssl x509 -req -days 730 -sha1 -extensions v3_req -CA root.crt -CAkey root.key -CAcreateserial -in client.csr -out client.crt 
Signature ok 
subject=/C=CN/ST=BeiJing/L=BeiJing/O=MyCompany Corp./CN=www.mycompany.com/emailAddress=admin@mycompany.com 
Getting CA Private Key 
Enter pass phrase for root.key: ← 输入上面创建的密码

10. 将客户端证书文件client.crt和客户端证书密钥文件client.key合并成客户端证书安装包client.pfx：

openssl pkcs12 -export -in client.crt -inkey client.key -out client.pfx

输出内容为：

[lenin@archer ~]$ openssl pkcs12 -export -in client.crt -inkey client.key -out client.pfx 
Enter pass phrase for client.key: ← 输入上面创建的密码 
Enter Export Password: ← 输入一个新的密码，用作客户端证书的保护密码，在客户端安装证书时需要输入此密码 
Verifying – Enter Export Password: ← 确认密码

11. 保存生成的文件备用，其中server.crt和server.key是配置单向SSL时需要使用的证书文件，client.crt是配置双向SSL时需要使用的证书文件，client.pfx是配置双向SSL时需要客户端安装的证书文件

     .crt文件和.key可以合到一个文件里面，把2个文件合成了一个.pem文件（直接拷贝过去就行了）

参考：http://sinolog.it/?p=1460



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

http://blog.sina.com.cn/s/blog_4fd50c390101891c.html

x509证书一般会用到三类文，key，csr，crt。

Key是私用密钥openssl格，通常是rsa算法。

Csr是证书请求文件，用于申请证书。在制作csr文件的时，必须使用自己的私钥来签署申，还可以设定一个密钥。

crt是CA认证后的证书文，（windows下面的，其实是crt），签署人用自己的key给你签署的凭证。 

 

1. key的生成 

opensslgenrsa -des3 -out server.key 2048 

这样是生成rsa私钥，des3算法，openssl格式，2048位强度。server.key是密钥文件名。为了生成这样的密钥，需要一个至少四位的密码。可以通过以下方法生成没有密码的key:

opensslrsa -in server.key -out server.key 

 

server.key就是没有密码的版本了。 

 

2. 生成CA的crt

opensslreq -new -x509 -key server.key -out ca.crt -days3650 

生成的ca.crt文件是用来签署下面的server.csr文件。 

 

3. csr的生成方法

opensslreq -new -key server.key -outserver.csr 

需要依次输入国家，地区，组织，email。最重要的是有一个common name，可以写你的名字或者域名。如果为了https申请，这个必须和域名吻合，否则会引发浏览器警报。生成的csr文件交给CA签名后形成服务端自己的证书。 

 

4. crt生成方法

CSR文件必须有CA的签名才可形成证书，可将此文件发送到verisign等地方由它验证，要交一大笔钱，何不自己做CA呢。

opensslx509 -req -days 3650 -in server.csr -CA ca.crt -CAkey server.key-CAcreateserial -out server.crt

输入key的密钥后，完成证书生成。-CA选项指明用于被签名的csr证书，-CAkey选项指明用于签名的密钥，-CAserial指明序列号文件，而-CAcreateserial指明文件不存在时自动生成。

最后生成了私用密钥：server.key和自己认证的SSL证书：server.crt

证书合并：

catserver.key server.crt > server.pem


5. pfx证书分离

我们平时在nginx中配置https类型访问的访问方式，会使用到crt证书，但有些情况是我们只有pfx类型的证书。

下面是将pfx转crt证书的方法：

在linux服务器上运行如下命令：

```
openssl pkcs12 -in xxx.pfx -nodes -out server.pem
openssl rsa -in server.pem -out server.key
openssl x509 -in server.pem -out server.crt
```