FROM alpine:3.13.4

LABEL maintainer="robitett@student.42sp.org.br"

COPY ./srcs/ /usr/

RUN	apk update && \
	apk add --no-cache nginx openssl

RUN mkdir -p /run/nginx && \
	mv /usr/nginx.conf /etc/nginx/ && \
	mv /usr/index.html /var/www/

RUN mkdir /etc/ssl/ft_services \
    && openssl req -x509 \ 
    -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -subj "/C=CA/ST=QC/L=Montreal/O=42School/OU=Student/CN=ftservices" \
    -keyout /etc/ssl/ft_services/selfsigned.key \
    -out /etc/ssl/ft_services/selfsigned.crt

EXPOSE 80 443 22

CMD ./usr/start.sh