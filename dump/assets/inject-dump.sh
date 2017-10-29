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

if [[ -z $2 ]]
        then
                echo "no solr_dir specify"
                SOLR_DIR="/usr/local/gisgraphy/solr/";
        else
                echo "using solr_dir provided $2"
                SOLR_DIR=$2
        fi



cd /usr/local/
export  DEBIAN_FRONTEND=noninteractive;
#copy Dump files
mkdir /usr/local/dump
apt-get install -y bzip2
#decompress sql
cd /usr/local/dump/
tar xjvf dump_localhost.tar.bz2
# remove zipped sql
echo "removint bz2 file"
rm /usr/local/dump/dump_localhost.tar.bz2
#inject sql
service postgresql stop && sleep 20;
export PGPASSWORD=$PGPASSWORD && \
 service postgresql start && \
sleep 10 && \
psql -Upostgres -h127.0.0.1 -dgisgraphy -f /usr/local/gisgraphy/sql/resetdb.sql && \
/usr/bin/pg_restore  -h 127.0.0.1 -p 5432 -U postgres -j 8 -Fd -O -v -dgisgraphy /usr/local/dump/dump_localhost.dir || echo "import done"
sleep 500 && service postgresql stop && sleep 500

#purge dump dir
rm -rf /usr/local/dump/dump_localhost.dir/


#setup solr
rm -rf $SOLR_DIR/data
unzip /usr/local/dump/data.zip -d $SOLR_DIR

#remove solr zipped files
rm /usr/local/dump/data.zip

