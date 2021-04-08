FROM alpine:3.13.4

LABEL maintainer="robitett@student.42sp.org.br"

COPY ./srcs/ /usr/

RUN apk add --no-cache --update \
    nginx \
    php7-common \
    php7-session \
    php7-iconv \
    php7-json \
    php7-gd \
    php7-curl \
    php7-xml \
    php7-mysqli \
    php7-imap \
    php7-cgi \
    php7-pdo \
    php7-pdo_mysql \
    php7-soap \
    php7-xmlrpc \
    php7-posix \
    php7-mcrypt \
    php7-gettext \
    php7-ldap \
    php7-ctype \
    php7-dom \
    wget \
    curl

RUN wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz -C ./wordpress/ --strip-components 1 && \
    rm -f latest.tar.gz

RUN curl -s https://api.wordpress.org/secret-key/1.1/salt/ > wp_key && \
    sed -ie '/\/\* WP_KEYS \*\//r wp_key' ./usr/wp-config.php && \
    mv /usr/wp-config.php ./ && \
    rm -f wp_key

EXPOSE 5050

CMD ./usr/start.sh