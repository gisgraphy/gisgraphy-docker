#!/bin/bash

if [ ! "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]; then  echo "this script is only designed to be run on Debian/Ubuntu/Mint"; exit 1; fi


if [[ -z $1 ]]
        then
                echo "no password specify"
                postgres_password="mdppostgres";
        else
		echo "using password provided $1"
                postgres_password=$1
        fi


apt-get update && \
      apt-get -y install apt-utils
apt-get -y install sudo apt-utils python-software-properties python3-software-properties software-properties-common bash apt-utils wget

#add-apt-repository -y  ppa:webupd8team/java
#apt-get update
#echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
#echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
#
apt-get install -y sudo
#apt-get install -y oracle-java8-installer 
#add-apt-repository -y  ppa:webupd8team/java
#apt-get update
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
#apt-get install -y oracle-java8-installer sudo
wget --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/8u202-b08/1961070e4c9b4e26a04e7f5a083f551e/jdk-8u202-linux-x64.tar.gz

mkdir /opt/jdk

sudo tar -zxf jdk-8u202-linux-x64.tar.gz  -C /opt/jdk
rm jdk-8u202-linux-x64.tar.gz
update-alternatives --install /usr/bin/java java /opt/jdk/jdk1.8.0_202/bin/java 100





# postgres
#on ubuntu 16.04
apt-get install -y postgresql-9.5
apt-get install -y  postgresql-contrib-9.5
apt-get install -y postgis postgresql-9.5-postgis-2.2

#on ubuntu 18.04 and later
#apt-get install postgresql-10 postgis postgresql-10-postgis-2.4 postgresql-contrib


/etc/init.d/postgresql start

sudo -u postgres psql -c "ALTER USER postgres PASSWORD '$postgres_password'"
export PGPASSWORD="$postgres_password"

echo "UPDATE pg_database SET datistemplate=FALSE WHERE datname='template1';" > utf8.sql; \
	echo "DROP DATABASE template1;" >> utf8.sql; \
	echo "CREATE DATABASE template1 WITH owner=postgres template=template0 encoding='UTF8';" >> utf8.sql; \
	echo "UPDATE pg_database SET datistemplate=TRUE WHERE datname='template1';" >> utf8.sql

psql -U postgres -h localhost -a -f utf8.sql; 
rm utf8.sql

psql -U postgres -h 127.0.0.1 -c "CREATE DATABASE gisgraphy ENCODING = 'UTF8';"


psql -U postgres -h 127.0.0.1 -d gisgraphy -f /usr/share/postgresql/9.5/contrib/postgis-2.2/postgis.sql
psql -U postgres -h 127.0.0.1 -d gisgraphy -f /usr/share/postgresql/9.5/contrib/postgis-2.2/spatial_ref_sys.sql

#psql -U postgres -h 127.0.0.1 -d gisgraphy -f /usr/share/postgresql/10/contrib/postgis-2.4/postgis.sql
#psql -U postgres -h 127.0.0.1 -d gisgraphy -f /usr/share/postgresql/10/contrib/postgis-2.4/spatial_ref_sys.sql

/etc/init.d/postgresql stop && sleep 20;

apt-get -y install -y htop net-tools vim psmisc unzip
