#!/bin/bash

nproc=$(nproc)
export USER=$(whoami)

clear
echo ""
echo " ███████ ████████     ███████ ███████ ██████  ██    ██ ██  ██████ ███████ ███████ "
echo " ██         ██        ██      ██      ██   ██ ██    ██ ██ ██      ██      ██      "
echo " █████      ██        ███████ █████   ██████  ██    ██ ██ ██      █████   ███████ "
echo " ██         ██             ██ ██      ██   ██  ██  ██  ██ ██      ██           ██ "
echo " ██         ██        ███████ ███████ ██   ██   ████   ██  ██████ ███████ ███████ "
echo ""

printf "\n\e[34;1mPlease provide a root password to be able to install Ft_services.\n\e[0m"
printf "\n\e[33;1m"
sudo -s printf "\e[0m\n"
if [ $? -ne 0 ]; then printf "\033[1;31mError\033[0m\n" ; exit; fi

printf "\e[34;1mI. -- Setting up the environment\n\e[0m"

printf "\e[34;1m   1.  -- Changing owner of docker's socket.\e[0m "
sudo chown $USER /var/run/docker.sock 2> error.log &> /dev/null
if [ $? -ne 0 ]; then printf "\033[1;31mError\033[0m\n" ; exit; fi
sudo systemctl stop nginx &> /dev/null
printf "\e[32;1mDone\n\e[0m"

printf "\e[34;1m   2.  -- Setting google chrome as default web browser.\e[0m "
xdg-settings set default-web-browser google-chrome.desktop &> /dev/null
printf "\e[32;1mDone\n\e[0m"

printf "\e[34;1m   3.  -- Deleting all deployments.\e[0m "
kubectl delete deployments --all &> /dev/null
printf "\e[32;1mDone\n\e[0m"

printf "\e[34;1m   4.  -- Deleting all services.\e[0m "
kubectl delete services --all &> /dev/null
printf "\e[32;1mDone\n\e[0m"

printf "\e[34;1m   5.  -- Deleting all pods.\e[0m "
kubectl delete pods --all &> /dev/null
printf "\e[32;1mDone\n\e[0m"

printf "\e[34;1m   6.  -- Deleting all persistent volume claims.\e[0m "
kubectl delete pvc --all &> /dev/null
printf "\e[32;1mDone\n\e[0m"

printf "\e[34;1m   7.  -- Deleting all persistent volume.\e[0m "
kubectl delete pv --all &> /dev/null
printf "\e[32;1mDone\n\e[0m"

printf "\e[34;1m   8.  -- Stopping Minikube.\e[0m "
minikube stop &> /dev/null
printf "\e[32;1mDone\n\e[0m"

printf "\e[34;1m   9.  -- Deleting Minikube.\e[0m "
minikube delete &> /dev/null
rm -rf ~/.kube
rm -rf ~/.minikube
printf "\e[32;1mDone\n\e[0m"

printf "\e[34;1m   10. -- Stopping all containers.\e[0m "
docker stop $(docker ps -a -q) &> /dev/null
printf "\e[32;1mDone\n\e[0m"

printf "\e[34;1m   11. -- Deleting all containers.\e[0m "
docker rm $(docker ps -a -q) &> /dev/null
printf "\e[32;1mDone\n\e[0m"

printf "\e[34;1m   12. -- Deleting all images.\e[0m "
docker rmi $(docker images -a -q) &> /dev/null
printf "\e[32;1mDone\n\e[0m"

printf "\e[34;1m   13. -- Installing the latest version of Minikube.\e[0m "
wget -q https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 &> /dev/null
if [ $? -ne 0 ]; then printf "\033[1;31mError\033[0m\n" ; exit; fi
chmod +x minikube-linux-amd64 &> /dev/null
if [ $? -ne 0 ]; then printf "\033[1;31mError\033[0m\n" ; exit; fi
sudo mv minikube-linux-amd64 /usr/local/bin/minikube &> /dev/null
if [ $? -ne 0 ]; then printf "\033[1;31mError\033[0m\n" ; exit; fi
printf "\e[32;1mDone\n\e[0m"

printf "\n\e[34;1mII. -- Initializing the minikube node.\n\e[0m"

if [ $nproc -lt 2 ]; then
	printf "\e[31;1mMinikube required a minimum of 2 cores to be able to run properly.\n\e[0m" ;
	exit 1
fi

printf "\e[34;1m   1.  -- Starting Minikube.\e[0m "
minikube start --driver=docker &> /dev/null
if [ $? -ne 0 ]; then printf "\033[1;31mError\033[0m\n" ; exit; fi
eval $(minikube docker-env) &> /dev/null
if [ $? -ne 0 ]; then printf "\033[1;31mError\033[0m\n" ; exit; fi
IP="$(minikube ip)" &> /dev/null
if [ $? -ne 0 ]; then printf "\033[1;31mError\033[0m\n" ; exit; fi
printf "\e[32;1mDone\n\e[0m"

printf "\e[34;1m   2.  -- Inserting the minikube's adress inside the config files.\e[0m "
sed -i 's/MINIKUBE_IP/'$IP'/g' srcs/k8s/metallb/config-map.yaml &> /dev/null
if [ $? -ne 0 ]; then printf "\033[1;31mError\033[0m\n" ; exit; fi
sed -i 's/MINIKUBE_IP/'$IP'/g' srcs/mysql/srcs/init_databases.sql &> /dev/null
if [ $? -ne 0 ]; then printf "\033[1;31mError\033[0m\n" ; exit; fi
sed -i 's/MINIKUBE_IP/'$IP'/g' srcs/nginx/srcs/index.html &> /dev/null
if [ $? -ne 0 ]; then printf "\033[1;31mError\033[0m\n" ; exit; fi
sed -i 's/MINIKUBE_IP/'$IP'/g' srcs/ftps/srcs/vsftpd.conf &> /dev/null
if [ $? -ne 0 ]; then printf "\033[1;31mError\033[0m\n" ; exit; fi
printf "\e[32;1mDone\n\e[0m"

printf "\e[34;1m   3.  -- Enabling metrics-server addon.\e[0m "
minikube addons enable metrics-server &> /dev/null
if [ $? -ne 0 ]; then printf "\033[1;31mError\033[0m\n" ; exit; fi
printf "\e[32;1mDone\n\e[0m"

printf "\e[34;1m   4.  -- Enabling dashboard addon.\e[0m "
minikube addons enable dashboard &> /dev/null
if [ $? -ne 0 ]; then printf "\033[1;31mError\033[0m\n" ; exit; fi
printf "\e[32;1mDone\n\e[0m"

printf "\e[34;1m   5.  -- Enabling metallb addon.\e[0m "
minikube addons enable metallb &> /dev/null
if [ $? -ne 0 ]; then printf "\033[1;31mError\033[0m\n" ; exit; fi
printf "\e[32;1mDone\n\e[0m"

printf "\n\e[34;1mIII. -- Building images and deploying pods.\n\e[0m"

function build_and_deploy()
{
	printf "\e[34;1m   $2 -- Building $1.\e[0m "
	docker build --quiet --network=host -t ft_services/$1 ./srcs/$1/ 2>> error.log > /dev/null
	if [ $? -ne 0 ]; then printf "\033[1;31mError: Check error.log\033[0m\n" ; exit; fi
	printf "\e[32;1mDone\n\e[0m"
	printf "\e[34;1m   $3 -- Deploying $1.\e[0m "
	kubectl apply -f srcs/k8s/$1/ 2>> error.log > /dev/null
	if [ $? -ne 0 ]; then printf "\033[1;31mError Check error.log\033[0m\n" ; exit; fi
	printf "\e[32;1mDone\n\e[0m"
}

printf "\e[34;1m   1.  -- Deploying metallb.\e[0m "
kubectl apply -f srcs/k8s/metallb/ 2>> error.log > /dev/null
if [ $? -ne 0 ]; then printf "\033[1;31mError Check error.log\033[0m\n" ; exit; fi
printf "\e[32;1mDone\n\e[0m"

build_and_deploy mysql '2. ' '3. '
build_and_deploy phpmyadmin '4 .' '5. '
build_and_deploy wordpress '6. ' '7. '
build_and_deploy nginx '8. ' '9. '
build_and_deploy ftps '10.' '11.'
build_and_deploy influxdb '12.' '13.'
build_and_deploy grafana '14.' '15.'

sed -i 's/'$IP'/MINIKUBE_IP/g' srcs/k8s/metallb/config-map.yaml &> /dev/null
sed -i 's/'$IP'/MINIKUBE_IP/g' srcs/mysql/srcs/init_databases.sql &> /dev/null
sed -i 's/'$IP'/MINIKUBE_IP/g' srcs/nginx/srcs/index.html &> /dev/null
sed -i 's/'$IP'/MINIKUBE_IP/g' srcs/ftps/srcs/vsftpd.conf &> /dev/null

printf "\n\e[34;1mOpening the Minikube's dashboard.\n\e[0m"
minikube dashboard &> /dev/null &
