#!/bin/bash
## COLOCAR EL '.jar' EN LA MISMA RUTA DEL SCRIPT Y EJECUTARLO DESDE ESE DIRECTORIO
## ENCRIPTAMOS EL '.jar' CON OPENSSL Y LO BORRAMOS
openssl enc -e -aes-256-cbc -md md5 -in "spring-boot-jpa-1.0.jar" -out "spring-boot-jpa-1.0.encrypt"