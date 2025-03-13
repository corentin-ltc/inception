FROM debian:bullseye

RUN apt update && apt upgrade -y
RUN apt install vim -y
RUN apt install curl -y
RUN apt-get -y install wget

RUN apt-get install -y php
RUN apt-get install -y php-fpm
RUN apt-get install -y php-mysql
RUN apt-get install -y mariadb-client


EXPOSE 9000
COPY conf/auto_config.sh /var
RUN chmod 777 var/auto_config.sh

ENTRYPOINT ["/var/auto_config.sh"]
#CMD ["php-fpm7.3", "-F"]