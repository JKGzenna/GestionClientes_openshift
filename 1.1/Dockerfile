FROM centos/s2i-core-centos7
MAINTAINER Juan Luis Goldaracena

## CREATE FOLDERS FOR INSTALL SOFTWARE VERSION
RUN mkdir -p /temporal && chgrp -R 0 /temporal && chmod 775 -R /temporal && \
    mkdir -p /procesado && chgrp -R 0 /procesado && chmod 775 -R /procesado && \
    mkdir -p /opt/clientesapp && chgrp -R 0 /opt/clientesapp

## INSTALL DEV PACKAGES
RUN yum install epel-release curl java-1.8.0-openjdk glibc telnet net-tools \
    mysql unzip bind-utils netcap openssh-server openssl -y && yum clean all

## SETUP clientesapp USER
RUN adduser --system -s /bin/bash -u 10001 -g 0 clientesapp

## INSTALL SOFTWARE VERSION
ADD latest_version/spring-boot-jpa-1.0.tar /procesado
RUN chmod 775 -R /procesado && chown -R 10001 /procesado
RUN chmod 775 /procesado/spring-boot-jpa-1.0.tar && \
    chown -R 10001 /procesado
RUN chmod 775 -R /temporal && chown -R 10001 /temporal
RUN chmod 775 -R /opt/clientesapp && chown -R 10001 /opt/clientesapp

## ENTRYPOINT CON SECURIZACION DE EJECUTABLES
COPY entrypoint.sh /tmp/entrypoint.sh
RUN chmod 775 /tmp/entrypoint.sh && chown -R 10001 /tmp

#PUERTO DE EXPOSICIÓN (EN NUESTRO CASO ESTE PUERTO LO REDIRIGIRÁ INTERNAMENTE NGINX HACIA EL 8448)
EXPOSE 8081

USER clientesapp

CMD ["/tmp/entrypoint.sh"]
