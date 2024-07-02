# Set Debian as base image
FROM debian:oldstable

# Update the system
RUN apt update -y &&\
    apt install -y --no-install-recommends --no-install-suggests nginx openssl &&\
    apt clean && rm -rf /var/lib/apt/lists/*

# Create the ssl directory and Generate the ssl certificate
RUN mkdir -p /etc/nginx/ssl &&\
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=BR/ST=SP/L=SaoPaulo/O=42/OU=42SP/CN=rseelaen.42.fr"

# Copy the nginx configuration file
COPY ./nginx.conf /etc/nginx/

# Create the wordpress directory and change the owner of the wordpress directory to www-data
RUN mkdir -p /var/www/wordpress &&\
    chown -R www-data:www-data /var/www/wordpress

EXPOSE 80/tcp

# Define the command to run when the container starts
CMD ["nginx", "-g", "daemon off;"]