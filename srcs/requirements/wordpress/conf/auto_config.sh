#!/bin/bash
if [ ! -e /var/www/wordpress/index.php ]
then
    wp core download --allow-root --path=/var/www/wordpress

    chown -R www-data:www-data /var/www/wordpress/*
    chmod -R 755 /var/www/wordpress/*

    # Generate wp-config.php
    wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=mariadb --allow-root --path=/var/www/wordpress

    # Create site and users
    wp core install --url=https://cle-tort.42.fr --title="$WEBSITE_NAME" --admin_user="$ADMIN_NAME" --admin_password="$ADMIN_PASSWORD" --admin_email="$ADMIN_EMAIL" --allow-root --path=/var/www/wordpress

    wp user create "$USER_NAME" "$USER_EMAIL" --user_pass="$USER_PASSWORD" --allow-root --path=/var/www/wordpress"
fi
