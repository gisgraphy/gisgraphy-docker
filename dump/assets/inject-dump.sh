#!/bin/bash

export HOST_NAME=docker.gisgraphy.com
if [[ -z $1 ]]
        then
                echo "no password specify"
                PGPASSWORD="mdppostgres";
        else
                echo "using password provided $1"
                PGPASSWORD=$1
        fi

cd /usr/local/

#copy Dump files
mkdir /usr/local/dump

#setup solr
rm -rf /usr/local/solr/solr/data
unzip /usr/local/dump/data.zip -d usr/local/solr/solr/data

#remove solr zipped files
rm /usr/local/dump/data.zip

#decompress sql
unzip /usr/local/dump/dump_localhost.zip -d /usr/local/dump/sql/
# remove zipped sql
rm /usr/local/dump/dump_localhost.zip

#inject sql
service postgresql stop && sleep 20;
export PGPASSWORD=$PGPASSWORD && \
 service postgresql start && \
sleep 10 && \
psql -Upostgres -h127.0.0.1 -dgisgraphy -f /usr/local/gisgraphy/sql/resetdb.sql && \
/usr/bin/pg_restore  -h 127.0.0.1 -p 5432 -U postgres -j 8 -Fd -O -v -dgisgraphy /usr/local/dump/sql/dump_localhost.dir || echo "import done"
sleep 500 && service postgresql stop && sleep 500

#purge dump dir
RUN rm -rf /usr/local/dump
