#!/bin/bash

printf "\e[33;1m0 -- Setting up the environment\n\e[0m"
./srcs/preset.sh

if [ $? -eq 1 ]; then exit 1; fi

minikube stop > /dev/null 2>&1
minikube delete > /dev/null 2>&1
printf "\e[32;1mDone\n\n\e[0m"

printf "\e[33;1m1 -- Installing Minikube\n\e[0m"
minikube start > /dev/null 2>&1
printf "\e[32;1mDone\n\n\e[0m"
