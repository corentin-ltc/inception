#!/bin/bash

if [ ! -f /etc/ssl/certs/nginx.crt ]; 

then
echo "Nginx: setting up TLSv1.3 ...";
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/C=FR/ST=Paris/L=Paris/O=wordpress/CN=cle-tort.42.fr";
echo "Nginx: TLSv1.3 is set up!";

fi

exec "$@"
