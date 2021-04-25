FROM alpine:latest

LABEL maintainer="robitett@student.42sp.org.br"

COPY srcs/ /

RUN apk update

RUN apk add --no-cache --quiet \
    php7 \
    php7-fpm \
    php7-opcache \
    php7-gd \
    php7-mysqli \
    php7-zlib \
    php7-curl \
    php7-mbstring \
    php7-json \
    php7-session \
    nginx \
    wget

RUN mkdir -p /run/nginx && \
	mv nginx.conf /etc/nginx/

RUN cd /var/www/ && \
    wget http://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz && \
    mv /wp-config.php ./wordpress/

EXPOSE 5050

CMD sh start.sh