FROM gisgraphyenv

USER root

#ENV HOST_NAME "docker.gisgraphy.com"
ARG PGPASSWORD=password

RUN apt-get update && \
      apt-get -y install -y htop net-tools vim psmisc unzip

WORKDIR /usr/local/

#app
ADD ./assets/gisgraphy/gisgraphy-latest.zip /usr/local/gisgraphy.zip
RUN unzip /usr/local/gisgraphy.zip -d /usr/local/gisgraphy/
RUN cp -r /usr/local/gisgraphy/gisgraphy-5.0-beta1/* /usr/local/gisgraphy/
RUN rm -rf /usr/local/gisgraphy/gisgraphy-5.0-beta1/*
RUN rm  gisgraphy.zip
RUN  sed -i "s/password=/password=$PGPASSWORD/g" /usr/local/gisgraphy/webapps/ROOT/WEB-INF/classes/jdbc.properties

#startup script
RUN chmod a+rx /usr/local/gisgraphy/*.sh

#locale
RUN locale-gen fr_FR.UTF-8
RUN dpkg-reconfigure -f noninteractive locales
ENV LANGUAGE=fr_FR.UTF-8
ENV LANG=fr_FR.UTF-8
ENV LC_ALL=fr_FR.UTF-8

#SQL init
RUN service postgresql stop && sleep 20;
RUN export PGPASSWORD=$PGPASSWORD && \
 service postgresql start && \
sleep 10 && \
 psql -Upostgres -h 127.0.0.1 -d gisgraphy -f /usr/local/gisgraphy/sql/create_tables.sql && \
 psql -Upostgres -h 127.0.0.1 -d gisgraphy -f /usr/local/gisgraphy/sql/insert_users.sql && \
 psql -Upostgres -h 127.0.0.1 -d gisgraphy -f /usr/local/gisgraphy/sql/createGISTIndex.sql && \
 service postgresql stop

ARG DEBIAN_FRONTEND=noninteractive


#EXPOSE 5432
EXPOSE 8080
EXPOSE 22
#EXPOSE 8983



WORKDIR /usr/local/gisgraphy


ENTRYPOINT  service postgresql start; \
	/usr/local/gisgraphy/launch.sh; \
	bash;

