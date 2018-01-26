FROM ubuntu:16.04
MAINTAINER davidmasclet@gisgraphy.com

ARG PGPASSWORD=password

ADD ./assets/install-env.sh /usr/local/install-env.sh
ARG DEBIAN_FRONTEND=noninteractive

USER root
CMD chmod +x /usr/local/install-env.sh

RUN /usr/local/install-env.sh $PGPASSWORD
RUN rm /usr/local/install-env.sh



#app
ADD ./assets/gisgraphy/gisgraphy-latest.zip /usr/local/gisgraphy.zip

ADD ./assets/install-gisgraphy.sh /usr/local/install-gisgraphy.sh
CMD chmod +x /usr/local/install-gisgraphy.sh

RUN /usr/local/install-gisgraphy.sh $PGPASSWORD
#clean
RUN rm /usr/local/install-gisgraphy.sh



EXPOSE 5432
EXPOSE 8080
#EXPOSE 8983



WORKDIR /usr/local/gisgraphy


ENTRYPOINT  service postgresql start; \
	/usr/local/gisgraphy/launch.sh; \
	bash;

