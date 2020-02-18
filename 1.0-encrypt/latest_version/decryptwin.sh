#!/bin/bash
## COLOCAR EL '.encrypt' EN LA MISMA RUTA DEL SCRIPT Y EJECUTARLO DESDE ESE DIRECTORIO
## DESENCRIPTAMOS EL '.encrypt' CON OPENSSL
echo "Instale OpenSSL en Windows, en caso de no tener permisos de Adminsitrador utilice el terminal bash de MobaXterm ejecutando dentro de él 'apt-get install openssl -y' antes de usar este script, recuerde además en 'settings/general' del MobaXterm asignar una ruta para el 'Persistent Home Directory' y para el 'Persistent Root Directory' ;-)"
openssl enc -d -aes-256-cbc -md md5 -in "spring-boot-jpa-1.0.encrypt" -out "spring-boot-jpa-1.0.jar"