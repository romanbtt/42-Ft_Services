FROM alpine:latest

RUN apk update

RUN	apk add --no-cache \
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
    wget \
    telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted

COPY srcs/ /

RUN mkdir -p /run/nginx && \
	mv nginx.conf /etc/nginx/

RUN mkdir -p /etc/telegraf/ && \
    mv telegraf.conf /etc/telegraf/

RUN wget -q http://wordpress.org/latest.tar.gz && \
    mkdir -p /var/www/wordpress && \
    tar -xzf latest.tar.gz -C /var/www/wordpress --strip-components 1 && \
    mv wp-config.php /var/www/wordpress && \
    rm -f latest.tar.gz

EXPOSE 5050

CMD ./start.sh
