#!/bin/bash

nproc=$(nproc)
export USER=$(whoami)

printf "\e[33;1m0 -- Setting up the environment\n\e[0m"
if [ $nproc -lt 2 ]; then
	printf "\e[31;1mMinikube required a minimum of 2 cores to be able to run properly.\n\e[0m" ;
	exit 1
fi

sudo chown $USER /var/run/docker.sock #> /dev/null 2>&1
sudo systemctl stop nginx

minikube stop #> /dev/null 2>&1
minikube delete #> /dev/null 2>&1
docker stop $(docker ps -a -q) #> /dev/null 2>&1
docker rm $(docker ps -a -q) #> /dev/null 2>&1
docker rmi $(docker images -a -q) #> /dev/null 2>&1

wget -q https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
chmod +x minikube-linux-amd64
sudo mv minikube-linux-amd64 /usr/local/bin/minikube

printf "\e[32;1mDone\n\n\e[0m"

printf "\e[33;1m1 -- Installing Minikube\n\e[0m"
minikube start --driver=docker
eval $(minikube docker-env)
IP="$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)"
sed -i 's/IP/'$IP'/g' srcs/k8s/metallb/config-map.yaml
sed -i 's/IP/'$IP'/g' srcs/wordpress/srcs/start.sh
printf "\e[32;1mDone\n\n\e[0m"

printf "\e[33;1m2 -- Enabling Addons\n\e[0m"
minikube addons enable dashboard
minikube addons enable metrics-server
minikube addons enable metallb
printf "\e[32;1mDone\n\n\e[0m"

printf "\e[33;1m2 -- Building Images\n\e[0m"
docker build --quiet --network=host -t ft_services/nginx srcs/nginx/
docker build --quiet --network=host -t ft_services/mysql srcs/mysql/
docker build --quiet --network=host -t ft_services/wordpress srcs/wordpress/
docker build --quiet --network=host -t ft_services/phpmyadmin srcs/phpmyadmin/
# docker build -t ftps_ft-services srcs/ftps/
# docker build -t influxdb_ft-services srcs/influxdb/
# docker build -t telegraf_ft-services srcs/telegraf/
# docker build -t grafana_ft-services srcs/grafana/
printf "\e[32;1mDone\n\n\e[0m"

kubectl apply -f srcs/k8s/metallb/
kubectl apply -f srcs/k8s/nginx/
kubectl apply -f srcs/k8s/mysql/
kubectl apply -f srcs/k8s/wordpress/
kubectl apply -f srcs/k8s/phpmyadmin/

sed -i 's/'$IP'/IP/g' srcs/k8s/metallb/config-map.yaml
sed -i 's/'$IP'/IP/g' srcs/wordpress/srcs/start.sh

minikube dashboard &
