FROM centos/s2i-core-centos7
MAINTAINER GCTIO Devops

## CREATE FOLDERS FOR INSTALL SOFTWARE VERSION
RUN mkdir -p /temporal && chgrp -R 0 /temporal && chmod 775 -R /temporal && \
    mkdir -p /opt/niji4home/backend && chgrp -R 0 /opt/niji4home

## INSTALL DEV PACKAGES AND ADD REQUISITES (LIBSODIUM & SBT)
RUN yum install epel-release curl java-1.8.0-openjdk glibc telnet net-tools \
    mongodb bind-utils netcap openssh-server openssl -y && yum clean all
ADD requisites/sbt-1.0.3.rpm /usr/local/src/
RUN /usr/bin/yum localinstall /usr/local/src/sbt-1.0.3.rpm -y
ADD requisites/libsodium-last-1.0.14-1.el7.remi.x86_64.rpm /usr/local/src
RUN rpm -i  /usr/local/src/libsodium-last-1.0.14-1.el7.remi.x86_64.rpm

## SETUP backendapp User
RUN adduser --system -s /bin/bash -u 10001 -g 0 backendapp

## INSTALL SOFTWARE VERSION
ADD latest_version/niji-for-home-2.6.0-SNAPSHOT-2019.05.10.11.24.50.encrypt /temporal
RUN chmod 775 -R /opt/niji4home && chown -R 10001 /opt/niji4home

## SETUP AUTO CONFIGMAPS DEPLOYER FOR USE VOLUME-CONFIGMAPS WITH RECURSIVELY FOLDERS
RUN mkdir -p /configmaps-deployer && chgrp -R 0 /configmaps-deployer && \
    chmod 775 -R /configmaps-deployer && chown -R 10001 /configmaps-deployer
COPY auto-cm-deploy.sh /configmaps-deployer/auto-cm-deploy.sh

COPY entrypoint.sh /tmp/entrypoint.sh

EXPOSE 9000
USER backendapp
CMD ["/tmp/entrypoint.sh"]
