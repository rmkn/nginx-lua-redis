FROM rmkn/nginx-lua
MAINTAINER rmkn

RUN curl -o /usr/local/src/ngx_http_redis.tar.gz -SL http://people.freebsd.org/~osa/ngx_http_redis-0.3.7.tar.gz \
	&& tar zxf /usr/local/src/ngx_http_redis.tar.gz -C /usr/local/src

RUN cd /usr/local/src/nginx-1.10.1 \
        && export LUAJIT_LIB=/usr/local/luajit/lib \
        && export LUAJIT_INC=/usr/local/luajit/include/luajit-2.0 \
	&& ./configure --prefix=/opt/nginx --with-ld-opt="-Wl,-rpath,/usr/local/luajit/lib" --add-module=../ngx_devel_kit-0.3.0 --add-module=../lua-nginx-module-0.10.5 --add-module=../ngx_http_redis-0.3.7 \
	&& make -j2 \
	&& make install

EXPOSE 80

CMD ["/opt/nginx/sbin/nginx", "-g", "daemon off;"]
