FROM alpine:latest

RUN apk update

RUN	apk add --no-cache \
    libc6-compat \
    telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
    grafana --repository http://dl-3.alpinelinux.org/alpine/edge/testing/

COPY srcs/ /

RUN mkdir -p /etc/telegraf/ && \
    mv telegraf.conf /etc/telegraf/

RUN mv grafana-datasource.yaml /usr/share/grafana/conf/provisioning/datasources/ ; \
    mv grafana-dashboard.yaml /usr/share/grafana/conf/provisioning/dashboards/ ; \
    mv *.json /usr/share/grafana/conf/provisioning/dashboards/ ; \
    mv defaults.ini /usr/share/grafana/conf/

EXPOSE 3000

CMD ./start.sh