#!/bin/bash

PGPASSWORD=mdppostgres

apt-get update && \
      apt-get -y install -y htop net-tools vim psmisc unzip

cd /usr/local/

cp ./assets/gisgraphy/gisgraphy-latest.zip /usr/local/gisgraphy.zip
unzip /usr/local/gisgraphy.zip -d /usr/local/gisgraphy/
cp -r /usr/local/gisgraphy/gisgraphy-5.0-beta1/* /usr/local/gisgraphy/
rm -rf /usr/local/gisgraphy/gisgraphy-5.0-beta1/*
rm  gisgraphy.zip
sed -i "s/password=/password=$PGPASSWORD/g" /usr/local/gisgraphy/webapps/ROOT/WEB-INF/classes/jdbc.properties

#startup script
chmod a+rx /usr/local/gisgraphy/*.sh

#locale
locale-gen fr_FR.UTF-8
dpkg-reconfigure -f noninteractive locales
LANGUAGE=fr_FR.UTF-8
LANG=fr_FR.UTF-8
LC_ALL=fr_FR.UTF-8


export PGPASSWORD=$PGPASSWORD && \
 service postgresql restart && \
 sleep 10 && \
 psql -Upostgres -h 127.0.0.1 -d gisgraphy -f /usr/local/gisgraphy/sql/create_tables.sql && \
 psql -Upostgres -h 127.0.0.1 -d gisgraphy -f /usr/local/gisgraphy/sql/insert_users.sql && \
 psql -Upostgres -h 127.0.0.1 -d gisgraphy -f /usr/local/gisgraphy/sql/createGISTIndex.sql




