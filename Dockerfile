FROM ubuntu:14.04

MAINTAINER Vaibhav Ranglani <ranglani.vaibhav@gmail.com>

RUN apt-get update && apt-get -y install wget build-essential

RUN wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.38.tar.gz \
	&& tar -zxf pcre-8.38.tar.gz && cd pcre-8.38 && ./configure && make && make install

RUN wget http://zlib.net/zlib-1.2.8.tar.gz && tar -zxf zlib-1.2.8.tar.gz && cd zlib-1.2.8 && ./configure && make && make install
	
RUN wget http://www.openssl.org/source/openssl-1.0.2f.tar.gz && tar -zxf openssl-1.0.2f.tar.gz && cd openssl-1.0.2f \
	&& ./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl && make && make install

RUN wget http://nginx.org/download/nginx-1.11.1.tar.gz && tar zxf nginx-1.11.1.tar.gz && cd nginx-1.11.1 && ./configure \
        --sbin-path=/usr/local/nginx/nginx \
        --conf-path=/usr/local/nginx/nginx.conf \
        --pid-path=/usr/local/nginx/nginx.pid \
        --with-pcre=../pcre-8.38 \
        --with-zlib=../zlib-1.2.8 \
        --with-http_ssl_module \
        --with-stream \
	--with-openssl=../openssl-1.0.2f \
	--with-mail=dynamic && make && make install

