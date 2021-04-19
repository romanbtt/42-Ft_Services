FROM alpine:latest

LABEL maintainer="robitett@student.42sp.org.br"

COPY srcs/ /

RUN apk add --no-cache --update --quiet \
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
    php7-phar \
    openssl \
    wget

RUN wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/nginx && \
	mv nginx.conf /etc/nginx/

#RUN mkdir /etc/ssl/ft_services \
#    && openssl req -x509 \ 
#    -nodes \
#    -days 365 \
#    -newkey rsa:2048 \
#    -subj "/C=CA/ST=QC/L=Montreal/O=42School/OU=Student/CN=ftservices" \
#    -keyout /etc/ssl/ft_services/selfsigned.key \
#    -out /etc/ssl/ft_services/selfsigned.crt

EXPOSE 5050

CMD sh start.sh