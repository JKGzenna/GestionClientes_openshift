FROM centos/s2i-core-centos7
MAINTAINER Juan Luis Goldaracena

## CREATE FOLDERS FOR INSTALL SOFTWARE VERSION
RUN mkdir -p /opt/clientesapp && chgrp -R 0 /opt/clientesapp

## INSTALL DEV PACKAGES
RUN yum install epel-release curl java-1.8.0-openjdk glibc telnet net-tools \
    mysql bind-utils netcap openssh-server openssl -y && yum clean all

## CONFIG clientesapp USER
RUN adduser --system -s /bin/bash -u 10001 -g 0 clientesapp

## INSTALL ENCRYPT SOFTWARE VERSION
ADD latest_version/spring-boot-jpa-1.0.encrypt /tmp

## FIX PERMISSIONS FOR '/opt/clientesapp' FOLDER
RUN chmod 775 -R /opt/clientesapp && chown -R 10001 /opt/clientesapp

## COPY 'entrypoint.sh' WITH SECURIZATION FOR DECRYPT JAR FILES
COPY entrypoint.sh /tmp/entrypoint.sh

## FIX PERMISSIONS FOR '/tmp' FOLDER
RUN chmod 775 -R /tmp && chgrp -R 0 /tmp && chown -R 10001 /tmp

## APP EXPOSE PORT (NGINX SERVICE REDIRECT PORT 8081 -> 8448)
EXPOSE 8081

## SETUP clientesapp USER
USER clientesapp

## EXECUTE SECURE ENTRYPOINT
CMD ["/tmp/entrypoint.sh"]