#!/bin/bash
#CREATE ENCRYPT KEY VARIABLE FOR OPENSSL DECRYPT-SCRIPT
encrypt_key=$(cat /etc/secret-volume/password)

#DECRYT TO TAR OF SW_VERSION WITH OPENSSL DECRYPT-SCRIPT
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "/temporal/$SW_VERSION.encrypt" -out "/temporal/$SW_VERSION.tar" -pass stdin

#UNTAR FILES OF SW_VERSION TO JAR AND COPY IN APP FOLDER
tar -xvf /temporal/$SW_VERSION.tar -C /opt/clientesapp

#START CLIENTESAPP
cd /opt/clientesapp
java -jar $SW_VERSION.jar
