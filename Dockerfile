#
# PHP Dependencies
#
FROM composer:latest as builder

COPY composer.json composer.lock /app/
COPY database/ /app/database/

RUN composer install --ignore-platform-reqs --no-interaction --no-plugins --no-scripts --prefer-dist

#
# Application
#
FROM docker.io/newjett0617/debian-php-apache-composer:7.2

COPY --from=builder --chown=www-data:www-data /app/vendor/ /var/www/html/vendor/
COPY --chown=www-data:www-data . /var/www/html/

EXPOSE 80
CMD [ "apache2-foreground" ]
