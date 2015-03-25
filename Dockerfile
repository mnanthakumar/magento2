FROM ubuntu:14.04
MAINTAINER Nantha Kumar <kumar.devilers@gmail.com>


RUN apt-get update 

# install Apache2

RUN apt-get install -y apache2


# install Mysql

RUN apt-get install -y mysql-server-5.6 libapache2-mod-auth-mysql php5-mysql

# install Php

RUN apt-get install -y php5 libapache2-mod-php5 php5-mcrypt

# install ssh

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:magento2' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# install Extensions

RUN apt-get install -y curl php5-curl php5-intl php5-gd php5-mysql mcrypt php5-mcrypt

ADD phpinfo.php /var/www/html/

EXPOSE 22 80 3306

CMD ["/usr/sbin/sshd", "-D"]
