#!/bin/bash

#START CLIENTESAPP CREATE
cd /opt/clientesapp/create
java -jar $SW_VERSION.jar

sleep 10

#RE-START CLIENTESAPP UPDATE
cd /opt/clientesapp/update
java -jar $SW_VERSION.jar
