FROM php:8.3-apache

RUN a2enmod rewrite

RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    git \
    curl \
    nano \
    zip \
    libonig-dev \
    libxml2-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd pdo pdo_mysql zip mbstring \
    && apt-get clean

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php \
    -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

# Copy project into image
COPY . .

# Permissions for Laravel
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 storage bootstrap/cache

COPY apache.conf /etc/apache2/sites-available/000-default.conf

CMD ["apache2-foreground"]
