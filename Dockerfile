FROM php:5.6

RUN apt update 

RUN apt install apache2 -y

COPY carrental/* /var/www/html/

RUN apt install default-mysql-client default-libmysqlclient-dev

RUN docker-php-ext-install pdo pdo_mysql



