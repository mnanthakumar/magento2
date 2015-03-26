#!/bin/bash

/usr/bin/mysqld_safe > /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    echo "=> Waiting for confirmation of MySQL service startup"
    sleep 5
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

PASS=${MYSQL_PASS:-$(pwgen -s 12 1)}
_word=$( [ ${MYSQL_PASS} ] && echo "preset" || echo "random" )
echo "=> Creating MySQL admin user with ${_word} password"

mysql -uroot -e "CREATE USER 'admin'@'%' IDENTIFIED BY '$PASS'"
mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION"


echo "=> Done!"

echo "========================================================================"
echo "You can now connect to this MySQL Server using:"
echo ""
echo "    mysql -uadmin -p$PASS -h<host> -P<port>"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "MySQL user 'root' has no password but only allows local connections"
echo "========================================================================"

mysqladmin -uroot shutdown





FROM ubuntu:14.04
MAINTAINER Nantha Kumar <kumar.devilers@gmail.com>

RUN apt-get update 

# install Apache2

RUN apt-get install -y apache2
RUN mkdir -p /var/lock/apache2 /var/run/apache2

# install Mysql

RUN apt-get install -y mysql-server-5.6 libapache2-mod-auth-mysql php5-mysql

# install Php

RUN apt-get install -y php5 libapache2-mod-php5 php5-mcrypt

# install Server

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:magento2' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# install Supervisor

RUN apt-get install -y supervisor
RUN mkdir /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# install Extensions

RUN apt-get install -y curl php5-curl php5-intl php5-gd php5-mysql mcrypt php5-mcrypt

ADD phpinfo.php /var/www/html/

EXPOSE 22 80 3306

CMD ["/usr/sbin/sshd", "-D"]
CMD ["/usr/bin/supervisord"]
