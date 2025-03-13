FROM debian:bullseye

RUN apt update && apt upgrade -y
RUN apt install vim -y
RUN apt install curl -y
RUN apt-get -y install wget

RUN apt-get install -y php
RUN apt-get install -y php-fpm
RUN apt-get install -y php-mysql
RUN apt-get install -y mariadb-client


#FPM
COPY www.conf /etc/php/7.3/fpm/pool.d
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