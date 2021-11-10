# IPv6 DNS

自己常用的DNS：

#Google Public DNS

google-public-dns-a.google.com  2001:4860:4860::8888   8.8.8.8   

google-public-dns-b.google.com  2001:4860:4860::8844   8.8.4.4

otherOpenDNS

resolver1.opendns.com  2620:0:ccc::2   208.67.222.222

resolver2.opendns.com  2620:0:ccd::2   208.67.220.220


网上找到的：

```
北京邮电大学DNS服务器  2001:da8:202:10::36                                             

                                        2001:da8:202:10::37  

上海交通大学DNS服务器 2001:da8:8000:1:202:120:2:100                                        

                                       2001:da8:8000:1:202:120:2:101      

北京科技大学DNS服务器  2001:da8:208:10::6

科技网DNS服务器  2001:cc0:2fff:2::6

CNNIC DNS服务器 2001:dc7:1000::1

"Google Over IPv6"计划DNS:

Hurricane Electric DNS 

ordns.he.net  2001:470:20::2     74.82.42.42

tserv1.fmt2.he.net  2001:470:0:45::2   72.52.104.74   

 

tserv1.dal1.he.net  2001:470:0:78::2   216.218.224.42  

tserv1.ams1.he.net  2001:470:0:7d::2   216.66.84.46

tserv1.mia1.he.net  2001:470:0:8c::2   209.51.161.58  

tserv1.tor1.he.net  2001:470:0:c0::2   216.66.38.58  

ns.ipv6.uni-leipzig.de  2001:638:902:1::10   139.18.25.34

#Google Public DNS

google-public-dns-a.google.com  2001:4860:4860::8888   8.8.8.8   

google-public-dns-b.google.com  2001:4860:4860::8844   8.8.4.4  

otherOpenDNS

resolver1.opendns.com  2620:0:ccc::2   208.67.222.222

resolver2.opendns.com  2620:0:ccd::2   208.67.220.220

 

margis.litnet.lt  2001:778::76   193.219.61.76

dns64.litnet.lt  2001:778::37   193.219.61.37 

中国首个公共ipv6dns

240c::6666

240c：：6644

 

NAT64与DNS64地址
2001:8b0:6464::1 and 2001:8b0:6464::2. We no longer provide an IPv4
resolver due to abuse.
nat64.litnet.lt (2001:778::75) - serveris atliekantis NAT64
transliavimą krioklys.litnet.lt (2001:778::37) - DNS serveris
atliekantis DNS64 funkciją 2001:778:0:ffff:64::/96 - IPv6 NAT64
prefiksas
193.219.61.0/24 - IPv4 NAT64 prefiksas
NAT64 implementation is running on a A10 vThunder virtual appliance.
NAT64 routed prefix: 2001:67c:27e4:642::/64
Quick ping6 test if up&running: ping6 2001:67c:27e4:642::5bef:6015 512ms 360
NAT64 implementation is running in PAN500 firewall box.
NAT64 routed prefix: 2001:67c:27e4:64::/64
Quick ping6 test if up&running: ping6 2001:67c:27e4:64::5bef:6015 508ms 340
Jool NAT64 implementation is running in a virtual container on proxmox server.
NAT64 routed prefix: 2001:67c:27e4:1064::/64
Quick ping6 test if up&running: ping6 2001:67c:27e4:1064::5bef:6015 508ms  340
NAT64 implementation is running in Cisco ASR1001.
NAT64 routed prefix: 2001:67c:27e4:11::/64
Quick ping6 test if up&running: ping6 2001:67c:27e4:11::5bef:6015

 

2001:df8:0:7::1

To use the NAT64 gateway simply set your DNS resolvers to

```