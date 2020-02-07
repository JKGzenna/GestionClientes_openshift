#!/bin/bash

## CREATE ENCRYPT KEY VARIABLE FOR OPENSSL DECRYPT-SCRIPT
encrypt_key=$(cat /etc/secret-volume/password)

## UNTAR THE ENCRYPT SW_VERSION, DELETE '.tar'
## AND DECRYPT FILE TO '.tar' WITH OPENSSL
tar -xf $SW_VERSION.tar
rm -rf $SW_VERSION.tar
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "/tmp/$SW_VERSION.encrypt" -out "/tmp/$SW_VERSION.tar" -pass stdin

## UNTAR FILE OF SW_VERSION TO '.jar', COPY '.jar' IN '/opt/clientesapp'
## FOLDER AND DELETE '.encrypt' AND '-tar' FILES AT '/temp' FOLDER
tar -xvf $SW_VERSION.tar --wildcards 'spring-boot-jpa-1.0.jar' -C /opt/clientesapp
rm -rf $SW_VERSION.encrypt
rm -rf $SW_VERSION.tar

## SUCCESS MESSAGE
echo "Desencriptación realizada con éxito, ejecutando $SW_VERSION.jar"
sleep 3

## GO TO '/opt/clienteapp' FOLDER AND START '.jar'
cd /opt/clientesapp
java -jar $SW_VERSION.jar