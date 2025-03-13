FROM debian:bullseye

RUN apt update && apt upgrade -y
RUN apt install vim -y
RUN apt install curl -y
RUN apt-get -y install wget

RUN apt-get install -y php
RUN apt-get install -y php-fpm
RUN apt-get install -y php-mysql
RUN apt-get install -y mariadb-client


RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz
RUN	chown -R root:root /var/www/wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

EXPOSE 9000
COPY conf/auto_config.sh /var
RUN chown  -R root:root var/auto_config.sh

ENTRYPOINT ["/var/auto_config.sh"]
CMD ["php-fpm7.3", "-F"]