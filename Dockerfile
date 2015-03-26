FROM ubuntu:14.04
MAINTAINER Nantha Kumar <kumar.devilers@gmail.com>

# Environment Variables

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update 

# install Apache2

RUN apt-get install -y openssh-server apache2 supervisor
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/run/sshd /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ADD phpinfo.php /var/www/html/

EXPOSE 22 80

CMD ["/usr/bin/supervisord"]


