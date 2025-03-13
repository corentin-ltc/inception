#!/bin/bash

if [ ! -e /var/www/html/index.php ]
then	
	wp core download --allow-root


	#CREATE SITE + USERS
	wp core install --url=https://cle-tort.42.fr --title=$WEBSITE_NAME --admin_user=$ADMIN_NAME --admin_password=$ADMIN_PASSWORD --admin_email=$ADMIN_EMAIL --allow-root

	wp user create $USER_NAME $USER_EMAIL --user_pass=$USER_PASSWORD --allow-root
fi

exec "$@"