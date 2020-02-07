#!/bin/bash

## CREATE ENCRYPT KEY VARIABLE FOR OPENSSL DECRYPT-SCRIPT
encrypt_key=$(cat /etc/secret-volume/password)

## UNTAR THE ENCRYPT SW_VERSION, DELETE '.tar'
## AND DECRYPT FILE TO '.tar' WITH OPENSSL
cd /tmp
tar --extract -vv --occurrence --file=./$SW_VERSION.tar $SW_VERSION.encrypt
rm -rf /tmp/$SW_VERSION.tar
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "/tmp/$SW_VERSION.encrypt" -out "/tmp/$SW_VERSION.tar" -pass stdin

## UNTAR FILE OF SW_VERSION TO '.jar', COPY '.jar' IN '/opt/clientesapp'
## FOLDER AND DELETE '.encrypt' AND '-tar' FILES AT '/temp' FOLDER
cd /tmp
tar --extract -vv --occurrence --file=./$SW_VERSION.tar $SW_VERSION.jar -C /opt/clientesapp
#tar -xf /tmp/$SW_VERSION.tar -C /opt/clientesapp --strip 1
rm -rf /tmp/$SW_VERSION.encrypt
rm -rf /tmp/$SW_VERSION.tar

## SUCCESS MESSAGE
echo "Desencriptación realizada con éxito, ejecutando $SW_VERSION.jar"

## GO TO '/opt/clienteapp' FOLDER AND START '.jar'
cd /opt/clientesapp
java -jar $SW_VERSION.jar