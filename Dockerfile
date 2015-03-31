FROM ubuntu:14.04
MAINTAINER Nantha Kumar <kumar.devilers@gmail.com>

# Environment Variables

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
apt-get -y install apache2 mysql-server-5.6 libapache2-mod-auth-mysql php5-mysql php5 libapache2-mod-php5 php5-mcrypt openssh-server curl php5-curl php5-intl php5-gd php5-mysql mcrypt php5-mcrypt supervisor git && \

# Enable apache mods.
RUN a2enmod php5
RUN a2enmod rewrite

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 80

# Update the default apache site with the config we created.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf

# By default, simply start apache.
CMD bash -c '(mysqld &); /usr/sbin/apache2ctl -D FOREGROUND'

#CMD [ "mysqladmin -u root password magento2"]

EXPOSE 3306
