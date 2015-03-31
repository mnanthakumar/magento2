FROM ubuntu:14.04
MAINTAINER Nantha Kumar <kumar.devilers@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update 
RUN apt-get -y install supervisor apache2 mysql-server-5.6 php5 php5-mcrypt php5-mysql libapache2-mod-php5 php5-intl php5-gd libapache2-mod-auth-mysql curl php5-curl mcrypt phpmyadmin
RUN php5enmod mcrypt

ADD apache2-start.sh /apache2-start.sh
ADD mysql-start.sh /mysql-start.sh
ADD run.sh /run.sh
RUN chmod 755 /*.sh

ADD my.cnf /etc/mysql/conf.d/my.cnf
ADD supervisord-lamp.conf /etc/supervisor/conf.d/supervisord-lamp.conf
RUN rm -rf /var/lib/mysql/*
ENV MYSQL_USER root
ENV MYSQL_PASS magento2
ADD mysql_user.sh /mysql_user.sh
RUN chmod 755 /*.sh

RUN a2enmod php5
RUN a2enmod rewrite

VOLUME ["/etc/mysql", "/var/lib/mysql" ]
VOLUME /var/www

EXPOSE 80 3306
CMD ["/run.sh"]
