FROM ubuntu:14.04
MAINTAINER Nantha Kumar <kumar.devilers@gmail.com>

# Environment Variables

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update 
RUN apt-get -y install apache2 php5 libapache2-mod-php5 php5-mcrypt
RUN a2enmod php5
RUN a2enmod rewrite 

env APACHE_RUN_USER www-data
env APACHE_RUN_GROUP www-data
env APACHE_PID_FILE /var/run/apache2.pid
env APACHE_RUN_DIR /var/run/apache2
env APACHE_LOCK_DIR /var/lock/apache2
env APACHE_LOG_DIR /var/log/apache2
env LANG C


EXPOSE 80
CMD ["apache2", "-D", "FOREGROUND"]
