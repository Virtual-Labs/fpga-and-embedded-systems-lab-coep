#!/bin/bash

#apt-get -q -y install mysql-server

mysqladmin -u root password klaxmikantp

DATABASE_NAME="VirtualLab"

mysql -u root -pklaxmikantp -Bse "create database $DATABASE_NAME;"
mysql -u root -pklaxmikantp -Bse "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'klaxmikantp' WITH GRANT OPTION;"

mkdir -p /usr/local/Temp
chmod 777 -R /usr/local/Temp
chown -R tomcat7:tomcat7 /usr/local/Temp
cp ./fpgadb.sql /usr/local/Temp
