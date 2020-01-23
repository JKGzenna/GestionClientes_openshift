#!/bin/bash

#CREATE ENCRYPT KEY VARIABLE FOR OPENSSL DECRYPT-SCRIPT
encrypt_key=$(cat /etc/secret-volume/encrypt_key)

#DECRYT TAR OF SW_VERSION WITH OPENSSL DECRYPT-SCRIPT
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "/temporal/$SW_VERSION.encrypt" -out "/temporal/$SW_VERSION.tar" -pass stdin

#UNTAR FILES OF SW_VERSION IN APP FOLDER
tar -xvf /temporal/$SW_VERSION.tar -C /opt/clientesapp --strip 1

#DELETE PID OF APP FOR RESTART IN NEXT STEP
rm -rf /opt/clientesapp/RUNNING_PID

#RESTART CLIENTESAPP
bash /opt/clientesapp/bin/spring-boot-jpa-1.0
