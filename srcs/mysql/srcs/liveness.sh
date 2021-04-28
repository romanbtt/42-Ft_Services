#!/bin/sh

sleep 10

while true; do

    ret=$(pgrep -f telegraf)
    if [ "$ret" == "" ]
    then
        exit 1
    fi

    ret=$(pgrep -f mysql)
    if [ "$ret" == "" ]
    then
        exit 1
    fi

    sleep 5
done