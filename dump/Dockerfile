ARG BASE_IMAGE=gisgraphyofficial
FROM $BASE_IMAGE

USER root

ARG HOST_NAME=docker.gisgraphy.com
ARG PGPASSWORD=mdppostgres
ARG SOLR_DIR=/usr/local/gisgraphy/solr/
WORKDIR /usr/local/

#copy Dump files
#RUN mkdir /usr/local/dump
COPY ./assets/dump/data.zip /usr/local/dump/
COPY ./assets/dump/dump_localhost.tar.bz2 /usr/local/dump/

#add script
ADD ./assets/inject-dump.sh /usr/local/dump/inject-dump.sh
RUN chmod +x /usr/local/dump/inject-dump.sh
RUN /usr/local/dump/inject-dump.sh $PGPASSWORD $SOLR_DIR


#RUN   service postgresql start; service gisgraphy start; netstat -tnlp 2>&1| grep 8080 > /dev/null; while [ $? -eq 1 ]; do   sleep 5 ;echo "not already started...waiting";netstat -tnlp 2>&1| grep 8080 > /dev/null; done;echo "gisgraphy is started" service gisgraphy stop ; sleep 60;  service postgresql stop;sleep 60;



