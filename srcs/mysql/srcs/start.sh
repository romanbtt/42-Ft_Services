#/!bin/sh

sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf
sed -i 's/#bind-address=0.0.0.0/bind-address=0.0.0.0/g' /etc/my.cnf.d/mariadb-server.cnf

/usr/bin/mysql_install_db --user=mysql --datadir="/var/lib/mysql" > /dev/null 2>&1
/usr/bin/mysqld_safe --datadir="/var/lib/mysql" --no-watch > /dev/null 2>&1

until mysql -e "show databases;" > /dev/null 2>&1
do
	echo "Waiting for Mysql's daemon to starting up.."
    sleep 1
done
echo "Mysql's daemon running!"

mysql -e "CREATE DATABASE wordpress;"
mysql -e "CREATE DATABASE phpmyadmin;"
mysql -e "CREATE USER 'admin'@'%' IDENTIFIED BY 'admin';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%';"
mysql -e "FLUSH PRIVILEGES;"
mysql < create_tables.sql
mysql wordpress < wordpress.sql

rm -f create_tables.sql wordpress.sql
