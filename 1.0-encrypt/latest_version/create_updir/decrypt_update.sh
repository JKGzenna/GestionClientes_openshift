#!/bin/bash

#CREAMOS LAS VARIABLES
encrypt_key=$(cat /etc/secret-volume/password)
SW_VERSION="spring-boot-jpa-1.0"

#HACEMOS LAS CONVERSIONES, DESENCRIPTAMOS Y BORRAMOS LOS TEMPORALES GENERADOS
tar -xf /opt/clientesapp/update/$SW_VERSION.tar
rm -rf /opt/clientesapp/update/$SW_VERSION.tar
echo -n "$encrypt_key" | openssl enc -d -aes-256-cbc -in "/opt/clientesapp/update/$SW_VERSION.encrypt" -out "/opt/clientesapp/update/$SW_VERSION.tar" -pass stdin
rm -rf /opt/clientesapp/update/$SW_VERSION.encrypt
tar -xf /opt/clientesapp/update/$SW_VERSION.tar
rm -rf /opt/clientesapp/update/$SW_VERSION.tar
cp /opt/clientesapp/update/$SW_VERSION.jar /opt/clientesapp
rm -rf /opt/clientesapp/$SW_VERSION.jar

#MENSAJE Y EJECUCIÓN
echo "Desencriptación realizada con éxito, ejecutando update de $SW_VERSION.jar' para terminar de aplicar la actualización"
sleep 8
java -jar /opt/clientesapp/$SW_VERSION.jar
