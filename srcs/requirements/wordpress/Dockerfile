FROM debian:oldstable

RUN apt-get update &&\
    apt-get -y install wget curl bash php php-cgi php-mysql php-fpm\
    php-pdo php-gd php-cli php-mbstring redis php-redis &&\
    rm -rf /var/lib/apt/lists/*

# install wordpress cli
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar &&\
    chmod +x wp-cli.phar &&\
    mv wp-cli.phar /usr/local/bin/wp

# Copy the .conf in the html directory
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

# Create the folder to enable php start
RUN mkdir /run/php

#we copy the script, give the right to launch it in local on our computer
COPY ./tools/wordpress-conf.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress-conf.sh
ENTRYPOINT ["/usr/local/bin/wordpress-conf.sh"]

#We go the html directory
WORKDIR /var/www/html/

#We expose the 9000 port
EXPOSE 9000

#Launch PHP FPM in foreground and ignore deamonize from conf file (-F)
CMD ["/usr/sbin/php-fpm7.4", "-F"]
