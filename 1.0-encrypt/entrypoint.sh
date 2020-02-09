#!/bin/bash

## CREATE ENCRYPT KEY VARIABLE FOR DECRYPT FILE WITH OPENSSL
encrypt_key=$(cat /etc/secret-volume/password)

## DECRYPT FILE TO '.jar' WITH OPENSSL
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "/tmp/$SW_VERSION.encrypt" -out "/tmp/$SW_VERSION.jar" -pass stdin

## MOVE '.jar' TO '/opt/clientesapp' FOLDER
mv /tmp/$SW_VERSION.jar /opt/clientesapp

## SUCCESS MESSAGE
echo "### Desencriptación realizada con éxito, ejecutando $SW_VERSION.jar ###"

## GO TO '/opt/clienteapp' FOLDER, FIX PERMISSIONS AND START '*.jar'
cd /opt/clientesapp
chmod +x $SW_VERSION.jar
chmod 775 $SW_VERSION.jar
java -jar $SW_VERSION.jar