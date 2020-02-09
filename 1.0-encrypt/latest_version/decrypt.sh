#!/bin/bash

## COLOCAR EL '.encrypt' EN LA MISMA RUTA DEL SCRIPT Y EJECUTARLO DESDE ESE DIRECTORIO

## CREAMOS LAS VARIABLES
encrypt_key=$(cat /etc/secret-volume/password)
SW_VERSION="spring-boot-jpa-1.0"

## DESENCRIPTAMOS EL '.encrypt' CON OPENSSL Y LO BORRAMOS
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "$SW_VERSION.encrypt" -out "$SW_VERSION.jar" -pass stdin
rm -rf $SW_VERSION.encrypt

## DAMOS PERMISOS AL '.jar'
chmod +x $SW_VERSION.jar
chmod 777 $SW_VERSION.jar

#MENSAJE Y SALIDA
echo "Desencriptación realizada con éxito"
exit