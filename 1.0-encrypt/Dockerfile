FROM centos/s2i-core-centos7
MAINTAINER Juan Luis Goldaracena

## CREATE FOLDERS FOR INSTALL SOFTWARE VERSION
RUN mkdir -p /opt/clientesapp && chgrp -R 0 /opt/clientesapp

## INSTALL DEV PACKAGES
RUN yum install epel-release curl java-1.8.0-openjdk glibc telnet net-tools \
    mysql bind-utils netcap openssh-server openssl -y && yum clean all

## CONFIG clientesapp USER
RUN adduser --system -s /bin/bash -u 10001 -g 0 clientesapp

## INSTALL SOFTWARE VERSION
ADD latest_version/spring-boot-jpa-1.0.tar /tmp

## FIX PERMISSIONS
RUN chmod 775 -R /tmp && chgrp -R 0 /tmp && chown -R 10001 /tmp && \
    chmod 775 -R /opt/clientesapp && chown -R 10001 /opt/clientesapp

## ENTRYPOINT WITH SECURIZATION FOR EXECUTE FILES
COPY entrypoint.sh /tmp/entrypoint.sh

## FIX PERMISSIONS
RUN chmod 775 -R /tmp && chgrp -R 0 /tmp && chown -R 10001 /tmp && \

## APP EXPOSE PORT (NGINX SERVICE REDIRECT PORT 8081 -> 8448)
EXPOSE 8081

## SETUP clientesapp USER
USER clientesapp

## EXECUTE SECURE ENTRYPOINT
CMD ["/tmp/entrypoint.sh"]