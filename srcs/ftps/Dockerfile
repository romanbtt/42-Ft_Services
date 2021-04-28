FROM alpine:latest

RUN apk update

RUN	apk add --no-cache \
    vsftpd \
    openssl \
    telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted

COPY srcs/ /

RUN mv vsftpd.conf /etc/vsftpd

RUN mkdir -p /var/ftp

RUN mkdir -p /etc/telegraf/ && \
    mv telegraf.conf /etc/telegraf/

RUN adduser -D -h /var/ftp robitett && \
    echo "robitett:c6zAcLjBW2" | chpasswd && \
    echo "robitett" >> /etc/vsftpd/vsftpd.userlist

RUN mkdir /etc/ssl/ft_services \
    && openssl req -x509 \ 
    -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -subj "/C=CA/ST=QC/L=Montreal/O=42School/OU=Student/CN=MINIKUBE_IP" \
    -keyout /etc/ssl/ft_services/vsftpd.key \
    -out /etc/ssl/ft_services/vsftpd.crt

EXPOSE 21 30020 30021

CMD ./start.sh