#!/bin/sh

if ! pgrep "nginx" > /dev/null
then
    exit
fi