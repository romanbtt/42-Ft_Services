#!/bin/bash

nproc=$(nproc)
export USER=$(whoami)

printf "\e[33;1m0 -- Setting up the environment\n\e[0m"
if [ $nproc -lt 2 ]; then
	printf "\e[31;1mMinikube required a minimum of 2 cores to be able to run properly.\n\e[0m" ;
	exit 1
fi
sudo chown $USER /var/run/docker.sock > /dev/null 2>&1
minikube stop > /dev/null 2>&1
minikube delete > /dev/null 2>&1
printf "\e[32;1mDone\n\n\e[0m"

printf "\e[33;1m1 -- Installing Minikube\n\e[0m"
minikube start --driver=docker > /dev/null 2>&1
eval $(minikube docker-env)
printf "\e[32;1mDone\n\n\e[0m"

printf "\e[33;1m2 -- Installing Loadbalancer Metallb\n\e[0m"
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
kubectl apply -f ./srcs/metallb.yaml
printf "\e[32;1mDone\n\n\e[0m"

minikube dashboard &