# Set Debian as base image
FROM debian:oldstable

# Update the system
RUN apt update -y &&\
    apt install -y nginx &&\
    apt clean && rm -rf /var/lib/apt/lists/*

# Copy the nginx configuration file
COPY ./nginx.conf /etc/nginx/

WORKDIR /var/www/html

# Create website dir
COPY ./files .

EXPOSE 1029

#RUN sed -i 's/port *= *80;/port = 1029;/g' /etc/nginx/sites-available/default

# Define the command to run when the container starts
CMD ["nginx", "-g", "daemon off;"]