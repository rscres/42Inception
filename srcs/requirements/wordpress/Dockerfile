# Dockerfile for WordPress

# Use Alpine 3.19 as the base image
FROM alpine:3.19

RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.19/main" > /etc/apk/repositories; \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.19/community" >> /etc/apk/repositories

# update and upgrade the system
RUN apk update

# install the required packages
RUN apk add openrc curl php php-fpm php-phar php-mysqli php-pdo php-pdo_mysql php-iconv php-cgi fcgi

# Install WordPress
RUN wget https://wordpress.org/latest.tar.gz &&\
    tar -xvf latest.tar.gz &&\
    mkdir -p /var/www/wordpress &&\
    mv wordpress/* /var/www/wordpress

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar &&\
    chmod +x wp-cli.phar &&\
    mv wp-cli.phar /usr/local/bin/wp

# start openrc
RUN openrc
RUN touch /run/openrc/softlevel

# copy the wordpress configuration script to the root directory in the container
COPY ./wordpress-conf.sh /
# COPY ./www.conf /etc/php8/php-fpm.d/

# change the permission of the script to make it executable
RUN  chmod +x wordpress-conf.sh

# define the entrypoint command to run when the container starts
ENTRYPOINT ["./wordpress-conf.sh"]