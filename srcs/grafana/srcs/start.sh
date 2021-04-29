#!/bin/sh

/usr/bin/telegraf &

grafana-server --homepath=/usr/share/grafana &

./livenessprobe.sh
