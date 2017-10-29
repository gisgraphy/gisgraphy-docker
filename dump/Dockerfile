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
