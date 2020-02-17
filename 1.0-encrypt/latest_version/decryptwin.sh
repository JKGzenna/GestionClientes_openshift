#!/bin/bash
## COLOCAR EL '.encrypt' EN LA MISMA RUTA DEL SCRIPT Y EJECUTARLO DESDE ESE DIRECTORIO
## DESENCRIPTAMOS EL '.encrypt' CON OPENSSL
openssl enc -d -aes-256-cbc -md md5 -in "spring-boot-jpa-1.0.encrypt" -out "spring-boot-jpa-1.0.jar"