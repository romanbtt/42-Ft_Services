#!/bin/sh

if ! pgrep "mysql" > /dev/null
then
    exit
fi