FROM alpine:latest

LABEL maintainer="robitett@student.42sp.org.br"

RUN apk update

RUN apk add --no-cache --quiet \
    mysql \
    mysql-client

RUN	mkdir -p /run/mysqld/

COPY srcs/ /

EXPOSE 3306

CMD sh start.sh
