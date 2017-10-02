
this repo is still in draft

We always try to ease the installation.

We provide several docker images for you to run Gisgraphy easily. all this stuff is given "as is" and with any waranty of any kind.

Install Docker

Even if it is out of the scope of Gisgraphy, we provide a script (install-docker.sh) that we use, if you want to install docker on Ubuntu.

Images

We provide two images :
gisgraphyenv : which have Java and postgres / postgis installed and create the Gisgraphy Database. this images is to be used as a "base" images if you want to install Gisgraphy by you own (in other directory, with specific options,..). 
gisgraphysql : based on gisgraphyenv, it install Gisgraphy (in /usr/local) and setup the database (create the tables in the database, insert gisgraphy users, create index).

An oficial image of gisgraphysql can be found at https://hub.docker.com/r/gisgraphy/gisgraphyofficial/

for both images, you can personalize the postgres password by specifying an arg :

docker build -t gisgraphyenv --build-arg PGPASSWORD=mdppostgres .

to run your image in a container
docker run -td   gisgraphysql bash

or, to run your container and open a shell in it : 

docker run -td   gisgraphysql bash


To open a shell in your container after it is runinng

docker images=>DOCKERID
docker exec -t -i DOCKERID /bin/bash

for Gisgraphycommon you can personnalize the host at runtime :

docker run -td  -P --hostname=docker.gisgraphy.com  gisgraphysql bash

Volumes 

IMPORTANT : When you got an images, you can start a container from this image. once started, If you do some modifications on the files system (e.g : remove a file) of your container and then stop it, when you will restart the container you will got the file system as it was in the initial images (before you remove the files).Tthis is also true, if you run an import of data into Gisgraphy. After you stop your container, the data will be lost and you will have the file system identical to the initial image (before import)each time you restart your container.

If you want to keep your modifications (and import), you have to use volumes ar save your container state (commit / save). This is out of the scope of this tutorial and some documentation on how to use volumes can be found on the docker documentation.

If you save your container after the import is done, you will have the data stored in the container and will get it when you will start a container from this image. If you do an image with Gisgraphy + Data. you will get the data as it was after the import each time you restart your container. 

if you want to keep the log files, statistiques,and so on you have to use volumes.

Premium
if you buy a Dump of data, we provide you some tools to inject them. once done. don't forget to do a new image or save the state of your container.

You got two solutions:
build an image and then got the data in it. to build an image:
copy the files in assets/dump.
run the script.
you will get a container with the data.

start a container from the gisgraphy images,
run the bash script to inject it.
save your images






