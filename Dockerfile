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
FROM newjett0617/alpine-php-fpm-composer:0.0.1

COPY --from=builder --chown=www-data:www-data /app/vendor/ /var/www/html/vendor/
COPY --chown=www-data:www-data . /var/www/html/

USER www-data

EXPOSE 9000
CMD [ "php-fpm" ]