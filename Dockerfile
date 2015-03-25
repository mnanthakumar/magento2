FROM ubuntu:14.04
MAINTAINER Nantha Kumar <kumar.devilers@gmail.com>


RUN apt-get update 

# install Apache2

RUN apt-get install -y apache2

# install Mysql

RUN apt-get install -y mysql-server-5.6 libapache2-mod-auth-mysql php5-mysql

# install Php

RUN apt-get install -y php5 libapache2-mod-php5 php5-mcrypt

# install Extensions

RUN apt-get install -y curl php5-curl php5-intl php5-gd php5-mysql mcrypt php5-mcrypt

ADD phpinfo.php /var/www/html/

EXPOSE 80 3306
