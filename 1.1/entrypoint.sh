#!/bin/bash
#CREATE ENCRYPT KEY VARIABLE FOR OPENSSL DECRYPT-SCRIPT
encrypt_key=$(cat /etc/secret-volume/password)

#DECRYT TAR OF SW_VERSION WITH OPENSSL DECRYPT-SCRIPT
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "/temporal/$SW_VERSION.encrypt" -out "/opt/clientesapp/$SW_VERSION.jar" -pass stdin

#START CLIENTESAPP
cd /opt/clientesapp
java -jar $SW_VERSION.jar
