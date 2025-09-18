FROM php:8.2-apache

# Enable needed PHP extensions
RUN docker-php-ext-install pdo pdo_sqlite

# Copy Grocy source into container
COPY . /var/www/html/

# Set working directory
WORKDIR /var/www/html/

# Expose port
EXPOSE 80
