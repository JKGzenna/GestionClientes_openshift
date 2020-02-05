#!/bin/bash
#COLOCAR EL '.encrypt' EN LATEST VERSION O EN LA MISMA RUTA DEL SCRIPT Y EJECUTARLO DESDE ESE DIRECTORIO

#CREAMOS LAS VARIABLES
encrypt_key=$(cat /etc/secret-volume/password)
SW_VERSION="spring-boot-jpa-1.0"

#HACEMOS LAS CONVERSIONES, DESENCRIPTAMOS Y BORRAMOS LOS TEMPORALES GENERADOS
tar -xf $SW_VERSION.tar
rm -rf $SW_VERSION.tar
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "$SW_VERSION.encrypt" -out "$SW_VERSION.tar" -pass stdin
rm -rf $SW_VERSION.encrypt
tar -xf $SW_VERSION.tar
rm -rf $SW_VERSION.tar
rm -rf /opt/clientesapp/SW_VERSION.jar
cp $SW_VERSION.jar /opt/clientesapp

#MENSAJE Y EJECUACIÓN DEL UPDATE
echo "Desencriptación realizada con éxito, actualizando y creando directorio '/uploads', recuerde entrar, crear un cliente con imagen, ver que funciona, y crear el build desde la rama update, despues de desplegar desde ese build crear el volumen para la carpeta '/uploads' y se volverá a reinicar"
sleep 5
java -jar $SW_VERSION.jar
