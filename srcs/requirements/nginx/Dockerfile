# Set Debian as base image
FROM debian:oldstable

# Update the system
RUN apt update -y

# Install required packages
RUN apt install -y --no-install-recommends --no-install-suggests nginx openssl

# Create the ssl directory
RUN mkdir -p /etc/nginx/ssl

# Generate the ssl certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=BR/ST=SP/L=SaoPaulo/O=42/OU=42SP/CN=rseelaen.42.fr"

# Copy the nginx configuration file
COPY ./nginx.conf /etc/nginx/

# Create the wordpress directory
RUN mkdir -p /var/www/wordpress

# change the owner of the wordpress directory to www-data
RUN chown -R www-data:www-data /var/www/wordpress

EXPOSE 80/tcp

# Define the command to run when the container starts
CMD ["nginx", "-g", "daemon off;"]