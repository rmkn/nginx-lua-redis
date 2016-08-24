FROM rmkn/nginx-lua
MAINTAINER rmkn

ENV REDISMOD_VERSION 0.3.7

RUN curl -o /usr/local/src/ngx_http_redis.tar.gz -SL http://people.freebsd.org/~osa/ngx_http_redis-${REDISMOD_VERSION}.tar.gz \
	&& tar zxf /usr/local/src/ngx_http_redis.tar.gz -C /usr/local/src

RUN cd /usr/local/src/nginx-${NGINX_VERSION} \
	&& ./configure --prefix=/opt/nginx --with-ld-opt="-Wl,-rpath,/usr/local/luajit/lib" --add-module=../ngx_devel_kit-${NDK_VERSION} --add-module=../lua-nginx-module-${LUAMOD_VERSION} --add-module=../ngx_http_redis-${REDISMOD_VERSION} \
	&& make -j2 \
	&& make install

