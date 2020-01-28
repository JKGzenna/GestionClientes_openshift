#!/bin/bash

#START CLIENTESAPP CREATE
cd /opt/clientesapp/create
java -jar spring-boot-jpa-1.0.jar

sleep 10

#RE-START CLIENTESAPP UPDATE
cd /opt/clientesapp/update
java -jar spring-boot-jpa-1.0.jar
