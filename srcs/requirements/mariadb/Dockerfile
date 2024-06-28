# Dockerfile for MariaDB

# Use Alpine 3.19 as the base image
FROM alpine:3.19

# update and upgrade the system
RUN apk update && apk upgrade --no-cache

# install the required packages
RUN apk add --no-cache openrc mariadb mariadb-client mariadb-common

# start openrc
RUN openrc
RUN touch /run/openrc/softlevel

# copy file from host to container
COPY ./mariadb-conf.sh /

# set permissions to the file
RUN chmod +x mariadb-conf.sh

# define entrypoint command to run when the container starts
ENTRYPOINT ["./mariadb-conf.sh"]
