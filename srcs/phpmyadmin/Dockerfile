FROM alpine:latest

LABEL maintainer="robitett@student.42sp.org.br"

COPY srcs/ /

RUN apk update

RUN apk add --no-cache \
    nginx \
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
    php7-iconv \
    php7-xml \
    wget \
    telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted

RUN wget -q https://phpmyadmin.net/downloads/phpMyAdmin-latest-english.tar.gz && \
    mkdir -p /var/www/phpmyadmin && \
    tar -xzf phpMyAdmin-latest-english.tar.gz -C /var/www/phpmyadmin --strip-components 1 && \
    mv config.inc.php /var/www/phpmyadmin && \
    rm -f phpMyAdmin-latest-english.tar.gz

RUN mkdir -p /run/nginx && \
	mv nginx.conf /etc/nginx/

RUN mkdir -p /etc/telegraf/ && \
    mv telegraf.conf /etc/telegraf/

EXPOSE 5000

CMD sh start.sh