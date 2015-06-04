apt-get -q -y install mysql-server

mysqladmin -u root password klaxmikantp

DATABASE_NAME="VirtualLab"

mysql -u root -Bse "create database $DATABASE_NAME;"
mysql -u root -Bse "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' IDENTIFIED BY 'klaxmikantp' WITH GRANT OPTION;"

mkdir /usr/local/Temp
chmod -R 777 /usr/local/Temp
chown /usr/local/Temp tomcat7
cp fpgadb.sql /usr/local/Temp
