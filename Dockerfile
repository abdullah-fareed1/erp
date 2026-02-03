FROM php:8.3-apache

# Enable Apache mod_rewrite (Laravel needs this)
RUN a2enmod rewrite

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    git \
    curl \
    nano \
    zip \
    libonig-dev \
    libxml2-dev

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql zip mbstring

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/html

# Copy Apache config
COPY apache.conf /etc/apache2/sites-available/000-default.conf

# Start Apache
CMD ["apache2-foreground"]
