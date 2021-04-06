#!/bin/bash

nproc=$(nproc)
export USER=$(whoami)

sudo chown $USER /var/run/docker.sock > /dev/null 2>&1

sudo pkill nginx > /dev/null 2>&1

if [ $nproc -lt 2 ]; then
	printf "\e[31;1mMinikube required a minimum of 2 cores to be able to run properly.\n\e[0m"
	exit 1
fi
