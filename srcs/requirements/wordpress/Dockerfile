FROM debian:bullseye

RUN apt update && apt upgrade -y

RUN apt-get update
RUN apt install curl wget systemd ssh -y
RUN apt install php7.3 php7.3-fpm php7.3-mysql php7.3-common php7.3-cli -y

#FPM
COPY conf/www.conf /etc/php/7.3/fpm/pool.d
RUN service php7.3-fpm start
RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=1/g' /etc/php/7.3/fpm/php.ini

#WP-CLI
WORKDIR /var/www/html
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000
COPY conf/auto_config.sh /var
RUN chmod 777 var/auto_config.sh

ENTRYPOINT ["/var/auto_config.sh"]
CMD ["php-fpm7.3", "-F"]