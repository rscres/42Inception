# Dockerfile for WordPress

# Use Alpine 3.19 as the base image
FROM alpine:3.19

# add community packages
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.19/community" >> /etc/apk/repositories
RUN echo "http://php.hernandev.com/v3.11/php-7.4" >> /etc/apk/repositories

# # update and upgrade the system
# RUN apk update && apk upgrade --no-cache

# install the required packages
RUN apk add --no-cache curl php php-mysqli php-fpm php-pdo php-pdo_mysql mariadb-client netcat-openbsd

# copy the wordpress configuration script to the root directory in the container
COPY ./wordpress-conf.sh /

# change the permission of the script to make it executable
RUN  chmod +x wordpress-conf.sh

# define the entrypoint command to run when the container starts
ENTRYPOINT ["/bin/sh", "./wordpress-conf.sh"]