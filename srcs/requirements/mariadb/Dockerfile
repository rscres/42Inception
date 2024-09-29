# Set Debian as base image
FROM debian:oldstable

RUN apt-get update -y &&\
    apt-get install -y mariadb-server net-tools &&\
    apt-get clean && rm -rf /var/lib/apt/lists/*

EXPOSE 3306

# copy file from host to container
COPY ./50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./mariadb-conf.sh /

# set permissions to the file
RUN chmod +x mariadb-conf.sh

# define entrypoint command to run when the container starts
ENTRYPOINT ["./mariadb-conf.sh"]
CMD ["mysqld"]
