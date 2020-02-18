#!/bin/bash
## COLOCAR EL '.jar' EN LA MISMA RUTA DEL SCRIPT Y EJECUTARLO DESDE ESE DIRECTORIO
## ENCRIPTAMOS EL '.jar' CON OPENSSL Y LO BORRAMOS
echo "Instale OpenSSL en Windows, en caso de no tener permisos de Adminsitrador para hacerlo, utilice el terminal bash de MobaXterm portable.
En MobaXterm, configure primero dentro de 'settings/general' una ruta para 'Persistent Home Directory' y para 'Persistent Root Directory'.
Si configura esas rutas, cualquier paquete que instale para enriquecer su sesión de bash, estará disponible al reiniciar MobaXterm. 
Después de configurar su sesión bash desde MobaXterm, ejecute 'apt-get install openssl -y' para instalar el paquete 'openssl'
Si ha realizado estos pasos anteriores correctamente podrá usar este script sin errores de encriptación, en caso contrario realice dichos pasos."
openssl enc -e -aes-256-cbc -md md5 -in "spring-boot-jpa-1.0.jar" -out "spring-boot-jpa-1.0.encrypt"