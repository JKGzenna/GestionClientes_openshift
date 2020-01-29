#!/bin/bash
#CREATE ENCRYPT KEY VARIABLE FOR OPENSSL DECRYPT-SCRIPT
encrypt_key=$(cat /etc/secret-volume/password)

#UNTAR THE ENCRYPT SW_VERSION, COPY TO TEMPORAL AND DECRYPT TO TAR WITH OPENSSL DECRYPT-SCRIPT
tar -xvf /temporal/$SW_VERSION.tar
cp /temporal/$SW_VERSION.encrypt /tmp
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "/tmp/$SW_VERSION.encrypt" -out "/tmp/$SW_VERSION.tar" -pass stdin

#UNTAR FILES OF SW_VERSION TO JAR AND COPY JAR IN APP FOLDER
tar -xvf /tmp/$SW_VERSION.tar -C /opt/clientesapp

#START CLIENTESAPP JAR
cd /opt/clientesapp
java -jar $SW_VERSION.jar
