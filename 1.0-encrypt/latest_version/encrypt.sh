#!/bin/bash
#COLOCAR EL '.jar' EN LATEST VERSION Y EJECUTARLO DESDE ESE DIRECTORIO

#CREAMOS LAS VARIABLES
export encrypt_key="34836a8f11beeaf01e12cd296251c65f"
export SW_VERSION="spring-boot-jpa-1.0"

#HACEMOS LAS CONVERSIONES, ENCRIPTAMOS Y BORRAMOS LOS TEMPORALES GENERADOS
tar -cvf $SW_VERSION.tar $SW_VERSION.jar
rm -rf $SW_VERSION.jar
echo -n "$encrypt_key" | openssl enc -e -aes-256-cbc -in "$SW_VERSION.tar" -out "$SW_VERSION.encrypt" -pass stdin
rm -rf $SW_VERSION.tar
tar -cvf $SW_VERSION.tar $SW_VERSION.encrypt
rm -rf $SW_VERSION.encrypt

#MENSAJE Y SALIDA
echo "Encriptación realizada con éxito"
sleep 5
exit