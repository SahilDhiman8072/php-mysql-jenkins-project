FROM php:7.1-apache

RUN apt update -y

COPY carrental/* /var/www/html/

RUN apt install default-mysql-client default-libmysqlclient-dev

RUN docker-php-ext-install pdo pdo_mysql



