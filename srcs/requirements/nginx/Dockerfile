# Use Alpine 3.19 as the base image
FROM alpine:3.19

# Update and upgrade the system
RUN apk update && apk upgrade --update-cache

# Install required packages
RUN apk add --no-cache nginx openssl

# Create the ssl directory
RUN mkdir -p /etc/nginx/ssl

# Generate the ssl certificate
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout \
    /etc/nginx/ssl/inception.key -subj "/C=BR/ST=SP/L=KH/O=42/OU=42/CN=rseelaen.42.fr/UID=rseelaen"

# Copy the nginx configuration file
COPY ./nginx.conf /etc/nginx/nginx.conf

# Create the wordpress directory
RUN mkdir -p /var/www/wordpress

# Change the owner of the wordpress directory to nginx
# Alpine uses nginx as the default web server user
RUN chown -R nginx:nginx /var/www/wordpress

# Set permissions for the Nginx user
USER nginx

# Define the command to run when the container starts
CMD ["nginx", "-g", "daemon off;"]