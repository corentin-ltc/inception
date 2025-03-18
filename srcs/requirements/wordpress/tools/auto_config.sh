#!/bin/bash

sleep 10

# Vérification si WP-CLI est installé, sinon l'installer
if ! command -v wp &> /dev/null; then
    echo "WP-CLI n'est pas installé, installation en cours..."
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
fi

# Aller dans le répertoire où WordPress est installé
cd /var/www/html

# Configuration de WordPress (connexion à la base de données)
echo "Configuration de WordPress avec la base de données..."

wp config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$MYSQL_HOSTNAME --path=/var/www/html --allow-root

# Installation de WordPress (si ce n'est pas déjà fait)
if ! wp core is-installed --path=/var/www/html --allow-root; then
    echo "Installation de WordPress..."
    wp core install --url=http://$DOMAIN_NAME --title="$WORDPRESS_TITLE" --admin_user=$WORDPRESS_ADMIN --admin_password=$WORDPRESS_ADMIN_PASS --admin_email=$WORDPRESS_ADMIN_EMAIL --path=/var/www/html --allow-root
else
    echo "WordPress est déjà installé."
fi

# Création de l'utilisateur WordPress
echo "Création de l'utilisateur WordPress..."
wp user create $WORDPRESS_USER $WORDPRESS_EMAIL --user_pass=$WORDPRESS_USER_PASS --role=editor --path=/var/www/html --allow-root

# Installation et activation du thème
THEME_NAME="twentytwentyone"  # Remplace avec le nom du thème que tu veux installer
echo "Installation du thème $THEME_NAME..."
wp theme install $THEME_NAME --activate --path=/var/www/html --allow-root

# Vérification de l'installation
echo "Installation et configuration terminées."
wp option get siteurl --path=/var/www/html --allow-root
wp user list --path=/var/www/html --allow-root

echo "Tu peux accéder à ton site à l'adresse http://$DOMAIN_NAME"

php-fpm7.4 -F

