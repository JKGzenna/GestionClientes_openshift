FROM centos/s2i-core-centos7
MAINTAINER Juan Luis Goldaracena

## CREATE FOLDERS FOR INSTALL SOFTWARE VERSION
RUN mkdir -p /opt/clientesapp && chgrp -R 0 /opt/clientesapp

## INSTALL DEV PACKAGES
RUN yum install epel-release curl java-1.8.0-openjdk glibc telnet net-tools \
    mysql bind-utils netcap openssh-server openssl -y && yum clean all

## SETUP clientesapp USER
RUN adduser --system -s /bin/bash -u 10001 -g 0 clientesapp

## INSTALL SOFTWARE VERSION
ADD latest_version/spring-boot-jpa-1.0.jar /opt/clientesapp
RUN chmod 775 -R /opt/clientesapp && chown -R 10001 /opt/clientesapp

COPY entrypoint.sh /tmp/entrypoint.sh

#PUERTO DE EXPOSICIÓN (EN NUESTRO CASO ESTE PUERTO LO REDIRIGIRÁ INTERNAMENTE NGINX HACIA OTRO ESTABLECIDO POR EL)
EXPOSE 8081

USER clientesapp

CMD ["/tmp/entrypoint.sh"]
