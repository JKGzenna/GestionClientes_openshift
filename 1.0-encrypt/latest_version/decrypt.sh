#!/bin/bash
#COLOCAR EL '.encrypt' EN LATEST VERSION O EN LA MISMA RUTA DEL SCRIPT Y EJECUTARLO DESDE ESE DIRECTORIO

#CREAMOS LAS VARIABLES
export encrypt_key="34836a8f11beeaf01e12cd296251c65f"
export SW_VERSION="spring-boot-jpa-1.0"

#HACEMOS LAS CONVERSIONES, DESENCRIPTAMOS Y BORRAMOS LOS TEMPORALES GENERADOS
tar -xvf $SW_VERSION.tar
rm -rf $SW_VERSION.tar
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "$SW_VERSION.encrypt" -out "$SW_VERSION.tar" -pass stdin
rm -rf $SW_VERSION.encrypt
tar -xvf $SW_VERSION.tar
rm -rf $SW_VERSION.tar

#MENSAJE Y SALIDA
echo "Encriptación realizada con éxito"
exit