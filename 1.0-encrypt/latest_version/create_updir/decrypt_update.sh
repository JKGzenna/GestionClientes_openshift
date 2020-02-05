#!/bin/bash
#COLOCAR EL '.encrypt' EN LATEST VERSION O EN LA MISMA RUTA DEL SCRIPT Y EJECUTARLO DESDE ESE DIRECTORIO

#CREAMOS LAS VARIABLES
encrypt_key=$(cat /etc/secret-volume/password)
SW_VERSION="spring-boot-jpa-1.0"

#HACEMOS LAS CONVERSIONES, DESENCRIPTAMOS Y BORRAMOS LOS TEMPORALES GENERADOS
tar -xvf $SW_VERSION.tar
rm -rf $SW_VERSION.tar
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "$SW_VERSION.encrypt" -out "$SW_VERSION.tar" -pass stdin
rm -rf $SW_VERSION.encrypt
rm -rf /opt/clientesapp/$SW_VERSION.jar
tar -xvf $SW_VERSION.tar -C /opt/clientesapp
rm -rf $SW_VERSION.tar
rm -rf $SW_VERSION.jar

#MENSAJE Y APLICACION DEL UPDATE
echo "Desencriptación realizada con éxito, ejecutando $SW_VERSION.jar' para terminar de aplicar la actualización"
