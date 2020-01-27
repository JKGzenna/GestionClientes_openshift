#!/bin/bash

#START CLIENTESAPP CREATE
cd /opt/clientesapp/create
sudo java -jar $SW_VERSION.jar

sleep 10

#RE-START CLIENTESAPP UPDATE
cd /opt/clientesapp/update
sudo java -jar $SW_VERSION.jar
