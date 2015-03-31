FROM ubuntu:14.04
MAINTAINER Nantha Kumar <kumar.devilers@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

# SUPERVISOR

RUN apt-get -y install supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# SSH

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:magento2' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Apache2 

RUN apt-get -y install apache2 
RUN mkdir -p /var/lock/apache2 /var/run/apache2

# MYSQL

RUN apt-get install -y mysql-server-5.6 libapache2-mod-auth-mysql php5-mysql
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
ADD set-mysql-password.sh /tmp/set-mysql-password.sh
RUN /bin/sh /tmp/set-mysql-password.sh
RUN echo "root:magento2" | chpasswd
RUN apt-get clean
RUN rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

# PHP5

RUN apt-get install -y php5 libapache2-mod-php5 php5-mcrypt
RUN php5enmod mcrypt

EXPOSE 22 80 3306

VOLUME ["/var/lib/mysql"]

CMD ["/usr/sbin/sshd", "-D"]
CMD ["/usr/bin/supervisord"]
