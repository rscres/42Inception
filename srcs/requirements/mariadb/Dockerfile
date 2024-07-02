# Set Debian as base image
FROM debian:oldstable

# update the system
RUN apt update -y

# install the required packages
RUN apt install --no-install-recommends --no-install-suggests -y mariadb-server

EXPOSE 3306/tcp

# copy file from host to container
COPY ./mariadb-conf.sh /

# set permissions to the file
RUN chmod +x mariadb-conf.sh

# define entrypoint command to run when the container starts
ENTRYPOINT ["./mariadb-conf.sh"]
