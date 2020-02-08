#!/bin/bash

#COLOCAR EL '.jar' EN LA MISMA RUTA DEL SCRIPT Y EJECUTARLO DESDE ESE DIRECTORIO

#CREAMOS LAS VARIABLES
encrypt_key=$(cat /etc/secret-volume/password)
SW_VERSION="spring-boot-jpa-1.0"

#DAMOS PERMISOS, HACEMOS LAS CONVERSIONES, ENCRIPTAMOS, DAMOS PERMISOS Y BORRAMOS LOS TEMPORALES GENERADOS
chmod +x $SW_VERSION.jar
chmod 777 $SW_VERSION.jar
tar -cvf $SW_VERSION.tar $SW_VERSION.jar
rm -rf $SW_VERSION.jar
echo -n "$encrypt_key" | openssl enc -e -aes-256-cbc -in "$SW_VERSION.tar" -out "$SW_VERSION.encrypt" -pass stdin
rm -rf $SW_VERSION.tar
tar -czvf $SW_VERSION.tgz $SW_VERSION.encrypt
#tar -cvf $SW_VERSION.tar $SW_VERSION.encrypt
chmod +x $SW_VERSION.tgz
chmod 777 $SW_VERSION.tgz
rm -rf $SW_VERSION.encrypt

#MENSAJE Y SALIDA
echo "Encriptación realizada con éxito"
exit