FROM debian:bullseye

# Install dependencies
RUN apt update -y && apt upgrade -y
RUN apt-get install -y mariadb-server

# Copy configuration & script
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY ./tools/script.sh /
RUN chmod 777 script.sh

CMD ["/script.sh"]

