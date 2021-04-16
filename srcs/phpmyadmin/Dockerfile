FROM alpine:latest

LABEL maintainer="robitett@student.42sp.org.br"

COPY srcs/ /

RUN apk add --no-cache --update \
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
    php7-session
    wget

RUN wget https://phpmyadmin.net/downloads/phpMyAdmin-latest-english.tar.gz && \
    mkdir -p /var/www/phpmyadmin && \
    tar -xzf phpMyAdmin-latest-english.tar.gz -C /var/www/phpmyadmin --strip-components 1 && \
    mv config.inc.php /var/www/phpmyadmin && \
    rm -f phpMyAdmin-latest-english.tar.gz

RUN mkdir -p /run/nginx && \
	mv nginx.conf /etc/nginx/

RUN mkdir /etc/ssl/ft_services \
    && openssl req -x509 \ 
    -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -subj "/C=CA/ST=QC/L=Montreal/O=42School/OU=Student/CN=ftservices" \
    -keyout /etc/ssl/ft_services/selfsigned.key \
    -out /etc/ssl/ft_services/selfsigned.crt

EXPOSE 5000

CMD sh start.sh