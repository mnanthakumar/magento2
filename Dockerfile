FROM ubuntu:14.04
MAINTAINER Nantha Kumar <kumar.devilers@gmail.com>

# Environment Variables

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update 
RUN apt-get -y install supervisor apache2 php5 libapache2-mod-php5 php5-mcrypt mysql-server-5.6 libapache2-mod-auth-mysql php5-mysql 
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
