FROM php:8.2-apache

RUN apt-get update -y

COPY . /var/www/html/

RUN apt install default-mysql-client default-libmysqlclient-dev -y

RUN docker-php-ext-install pdo pdo_mysql 



