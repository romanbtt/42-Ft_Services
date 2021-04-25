#!/bin/sh

mysql_install_db --user=root --datadir=/var/lib/mysql --skip-test-db
mysqld --user=root --skip_networking=0 --init-file=/init_databases.sql