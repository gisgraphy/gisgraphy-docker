ARG BASE_IMAGE=gisgraphyofficial
FROM $BASE_IMAGE

USER root

ARG HOST_NAME=docker.gisgraphy.com
ARG PGPASSWORD=mdppostgres
ARG SOLR_DATA_DIR=/usr/local/gisgraphy/solr/data/
WORKDIR /usr/local/

#copy Dump files
#RUN mkdir /usr/local/dump
ADD ./assets/dump/data.zip /usr/local/dump/
ADD ./assets/dump/dump_localhost.zip /usr/local/dump/

#add script
ADD ./assets/inject-dump.sh /usr/local/dump/inject-dump.sh
RUN chmod +x /usr/local/dump/inject-dump.sh
RUN /usr/local/dump/inject-dump.sh $PGPASSWORD $SOLR_DATA_DIR
