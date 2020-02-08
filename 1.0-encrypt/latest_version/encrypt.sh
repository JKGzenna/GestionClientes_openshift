#!/bin/bash

## COLOCAR EL '.jar' EN LA MISMA RUTA DEL SCRIPT Y EJECUTARLO DESDE ESE DIRECTORIO

## CREAMOS LAS VARIABLES
encrypt_key=$(cat /etc/secret-volume/password)
SW_VERSION="spring-boot-jpa-1.0"

## DAMOS PERMISOS AL '.jar'
chmod +x $SW_VERSION.jar
chmod 775 $SW_VERSION.jar

## EMPAQUETAMOS EN '.tar' Y BORRAMOS EL '.jar'
tar -cf $SW_VERSION.tar $SW_VERSION.jar
rm -rf $SW_VERSION.jar

## ENCRIPTAMOS EL '.tar' CON OPENSSL Y BORRAMOS EL '.tar'
echo -n "$encrypt_key" | openssl enc -e -aes-256-cbc -in "$SW_VERSION.tar" -out "$SW_VERSION.encrypt" -pass stdin
rm -rf $SW_VERSION.tar

## COMPRIMIMOS EN 'tgz' EL '.encrypt' Y BORRAMOS EL '.encrypt'
tar -czf $SW_VERSION.tgz $SW_VERSION.encrypt
rm -rf $SW_VERSION.encrypt

## DAMOS PERMISOS AL '.tgz'
chmod +x $SW_VERSION.tgz
chmod 775 $SW_VERSION.tgz

##MENSAJE Y SALIDA
echo "Encriptación realizada con éxito"
exit