FROM alpine:latest

LABEL maintainer="robitett@student.42sp.org.br"

COPY srcs/ /

RUN apk add --no-cache --update --quiet \
    mysql \
    mysql-client

EXPOSE 3306

CMD sh start.sh
