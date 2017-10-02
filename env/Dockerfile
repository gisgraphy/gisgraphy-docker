FROM ubuntu:16.04 

WORKDIR /usr/local/

MAINTAINER davidmasclet@gisgraphy.com

#ENV PGPASSWORD=password
ARG PGPASSWORD=password

ADD ./install-env.sh /usr/local/install-env.sh
ARG DEBIAN_FRONTEND=noninteractive

USER root
RUN apt-get update && \
      apt-get -y install apt-utils 

RUN apt-get -y install sudo apt-utils python-software-properties python3-software-properties software-properties-common bash apt-utils
CMD chmod +x /usr/local/install-env.sh
EXPOSE 5432

RUN /usr/local/install-env.sh $PGPASSWORD
#clean
RUN rm /usr/local/install-env.sh

CMD  bash;
