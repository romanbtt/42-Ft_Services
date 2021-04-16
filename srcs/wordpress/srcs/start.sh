#!/bin/bash

/usr/sbin/php-fpm7

mkdir -p /var/www/wordpress/

wp core download --locale=en_US --path=/var/www/wordpress/
wp config create --skip-check --allow-root --path=/var/www/wordpress/ --dbname=wordpress --dbuser=admin --dbpass=password --dbhost=mysql
wp core install --allow-root --path=/var/www/wordpress/ --url=https://192.168.1.250:5050 --title=ft_services --admin_user=admin --admin_password=password --admin_email=admin@ft_services.com

wp user create Elon elon@spacex.com --role=author ;
wp user create Jeff jeff@amazon.com --role=contributor;
wp user create Bill bill@microsoft.com;

nginx -g "daemon off;"