# nginx  

## 安装  
wget http://nginx.org/download/nginx-1.10.3.tar.gz  
tar xzf nginx-1.10.3.tar.gz  
cd nginx-1.10.3  
useradd www ; ./configure --user=www --group=www --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module  
make  
make install  
