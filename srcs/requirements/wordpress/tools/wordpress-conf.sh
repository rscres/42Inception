#!/bin/bash

sleep 10

wp config create --allow-root --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD"  --dbhost=mariadb --dbprefix="wp_"

wp core install --allow-root --path=/var/www/html --title="$WP_TITLE" --url=$DOMAIN_NAME --admin_user=$WP_ADMIN_N --admin_password=$WP_ADMIN_P --admin_email=$WP_ADMIN_E

wp user create --allow-root --path=/var/www/html "$WP_U_NAME" "$WP_U_EMAIL" --user_pass=$WP_U_PASS  --role=$WP_U_ROLE

wp --allow-root --activate theme install astra

exec php-fpm7.4 -F
