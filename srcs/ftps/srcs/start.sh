#!/bin/sh

/usr/bin/telegraf &

/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf &

./livenessprobe.sh
