#!/bin/bash

sleep infinity

# Check if WordPress is already installed
if [ ! -e /var/www/wordpress/index.php ]
then
    # Download WordPress if not already installed
    wp core download --allow-root --path=/var/www/wordpress

    # Set permissions
    chown -R www-data:www-data /var/www/wordpress/*
    chmod -R 755 /var/www/wordpress/*

    # Generate wp-config.php
    wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=mariadb --allow-root --path=/var/www/wordpress

    # Install WordPress
    wp core install --url=https://cle-tort.42.fr --title="$WEBSITE_NAME" --admin_user="$ADMIN_NAME" --admin_password="$ADMIN_PASSWORD" --admin_email="$ADMIN_EMAIL" --allow-root --path=/var/www/wordpress

    # Create a user
    wp user create "$USER_NAME" "$USER_EMAIL" --user_pass="$USER_PASSWORD" --allow-root --path=/var/www/wordpress
fi

# Execute the command passed as argument to the entrypoint
exec "$@"
