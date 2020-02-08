#!/bin/bash

## COLOCAR EL '.encrypt' EN LA MISMA RUTA DEL SCRIPT Y EJECUTARLO DESDE ESE DIRECTORIO

## CREAMOS LAS VARIABLES
encrypt_key=$(cat /etc/secret-volume/password)
SW_VERSION="spring-boot-jpa-1.0"

## DESCOMPRIMIMOS EL '.encrypt' QUE HAY DENTRO DEL '.tgz' Y BORRAMOS EL '.tgz'
tar -xzf $SW_VERSION.tgz
rm -rf $SW_VERSION.tgz

## DESENCRIPTAMOS CON OPENSSL Y BORRAMOS EL '.encrypt'
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "$SW_VERSION.encrypt" -out "$SW_VERSION.tar" -pass stdin
rm -rf $SW_VERSION.encrypt

## DESEMPAQUETAMOS EL '.jar' QUE HAY DENTRO DEL '.tar' Y BORRAMOS EL '.tar'
tar -xf $SW_VERSION.tar
rm -rf $SW_VERSION.tar

#MENSAJE Y SALIDA
echo "Desencriptación realizada con éxito"
exit