FROM alpine:latest

RUN apk update

RUN	apk add --no-cache \
    mysql \
    mysql-client

COPY srcs/ /

RUN mkdir -p /run/mysqld

EXPOSE 3306

CMD ./start.sh
