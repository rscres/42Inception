#!/bin/bash

#--------------mariadb start--------------#

# Create MariaDB data directory if it doesn't exist
mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql && chmod -R 755 /var/lib/mysql
mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld && chmod -R 755 /run/mysqld

# Initialize MariaDB data directory if it doesn't exist
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql --port=3306 --bind-address=0.0.0.0
fi

# Start MariaDB in the background
echo "Starting MariaDB..."
# /usr/bin/mysqld_safe --nowatch &
exec "$@" &

# Wait for MariaDB to start
sleep 10

# Check if the redo log format error exists
if grep -q 'Unsupported redo log format' /var/log/mysql/error.log; then
    echo "Unsupported redo log format detected. Attempting to backup existing data directory..."
    # Ensure MariaDB is stopped before backup
    mariadb-admin shutdown
    sleep 5
    # Backup existing data directory
    mkdir -p /var/lib/mysql_backup && mv /var/lib/mysql/* /var/lib/mysql_backup/
    echo "Backup completed. Reinitializing MariaDB data directory..."
    # Reinitialize MariaDB data directory
    mysql_install_db --user=mysql --ldata=/var/lib/mysql --port=3306 --bind-address=0.0.0.0
fi

# Check if MariaDB is running
# if ! pgrep -x "mariadbd" > /dev/null; then
#     echo "MariaDB failed to start. Checking logs for errors."
#     # Tail the last few lines of the MariaDB log file for quick diagnostics
#     tail /var/log/mysql/error.log
# else
#     echo "MariaDB is running."
# fi

netstat -tuln | grep 3306

#--------------mariadb config--------------#
# Create database if not exists
mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DB}\`;"

# Create user if not exists
mariadb -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

# Grant privileges to user
mariadb -e "GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO \`${MYSQL_USER}\`@'%';"

# Flush privileges to apply changes
mariadb -e "FLUSH PRIVILEGES;"

#--------------mariadb restart--------------#
# Shutdown mariadb to restart with new config
service mariadb status
mariadb-admin shutdown

sleep 10

# Restart mariadb with new config in the background to keep the container running
exec mysqld_safe --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'