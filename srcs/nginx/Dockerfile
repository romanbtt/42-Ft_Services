FROM alpine:latest

LABEL maintainer="robitett@student.42sp.org.br"

COPY srcs/ /

RUN apk add --no-cache --update --quiet \
    nginx \
    openssl

RUN mkdir -p /run/nginx && \
	mv nginx.conf /etc/nginx/ && \
	mv index.html /var/www/

RUN mkdir /etc/ssl/ft_services \
    && openssl req -x509 \ 
    -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -subj "/C=CA/ST=QC/L=Montreal/O=42School/OU=Student/CN=MINIKUBE_IP" \
    -keyout /etc/ssl/ft_services/selfsigned.key \
    -out /etc/ssl/ft_services/selfsigned.crt

EXPOSE 80 443

CMD ./start.sh