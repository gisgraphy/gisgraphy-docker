#!/bin/bash

function exitIfFails {
if  [[ $? != 0 ]] 
		then
			echo "last process has fails, exiting : $1";
			exit 1
fi
}



if [ `id -u` != 0 ]; then
        echo "you must run this script as root. Please re run the script prefixed by sudo or log as root "
	exit

fi


if [[ -z $1 ]]
        then
                echo "no password specify (using default one), you could specify a password if you want : usage  $0 PASSWORD"
                PGPASSWORD="mdppostgres";
        else
		echo "using password provided $1"
                PGPASSWORD=$1
fi

if [ ! -f ./assets/gisgraphy/gisgraphy-latest.zip ]; then
    echo "please download the latest gisgraphy version 'gisgraphy-latest.zip' and put it in ./assets/gisgraphy/ directory"
    exit 1
fi


export DEBIAN_FRONTEND=noninteractive
echo "coping environement install script"
cp ./assets/install-env.sh /usr/local/install-env.sh

echo "make environement install script executable"
chmod +x /usr/local/install-env.sh

echo "running environement install script"
/usr/local/install-env.sh $PGPASSWORD
exitIfFails "install environnement fails"
echo "cleaning"
rm /usr/local/install-env.sh



#app
echo "copying Gisgraphy"
cp ./assets/gisgraphy/gisgraphy-latest.zip /usr/local/gisgraphy.zip
echo "copying gisgraphy installation script"
cp ./assets/install-gisgraphy.sh /usr/local/install-gisgraphy.sh
echo "making gisgraphy installation script executable"
chmod +x /usr/local/install-gisgraphy.sh
echo "installing Gisgraphy"
/usr/local/install-gisgraphy.sh $PGPASSWORD
exitIfFails "install Gisgraphy fails"
echo "installing Gisgraphy...done"
#clean
echo "cleaning"
rm /usr/local/install-gisgraphy.sh

echo "starting postgres"
service postgresql start

echo "************************************************************"
echo "installation complete you can now launch it :"
echo "cd /usr/local/gisgraphy;chmod +x *.sh;./launch.sh"
echo " "
echo "Then open a browser and go to http://localhost:8080/"
echo " "
echo "You can then import data or order some premium dump on https://premium.gisgraphy.com/"
echo "enjoy !"
echo "************************************************************"



