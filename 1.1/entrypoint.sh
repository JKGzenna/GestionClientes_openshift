#!/bin/bash
#CREATE ENCRYPT KEY VARIABLE FOR OPENSSL DECRYPT-SCRIPT
encrypt_key=$(cat /etc/secret-volume/password)

#UNTAR THE ENCRYPT AND DECRYT TO TAR OF SW_VERSION WITH OPENSSL DECRYPT-SCRIPT
tar xvf /procesado/spring-boot-jpa-1.0.tar -C /temporal
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "/temporal/spring-boot-jpa-1.0.encrypt" -out "/temporal/spring-boot-jpa-1.0.tar" -pass stdin

#UNTAR FILES OF SW_VERSION TO JAR AND COPY IN APP FOLDER
tar xvf /temporal/spring-boot-jpa-1.0.tar -C /opt/clientesapp

#START CLIENTESAPP
cd /opt/clientesapp
java -jar spring-boot-jpa-1.0.jar
