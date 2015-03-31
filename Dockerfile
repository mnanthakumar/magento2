FROM ubuntu:14.04
MAINTAINER Nantha Kumar <kumar.devilers@gmail.com>

# Environment Variables

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update 
RUN apt-get -y install apache2 

env APACHE_RUN_USER www-data
env APACHE_RUN_GROUP www-data
env APACHE_PID_FILE /var/run/apache2.pid
env APACHE_RUN_DIR /var/run/apache2
env APACHE_LOCK_DIR /var/lock/apache2
env APACHE_LOG_DIR /var/log/apache2
env LANG C


EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND
