#!/bin/bash

## CREATE ENCRYPT KEY VARIABLE FOR OPENSSL DECRYPT-SCRIPT
encrypt_key=$(cat /etc/secret-volume/password)
sleep 2

## UNTAR THE ENCRYPT SW_VERSION, DELETE '.tar'
## AND DECRYPT FILE TO '.tar' WITH OPENSSL
cd /tmp
tar -xf $SW_VERSION.tar
sleep 4
cd /tmp
rm -rf /tmp/$SW_VERSION.tar
sleep 1
cd /tmp
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "$SW_VERSION.encrypt" -out "$SW_VERSION.tar" -pass stdin
sleep 4

## UNTAR FILE OF SW_VERSION TO '.jar', COPY '.jar' IN '/opt/clientesapp'
## FOLDER AND DELETE '.encrypt' AND '-tar' FILES AT '/temp' FOLDER
cd /tmp
tar -xf $SW_VERSION.tar -C /opt/clientesapp
sleep 4
cd /tmp
rm -rf $SW_VERSION.encrypt
sleep 1
cd /tmp
rm -rf $SW_VERSION.tar
sleep 1

## SUCCESS MESSAGE
echo "Desencriptación realizada con éxito, ejecutando $SW_VERSION.jar"
sleep 3

## GO TO '/opt/clienteapp' FOLDER AND START '.jar'
cd /opt/clientesapp
java -jar $SW_VERSION.jar