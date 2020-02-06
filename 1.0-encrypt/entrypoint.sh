#!/bin/bash

## CREATE ENCRYPT KEY VARIABLE FOR OPENSSL DECRYPT-SCRIPT
encrypt_key=$(cat /etc/secret-volume/password)

## UNTAR THE ENCRYPT SW_VERSION, COPY '.encrypt' FILE TO '/tmp' FOLDER,
## DELETE '/temporal' FILES AND DECRYPT FILE TO '.tar' WITH OPENSSL
tar -xf /tmp/$SW_VERSION.tar
rm -rf /tmp/$SW_VERSION.tar
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "/tmp/$SW_VERSION.encrypt" -out "/tmp/$SW_VERSION.tar" -pass stdin
rm -rf /tmp/$SW_VERSION.encrypt

## UNTAR FILE OF SW_VERSION TO '.jar', COPY '.jar' IN APP FOLDER
## AND DELETE RESIDUAL FILES '.encrypt' AND '-tar' ON '/temp' FOLDER
tar -xf /tmp/$SW_VERSION.tar -C /opt/clientesapp
rm -rf /tmp/$SW_VERSION.encrypt
rm -rf /tmp/$SW_VERSION.tar

## START CLIENTESAPP '.jar'
cd /opt/clientesapp
java -jar $SW_VERSION.jar
