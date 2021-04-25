#!/bin/sh

if ! pgrep "nginx" > /dev/null
then
    exit
fi

if ! pgrep "php-fpm7" >/dev/null
then
    exit
fi