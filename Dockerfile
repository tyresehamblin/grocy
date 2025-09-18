# Use official PHP 8.2 with Apache
FROM php:8.2-apache

# Install PHP extensions required by Grocy
RUN docker-php-ext-install pdo pdo_sqlite

# Enable Apache rewrite module (needed for clean URLs)
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy Grocy source code into container
COPY . /var/www/html/

# Adjust Apache config to allow .htaccess overrides
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf

# Expose port 80
EXPOSE 80

# Start Apache in foreground
CMD ["apache2-foreground"]
