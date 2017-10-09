#!/bin/bash

if [[ -z $1 ]]
        then
                echo "no password specify"
                PGPASSWORD="mdppostgres";
        else
                echo "using password provided $1"
                PGPASSWORD=$1
        fi

cd /usr/local/
apt-get update && \
      apt-get -y install -y htop net-tools vim psmisc unzip

unzip /usr/local/gisgraphy.zip -d /usr/local/gisgraphy/
cp -r /usr/local/gisgraphy/gisgraphy-5.0-beta1/* /usr/local/gisgraphy/
rm -rf /usr/local/gisgraphy/gisgraphy-5.0-beta1/*
rm  /usr/local/gisgraphy.zip
sed -i "s/password=/password=$PGPASSWORD/g" /usr/local/gisgraphy/webapps/ROOT/WEB-INF/classes/jdbc.properties

chmod a+rx /usr/local/gisgraphy/*.sh

locale-gen fr_FR.UTF-8
dpkg-reconfigure -f noninteractive locales

export LANGUAGE=fr_FR.UTF-8
export LANG=fr_FR.UTF-8
export LC_ALL=fr_FR.UTF-8

service postgresql stop && sleep 20;

export PGPASSWORD=$PGPASSWORD && \
 service postgresql start && \
sleep 10 && \
 psql -Upostgres -h 127.0.0.1 -d gisgraphy -f /usr/local/gisgraphy/sql/create_tables.sql && \
 psql -Upostgres -h 127.0.0.1 -d gisgraphy -f /usr/local/gisgraphy/sql/insert_users.sql && \
 psql -Upostgres -h 127.0.0.1 -d gisgraphy -f /usr/local/gisgraphy/sql/createGISTIndex.sql && \
 service postgresql stop
