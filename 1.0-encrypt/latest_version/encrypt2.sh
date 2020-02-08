#!/bin/bash

## COLOCAR EL '.jar' EN LA MISMA RUTA DEL SCRIPT Y EJECUTARLO DESDE ESE DIRECTORIO

## CREAMOS LAS VARIABLES
encrypt_key=$(cat /etc/secret-volume/password)
SW_VERSION="spring-boot-jpa-1.0"

## DAMOS PERMISOS AL '.jar'
chmod +x $SW_VERSION.jar
chmod 777 $SW_VERSION.jar

## ENCRIPTAMOS EL '.jar' CON OPENSSL Y LO BORRAMOS
echo -n "$encrypt_key" | openssl enc -e -aes-256-cbc -in "$SW_VERSION.jar" -out "$SW_VERSION.encrypt" -pass stdin
rm -rf $SW_VERSION.jar

## DAMOS PERMISOS AL '.encrypt'
chmod +x $SW_VERSION.encrypt
chmod 777 $SW_VERSION.encrypt

##MENSAJE Y SALIDA
echo "Encriptación realizada con éxito"
exit