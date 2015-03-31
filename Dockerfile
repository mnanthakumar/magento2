FROM ubuntu:14.04
MAINTAINER Nantha Kumar <kumar.devilers@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

# UPDATE

RUN apt-get -y install supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Apache2 

RUN apt-get -y install apache2 
RUN mkdir -p /var/lock/apache2 /var/run/apache2


# SSH

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:magento2' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile


EXPOSE 22 80
CMD ["/usr/sbin/sshd", "-D"]
CMD ["/usr/bin/supervisord"]
