#!/bin/bash

#CREATE ENCRYPT KEY VARIABLE FOR OPENSSL DECRYPT-SCRIPT
encrypt_key=$(cat /etc/secret-volume/encrypt_key)

#DECRYT TAR OF SW_VERSION WITH OPENSSL DECRYPT-SCRIPT
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "/temporal/create/$SW_VERSION.encrypt" -out "/temporal/create/$SW_VERSION.tar" -pass stdin
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "/temporal/update/$SW_VERSION.encrypt" -out "/temporal/update/$SW_VERSION.tar" -pass stdin

#UNTAR FILES OF SW_VERSION IN APP FOLDER
tar -xvf /temporal/create/$SW_VERSION.tar -C /opt/clientesapp/create --strip 1
tar -xvf /temporal/update/$SW_VERSION.tar -C /opt/clientesapp/update --strip 1

#START CLIENTESAPP CREATE
cd /opt/clientesapp/create
sudo java -jar $SW_VERSION.jar

sleep 10

#RE-START CLIENTESAPP UPDATE
cd /opt/clientesapp/update
sudo java -jar $SW_VERSION.jar
