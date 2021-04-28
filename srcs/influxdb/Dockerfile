FROM alpine:latest

RUN apk update

RUN	apk add --no-cache \
    influxdb \
    telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted

COPY srcs/ /

RUN mkdir -p /etc/telegraf/ && \
    mv telegraf.conf /etc/telegraf/

EXPOSE	8086

CMD ./start.sh