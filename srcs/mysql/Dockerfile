FROM alpine:latest

RUN apk update

RUN	apk add --no-cache \
    mysql \
    mysql-client \
    telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted


COPY srcs/ /

RUN mkdir -p /run/mysqld

RUN mkdir -p /etc/telegraf/ && \
    mv telegraf.conf /etc/telegraf/

EXPOSE 3306

CMD ./start.sh
