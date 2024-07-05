# Set Debian as base image
FROM debian:oldstable

# update the system and install packages
RUN apt update -y &&\
    apt install -y curl php php7.4-fpm php-mysql mariadb-client netcat ca-certificates &&\
    apt clean && rm -rf /var/lib/apt/lists/*

# Install WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar &&\
    chmod +x wp-cli.phar &&\
    mv wp-cli.phar /usr/local/bin/wp

EXPOSE 443 80

# copy the wordpress configuration script to the root directory in the container
COPY ./wordpress-conf.sh /

# change the permission of the script to make it executable
RUN  chmod +x wordpress-conf.sh

# define the entrypoint command to run when the container starts
ENTRYPOINT ["./wordpress-conf.sh"]