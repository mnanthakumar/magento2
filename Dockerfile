FROM ubuntu:14.04
MAINTAINER Nantha Kumar <kumar.devilers@gmail.com>

# Environment Variables

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
apt-get -y install apache2 && \

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

ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf
CMD /usr/sbin/apache2ctl -D FOREGROUND
