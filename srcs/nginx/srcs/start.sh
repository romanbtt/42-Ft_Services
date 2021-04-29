#!/bin/sh

/usr/bin/telegraf &

/usr/sbin/nginx -g "daemon off;" &

./livenessprobe.sh