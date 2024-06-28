# Use Alpine 3.19 as the base image
FROM alpine:3.19

# Update and upgrade the system
RUN apk update && apk upgrade --update-cache

# Install required packages
RUN apk add --no-cache openrc nginx openssl

# start openrc
RUN openrc
RUN touch /run/openrc/softlevel

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
RUN mkdir -p /var/www/html

# Change the owner of the wordpress directory to nginx
# Alpine uses nginx as the default web server user
RUN adduser -D -g 'www' www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /var/www/html

# Define the command to run when the container starts
CMD ["nginx", "-g", "daemon off;"]