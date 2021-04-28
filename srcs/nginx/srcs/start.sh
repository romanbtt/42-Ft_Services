#!/bin/sh

/usr/bin/telegraf &

/usr/sbin/nginx -g "daemon off;" &

./liveness.sh