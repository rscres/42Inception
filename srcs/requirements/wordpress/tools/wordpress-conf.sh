#!/bin/bash

# Check if WordPress is already configured
if [ ! -f /var/www/html/wp-config.php ]; then
  # Wait for the database to be ready
  until mysql -h mariadb -u"$DB_USER" -p"$DB_PASSWORD" -e 'SELECT 1' &> /dev/null; do
    echo "Waiting for database connection..."
    sleep 5
  done

  # Create the wp-config.php file
  wp config create --allow-root --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost=mariadb --dbprefix="wp_"

  # Install WordPress
  wp core install --allow-root --path=/var/www/html --title="$WP_TITLE" --url=$DOMAIN_NAME --admin_user=$WP_ADMIN_N --admin_password=$WP_ADMIN_P --admin_email=$WP_ADMIN_E

  # Create a new user
  wp user create --allow-root --path=/var/www/html "$WP_U_NAME" "$WP_U_EMAIL" --user_pass=$WP_U_PASS --role=$WP_U_ROLE

  # Activate the theme
  wp --allow-root theme install astra --activate
fi

# Start PHP-FPM in the foreground
exec "$@"
