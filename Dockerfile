# Use official PHP 8.2 with Apache
FROM php:8.2-apache

# Install system dependencies for SQLite, Composer, and PHP extensions
RUN apt-get update && apt-get install -y \
    libsqlite3-dev \
    pkg-config \
    unzip \
    git \
    curl \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libxpm-dev \
    libicu-dev \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions (pdo_sqlite, gd, intl)
RUN docker-php-ext-install pdo pdo_sqlite intl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp --with-xpm \
    && docker-php-ext-install gd

# Enable Apache rewrite and headers modules
RUN a2enmod rewrite headers

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/html

# Copy Grocy source code into container
COPY . /var/www/html/

# Run Composer to install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Point Apache to serve the public/ folder
RUN sed -i 's|DocumentRoot /var/www/html|DocumentRoot /var/www/html/public|g' /etc/apache2/sites-available/000-default.conf

# Add config block for Grocy public folder
RUN printf "\n<Directory /var/www/html/public>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
    DirectoryIndex index.php\n\
</Directory>\n" >> /etc/apache2/sites-available/000-default.conf

# Make sure DirectoryIndex is globally recognized
RUN echo "DirectoryIndex index.php" >> /etc/apache2/apache2.conf

# Expose port 80
EXPOSE 80

# Start Apache in foreground
CMD ["apache2-foreground"]
