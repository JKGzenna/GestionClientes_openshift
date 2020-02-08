#!/bin/bash

## CREATE ENCRYPT KEY VARIABLE FOR OPENSSL DECRYPT-SCRIPT
encrypt_key=$(cat /etc/secret-volume/password)

## DECRYPT FILE TO '.tar' WITH OPENSSL.
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "/tmp/$SW_VERSION.encrypt" -out "/tmp/$SW_VERSION.tar" -pass stdin

## UNTAR FILE OF SW_VERSION TO '.jar', MOVE '.jar' IN '/opt/clientesapp'
## FOLDER AND DELETE '.encrypt' AND '.tar' FILES AT '/tmp' FOLDER
tar -xf $SW_VERSION.tar --wildcards 'spring-boot-jpa-1.0.jar'
mv $SW_VERSION.jar /opt/clientesapp
rm -rf $SW_VERSION.encrypt
rm -rf $SW_VERSION.tar

## SUCCESS MESSAGE
echo "### Desencriptación realizada con éxito, ejecutando $SW_VERSION.jar ###"

## GO TO '/opt/clienteapp' FOLDER AND START '*.jar'
cd /opt/clientesapp
java -jar $SW_VERSION.jar