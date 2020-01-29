#!/bin/bash

#CREATE ENCRYPT KEY VARIABLE FOR OPENSSL DECRYPT-SCRIPT
encrypt_key=$(cat /etc/secret-volume/password)

#UNTAR THE ENCRYPT SW_VERSION, COPY TO TMP AND DECRYPT TO TAR WITH OPENSSL DECRYPT-SCRIPT
tar -xvf /temporal/$SW_VERSION.tar
cp /temporal/$SW_VERSION.encrypt /tmp
rm -rf /temporal/$SW_VERSION.encrypt
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "/tmp/$SW_VERSION.encrypt" -out "/tmp/$SW_VERSION.tar" -pass stdin

#UNTAR FILES OF SW_VERSION TO JAR, COPY JAR IN APP FOLDER AND ERASE ALL TEMP FILES
tar -xvf /tmp/$SW_VERSION.tar -C /opt/clientesapp
rm -rf /tmp/$SW_VERSION.encrypt
rm -rf /tmp/$SW_VERSION.tar

#START CLIENTESAPP JAR
java -jar /opt/clientesapp/$SW_VERSION.jar
