#!/bin/bash

sleep 10

# Installation de WP CLI, l'invite de commande de wordpress
if ! command -v wp &> /dev/null; then
    echo "WP-CLI n'est pas installé, installation en cours..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi


cd /var/www/html

# Configuration de WordPress (connexion à la base de données)

wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --path=/var/www/html --allow-root

# Création de l'utilisateur WordPress

wp user create $WORDPRESS_USER $WORDPRESS_EMAIL --user_pass=$WORDPRESS_USER_PASS --role=editor --path=/var/www/html --allow-root

# Installation et activation du thème
THEME_NAME="twentytwentyone" 
echo "Installation du thème $THEME_NAME..."
wp theme install $THEME_NAME --activate --path=/var/www/html --allow-root

echo "Installation et configuration terminées."
wp option get siteurl --path=/var/www/html --allow-root
wp user list --path=/var/www/html --allow-root

php-fpm7.4 -F

