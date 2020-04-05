FROM composer:1 AS composer

LABEL maintainer="i@symo.me"
LABEL description="Using PHP 5.6 to run composer for legacy project."

WORKDIR /app
RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ -vvv
RUN composer global require hirak/prestissimo -vvv

FROM php:5.6-cli-alpine AS php
WORKDIR /app
COPY --from=composer /usr/bin/composer /usr/bin/composer
COPY --from=composer /tmp/* /root/.composer/
COPY docker-entrypoint.sh /docker-entrypoint.sh

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /root/.composer

ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]

CMD ["composer"]
