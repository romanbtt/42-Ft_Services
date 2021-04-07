FROM alpine:3.13.4

LABEL maintainer="robitett@student.42sp.org.br"

RUN apk update ;
	apk add nginx ;
	apk add openssl ;
	apk cache clean

EXPOSE 80 443 22