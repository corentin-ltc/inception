#!/bin/bash

#docker run --env-file ~/inception/srcs/.env -it mariadb

/etc/init.d/mariadb start

sleep 5

echo $SQL_ROOT_PASSWORD
echo $SQL_DATABASE
echo $SQL_USER
echo $SQL_PASSWORD


mysql -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
mysql -e "FLUSH PRIVILEGES;"
mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql
/etc/init.d/mariadb stop
exec mysqld_safe